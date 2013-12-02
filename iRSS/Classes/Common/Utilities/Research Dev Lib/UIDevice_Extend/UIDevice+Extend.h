//
//  UIDevice+Extend.h
//  TestFrame
//
//  Created by sherwin.chen on 13-6-5.
//  Copyright (c) 2013年 sherwin.chen. All rights reserved.
//
/*
 设备能力
 附加库：SystemConfiguration.framework
 */
#import <UIKit/UIKit.h>

#define SUPPORTS_UNDOCUMENTED_API	1

#define IS_IPAD  ([[UIDevice currentDevice] respondsToSelector:@selector(userInterfaceIdiom)] &&[[UIDevice currentDevice] userInterfaceIdion] == UIUserInterfaceIdiomPad)


typedef enum {
    // iPhone 1,3,3GS 标准分辨率(320x480px)
    UIDevice_iPhoneStandardRes      = 1,
    // iPhone 4,4S 高清分辨率(640x960px)
    UIDevice_iPhoneHiRes            = 2,
    // iPhone 5 高清分辨率(640x1136px)
    UIDevice_iPhoneTallerHiRes      = 3,
    // iPad 1,2 标准分辨率(1024x768px)
    UIDevice_iPadStandardRes        = 4,
    // iPad 3 High Resolution(2048x1536px)
    UIDevice_iPadHiRes              = 5
}UIDeviceResolution;


@protocol ReachabilityWatcher <NSObject>
- (void) reachabilityChanged;
@end

@interface UIDevice (Extend)

//section 1
+ (BOOL) scheduleReachabilityWatcher: (id) watcher;
+ (void) unscheduleReachabilityWatcher;

#ifdef SUPPORTS_UNDOCUMENTED_API
// Don't use this code in real life, boys and girls. It is not App Store friendly.
// It is, however, really nice for testing callbacks
//+ (void) setAPMode: (BOOL) yorn;
#endif

//section 2
+ (BOOL) networkAvailable;
+ (BOOL) activeWLAN;
+ (BOOL) activeWWAN;


//section 3

+ (NSString *) hostname;
+ (NSString *) getIPAddressForHost: (NSString *) theHost;
+ (NSString *) localIPAddress;
+ (NSString *) localWiFiIPAddress;
+ (NSString *) whatismyipdotcom;
+ (NSString *) getWiFiMacAddress;

//section 4
//判断屏幕是否是横向[1] 竖向[0]
+(BOOL) judgeDeviceOrientation;

//设备信息
+(NSDictionary*) myDeviceSystemInfo;

+(NSDictionary*) myDeviceStorageInfo;

+(NSString*) getSystemInfo;
//section 5

/******************************************************************************
 函数名称 : + (UIDeviceResolution) currentResolution
 函数描述 : 获取当前分辨率
 输入参数 : N/A
 输出参数 : N/A
 返回参数 : N/A
 备注信息 :
 ******************************************************************************/
+ (UIDeviceResolution) currentResolution;

/******************************************************************************
 函数名称 : + (UIDeviceResolution) currentResolution
 函数描述 : 当前是否运行在iPhone5端
 输入参数 : N/A
 输出参数 : N/A
 返回参数 : N/A
 备注信息 :
 ******************************************************************************/
+ (BOOL)isRunningOniPhone5;

/******************************************************************************
 函数名称 : + (BOOL)isRunningOniPhone
 函数描述 : 当前是否运行在iPhone端
 输入参数 : N/A
 输出参数 : N/A
 返回参数 : N/A
 备注信息 :
 ******************************************************************************/
+ (BOOL)isRunningOniPhone;
@end
