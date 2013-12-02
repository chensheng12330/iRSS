//
//  UIDevice+Extend.m
//  TestFrame
//
//  Created by sherwin.chen on 13-6-5.
//  Copyright (c) 2013年 sherwin.chen. All rights reserved.
//

#import "UIDevice+Extend.h"


#include <netdb.h>
#include <net/if.h>
#include <ifaddrs.h>
#include <net/if_dl.h>
#include <arpa/inet.h>
#include <sys/sysctl.h>
#import <SystemConfiguration/SystemConfiguration.h>

@implementation UIDevice (Extend)


SCNetworkConnectionFlags connectionFlags;
SCNetworkReachabilityRef reachability;

// Matt Brown's get WiFi IP addy solution
// http://mattbsoftware.blogspot.com/2009/04/how-to-get-ip-address-of-iphone-os-v221.html

#pragma mark - NetWorkState
+ (NSString *) localWiFiIPAddress
{
	BOOL success;
	struct ifaddrs * addrs;
	const struct ifaddrs * cursor;
	
	success = getifaddrs(&addrs) == 0;
	if (success) {
		cursor = addrs;
		while (cursor != NULL) {
			// the second test keeps from picking up the loopback address
			if (cursor->ifa_addr->sa_family == AF_INET && (cursor->ifa_flags & IFF_LOOPBACK) == 0)
			{
				NSString *name = [NSString stringWithUTF8String:cursor->ifa_name];
				if ([name isEqualToString:@"en0"])  // Wi-Fi adapter
					return [NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in *)cursor->ifa_addr)->sin_addr)];
			}
			cursor = cursor->ifa_next;
		}
		freeifaddrs(addrs);
	}
	return nil;
}

+ (NSString *) getWiFiMacAddress
{
    int                 mib[6];
    size_t              len;
    char                *buf;
    unsigned char       *ptr;
    struct if_msghdr    *ifm;
    struct sockaddr_dl  *sdl;
    mib[0] = CTL_NET;
    mib[1] = AF_ROUTE;
    mib[2] = 0;    
    mib[3] = AF_LINK;    
    mib[4] = NET_RT_IFLIST;    
    if ((mib[5] = if_nametoindex("en0")) == 0) {    
        printf("Error: if_nametoindex error/n");        
        return NULL;
    }    
    if (sysctl(mib, 6, NULL, &len, NULL, 0) < 0) {
       // printf("Error: sysctl, take 1/n");
        return NULL;
    }
    if ((buf = malloc(len)) == NULL) {        
        //printf("Could not allocate memory. error!/n");
        return NULL;
    }
    
    if (sysctl(mib, 6, buf, &len, NULL, 0) < 0) {
        //printf("Error: sysctl, take 2");
        free(buf);
        return NULL;       
    }
    
    ifm = (struct if_msghdr *)buf;    
    sdl = (struct sockaddr_dl *)(ifm + 1);    
    ptr = (unsigned char *)LLADDR(sdl);    
    // NSString *outstring = [NSString stringWithFormat:@"%02x:%02x:%02x:%02x:%02x:%02x", *ptr, *(ptr+1), *(ptr+2), *(ptr+3), *(ptr+4), *(ptr+5)];
    
    NSString *outstring = [NSString stringWithFormat:@"%02x%02x%02x%02x%02x%02x", *ptr, *(ptr+1), *(ptr+2), *(ptr+3), *(ptr+4), *(ptr+5)];
    free(buf);
    
    return [outstring uppercaseString];
}

#pragma mark Checking Connections

+ (void) pingReachabilityInternal
{
	BOOL ignoresAdHocWiFi = NO;
	struct sockaddr_in ipAddress;
	bzero(&ipAddress, sizeof(ipAddress));
	ipAddress.sin_len = sizeof(ipAddress);
	ipAddress.sin_family = AF_INET;
	ipAddress.sin_addr.s_addr = htonl(ignoresAdHocWiFi ? INADDR_ANY : IN_LINKLOCALNETNUM);
    
    // Recover reachability flags
    SCNetworkReachabilityRef defaultRouteReachability = SCNetworkReachabilityCreateWithAddress(kCFAllocatorDefault, (struct sockaddr *)&ipAddress);
    BOOL didRetrieveFlags = SCNetworkReachabilityGetFlags(defaultRouteReachability, &connectionFlags);
    CFRelease(defaultRouteReachability);
	if (!didRetrieveFlags)
        printf("Error. Could not recover network reachability flags\n");
}

+ (BOOL) networkAvailable
{
	[self pingReachabilityInternal];
	BOOL isReachable = ((connectionFlags & kSCNetworkFlagsReachable) != 0);
    BOOL needsConnection = ((connectionFlags & kSCNetworkFlagsConnectionRequired) != 0);
    return (isReachable && !needsConnection) ? YES : NO;
}

+ (BOOL) activeWWAN
{
	if (![self networkAvailable]) return NO;
	return ((connectionFlags & kSCNetworkReachabilityFlagsIsWWAN) != 0);
}

+ (BOOL) activeWLAN
{
	return ([UIDevice localWiFiIPAddress] != nil);
}


#pragma mark Checking Connections

#pragma mark Monitoring reachability
static void ReachabilityCallback(SCNetworkReachabilityRef target, SCNetworkConnectionFlags flags, void* info)
{
	NSAutoreleasePool *pool = [NSAutoreleasePool new];
	[(id)info performSelector:@selector(reachabilityChanged)];
	[pool release];
}

+ (BOOL) scheduleReachabilityWatcher: (id) watcher
{
	if (![watcher conformsToProtocol:@protocol(ReachabilityWatcher)])
	{
		NSLog(@"Watcher must conform to ReachabilityWatcher protocol. Cannot continue.");
		return NO;
	}
	
	[self pingReachabilityInternal];
    
	SCNetworkReachabilityContext context = {0, watcher, NULL, NULL, NULL};
	if(SCNetworkReachabilitySetCallback(reachability, ReachabilityCallback, &context))
	{
		if(!SCNetworkReachabilityScheduleWithRunLoop(reachability, CFRunLoopGetCurrent(), kCFRunLoopCommonModes))
		{
			NSLog(@"Error: Could not schedule reachability");
			SCNetworkReachabilitySetCallback(reachability, NULL, NULL);
			return NO;
		}
	}
	else
	{
		NSLog(@"Error: Could not set reachability callback");
		return NO;
	}
	
	return YES;
}

+ (void) unscheduleReachabilityWatcher
{
	SCNetworkReachabilitySetCallback(reachability, NULL, NULL);
	if (SCNetworkReachabilityUnscheduleFromRunLoop(reachability, CFRunLoopGetCurrent(), kCFRunLoopCommonModes))
		NSLog(@"Unscheduled reachability");
	else
		NSLog(@"Error: Could not unschedule reachability");
	
	CFRelease(reachability);
	reachability = nil;
}

#ifdef SUPPORTS_UNDOCUMENTED_API
#define SBSERVPATH  "/System/Library/PrivateFrameworks/SpringBoardServices.framework/SpringBoardServices"
#define UIKITPATH "/System/Library/Framework/UIKit.framework/UIKit"

// Don't use this code in real life, boys and girls. It is not App Store friendly.
// It is, however, really nice for testing callbacks
//+ (void) setAPMode: (BOOL) yorn
//{
//	mach_port_t *thePort;
//	void *uikit = dlopen(UIKITPATH, RTLD_LAZY);
//	int (*SBSSpringBoardServerPort)() = dlsym(uikit, "SBSSpringBoardServerPort");
//	thePort = (mach_port_t *)SBSSpringBoardServerPort();
//	dlclose(uikit);
//	
//	// Link to SBSetAirplaneModeEnabled
//	void *sbserv = dlopen(SBSERVPATH, RTLD_LAZY);
//	int (*setAPMode)(mach_port_t* port, BOOL yorn) = dlsym(sbserv, "SBSetAirplaneModeEnabled");
//	setAPMode(thePort, yorn);
//	dlclose(sbserv);
//}
#endif

//#pragma mark Class IP and Host Utilities
//+ (NSString *) stringFromAddress: (const struct sockaddr *) address
//{
//	if(address && address->sa_family == AF_INET) {
//		const struct sockaddr_in* sin = (struct sockaddr_in*) address;
//		return [NSString stringWithFormat:@"%@:%d", [NSString stringWithUTF8String:inet_ntoa(sin->sin_addr)], ntohs(sin->sin_port)];
//	}
//	
//	return nil;
//}
//
//// Direct from Apple. Thank you Apple
//+ (BOOL)addressFromString:(NSString *)IPAddress address:(struct sockaddr_in *)address
//{
//	if (!IPAddress || ![IPAddress length]) {
//		return NO;
//	}
//	
//	memset((char *) address, sizeof(struct sockaddr_in), 0);
//	address->sin_family = AF_INET;
//	address->sin_len = sizeof(struct sockaddr_in);
//	
//	int conversionResult = inet_aton([IPAddress UTF8String], &address->sin_addr);
//	if (conversionResult == 0) {
//		NSAssert1(conversionResult != 1, @"Failed to convert the IP address string into a sockaddr_in: %@", IPAddress);
//		return NO;
//	}
//	
//	return YES;
//}

+ (NSString *) hostname
{
	char baseHostName[256]; // Thanks, Gunnar Larisch
	int success = gethostname(baseHostName, 255);
	if (success != 0) return nil;
	baseHostName[255] = '\0';
	
#if !TARGET_IPHONE_SIMULATOR
	return [NSString stringWithFormat:@"%s.local", baseHostName];
#else
 	return [NSString stringWithFormat:@"%s", baseHostName];
#endif
}

+ (NSString *) getIPAddressForHost: (NSString *) theHost
{
	struct hostent *host = gethostbyname([theHost UTF8String]);
    if (!host) {herror("resolv"); return NULL; }
	struct in_addr **list = (struct in_addr **)host->h_addr_list;
	NSString *addressString = [NSString stringWithCString:inet_ntoa(*list[0]) encoding:NSUTF8StringEncoding];
	return addressString;
}


+ (NSString *) localIPAddress
{
	struct hostent *host = gethostbyname([[self hostname] UTF8String]);
    if (!host) {herror("resolv"); return nil;}
    struct in_addr **list = (struct in_addr **)host->h_addr_list;
	return [NSString stringWithCString:inet_ntoa(*list[0]) encoding:NSUTF8StringEncoding];
}

+ (NSString *) whatismyipdotcom
{
	NSError *error;
    NSURL *ipURL = [NSURL URLWithString:@"http://www.whatismyip.com/automation/n09230945.asp"];
    NSString *ip = [NSString stringWithContentsOfURL:ipURL encoding:NSUTF8StringEncoding error:&error];
	return ip ? ip : [error localizedDescription];
}

#pragma mark - Device Info
+(BOOL) judgeDeviceOrientation
{
    return (BOOL)UIDeviceOrientationIsLandscape([UIDevice currentDevice].orientation);
}

//设备信息
+(NSDictionary*) myDeviceSystemInfo
{
    NSMutableDictionary *dicDeviceInfo = [[NSMutableDictionary alloc] init];
    
    UIDevice *device = [UIDevice currentDevice];
    
    [dicDeviceInfo setObject:device.model           forKey:@"model"];
    [dicDeviceInfo setObject:device.name            forKey:@"user_name"];
    [dicDeviceInfo setObject:device.systemName      forKey:@"systemName"];
    [dicDeviceInfo setObject:device.systemVersion   forKey:@"systemVersion"];
    
    
    [dicDeviceInfo setObject:[NSString stringWithFormat:@"Battery level: %0.2f", [[UIDevice currentDevice] batteryLevel] * 100] forKey:@"batteryLevel"];
    
    NSArray *stateArray = [NSArray arrayWithObjects: @"Unknown", @"not plugged into a charging source", @"charging", @"full", nil];
    [dicDeviceInfo setObject:[NSString stringWithFormat:@"Battery state: %@",[stateArray objectAtIndex:[[UIDevice currentDevice] batteryState]]] forKey:@"batteryState"];
    
    return [dicDeviceInfo autorelease];
}

+(NSDictionary*) myDeviceStorageInfo
{
    NSMutableDictionary *dicDeviceInfo = [[NSMutableDictionary alloc] init];
    
    NSFileManager *fm = [NSFileManager defaultManager];
    
    NSDictionary *fattributes = [fm attributesOfFileSystemForPath:NSHomeDirectory() error:nil]; //[fm fileSystemAttributesAtPath:NSHomeDirectory()];
    
    [dicDeviceInfo setObject:[fattributes objectForKey:NSFileSystemSize] forKey:NSFileSystemSize];
    [dicDeviceInfo setObject:[fattributes objectForKey:NSFileSystemFreeSize] forKey:NSFileSystemSize];

    return [dicDeviceInfo autorelease];
    
}

+(NSString*) getSystemInfo
{
    UIDevice *device = [UIDevice currentDevice];
    return [NSString stringWithFormat:@"%@ %@",device.model, device.systemVersion];
}

#pragma mark - SH Device Screen Size
/******************************************************************************
 函数名称 : + (UIDeviceResolution) currentResolution
 函数描述 : 获取当前分辨率
 
 输入参数 : N/A
 输出参数 : N/A
 返回参数 : N/A
 备注信息 :
 ******************************************************************************/
+ (UIDeviceResolution) currentResolution {
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone){
        if ([[UIScreen mainScreen] respondsToSelector: @selector(scale)]) {
            CGSize result = [[UIScreen mainScreen] bounds].size;
            result = CGSizeMake(result.width * [UIScreen mainScreen].scale, result.height * [UIScreen mainScreen].scale);
            if (result.height <= 480.0f)
                return UIDevice_iPhoneStandardRes;
            return (result.height > 960 ? UIDevice_iPhoneTallerHiRes : UIDevice_iPhoneHiRes);
        } else
            return UIDevice_iPhoneStandardRes;
    } else
        return (([[UIScreen mainScreen] respondsToSelector: @selector(scale)]) ? UIDevice_iPadHiRes : UIDevice_iPadStandardRes);
}

/******************************************************************************
 函数名称 : + (UIDeviceResolution) currentResolution
 函数描述 : 当前是否运行在iPhone5端
 输入参数 : N/A
 输出参数 : N/A
 返回参数 : N/A
 备注信息 :
 ******************************************************************************/
+ (BOOL)isRunningOniPhone5{
    if ([self currentResolution] == UIDevice_iPhoneTallerHiRes) {
        return YES;
    }
    return NO;
}

/******************************************************************************
 函数名称 : + (BOOL)isRunningOniPhone
 函数描述 : 当前是否运行在iPhone端
 输入参数 : N/A
 输出参数 : N/A
 返回参数 : N/A
 备注信息 :
 ******************************************************************************/
+ (BOOL)isRunningOniPhone{
    return (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone);
}
@end
