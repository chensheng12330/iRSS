//
//  SHAPPResource.m
//  TestFrame
//
//  Created by sherwin.chen on 13-6-5.
//  Copyright (c) 2013年 sherwin.chen. All rights reserved.
//

#import "SHAPPResource.h"

static SHAPPResource *_shareResource=nil;

@implementation SHAPPResource

+(id) shareAppResource
{
    @synchronized(self)
    {
        if (nil == _shareResource ) {
            _shareResource = [[self alloc] init];
        }
    }
    return _shareResource;
}

+(id)alloc
{
    @synchronized([SHAPPResource class]) //线程访问加锁
    {
        NSAssert(_shareResource == nil, @"Shewin: Attempted to allocate a second instance of a singleton.Please call +[sharedExerciseManage] method.");
        _shareResource  = [super alloc];
        return _shareResource;
    }
    return nil;
}

- (id)init
{
    self = [super init];
    if (self) {
        //database init
    }
    return self;
}

+ (id)allocWithZone:(NSZone *)zone
{
    @synchronized(self) {
        if (nil == _shareResource) {
            _shareResource = [super allocWithZone:zone];
            return _shareResource;
        }
    }
    return nil;
}

- (id)copyWithZone:(NSZone *)zone
{
    return self;
}

- (void)dealloc
{
    /*
     other property release
     */
    if (_shareResource==nil) { return;}
    
    [super dealloc];
    
    _shareResource = nil;
}

- (oneway void)release
{
    // do nothing
    if(_shareResource==nil)
    {
        NSLog(@"SHDBManage: retainCount is 0.");
        return;
    }
    [super release];
    return;
}

- (id)retain
{
    return self;
}

- (id)autorelease
{
    return self;
}

- (NSUInteger)retainCount
{
    return NSUIntegerMax; // This is sooo not zero
}


-(NSString*) NSLocalizedImageName:(NSString*)imageName
{
    return imageName;
    
    NSString *bundlePath = nil;
    if (IMAGE_KIND) {
        bundlePath = [NSString stringWithFormat:@"aa.bundle/%@", imageName];
    }
    else
    {
        bundlePath = [NSString stringWithFormat:@"bb.bundle/%@", imageName];
    }
    
    return bundlePath;
}

-(UIFont*)   NSLocalizedFontWithName:(NSString *) name Size:(CGFloat) size
{
    return [UIFont systemFontOfSize:size];
}

/*
 + (UIColor *)blackColor;      // 0.0 white
 + (UIColor *)darkGrayColor;   // 0.333 white
 + (UIColor *)lightGrayColor;  // 0.667 white
 + (UIColor *)whiteColor;      // 1.0 white
 + (UIColor *)grayColor;       // 0.5 white
 + (UIColor *)redColor;        // 1.0, 0.0, 0.0 RGB
 + (UIColor *)greenColor;      // 0.0, 1.0, 0.0 RGB
 + (UIColor *)blueColor;       // 0.0, 0.0, 1.0 RGB
 + (UIColor *)cyanColor;       // 0.0, 1.0, 1.0 RGB
 + (UIColor *)yellowColor;     // 1.0, 1.0, 0.0 RGB
 + (UIColor *)magentaColor;    // 1.0, 0.0, 1.0 RGB
 + (UIColor *)orangeColor;     // 1.0, 0.5, 0.0 RGB
 + (UIColor *)purpleColor;     // 0.5, 0.0, 0.5 RGB
 + (UIColor *)brownColor;      // 0.6, 0.4, 0.2 RGB
 + (UIColor *)clearColor;      // 0.0 white, 0.0 alpha
 */
-(UIColor*)  NSLocalizedColorWithName:(NSString *) name
{
    if ([name isEqualToString:@"black"]) {
        return [UIColor blackColor];
    }
    else if ([name isEqualToString:@"dark"])
    {
        return [UIColor darkGrayColor];
    }
    else if ([name isEqualToString:@"light"])
    {
        return [UIColor lightGrayColor];
    }
    else if ([name isEqualToString:@"white"])
    {
        return [UIColor whiteColor];
    }
    else if ([name isEqualToString:@"gary"])
    {
        return [UIColor grayColor];
    }
    else if ([name isEqualToString:@"red"])
    {
        return [UIColor redColor];
    }
    else if ([name isEqualToString:@"gree"])
    {
        return [UIColor greenColor];
    }
    else if ([name isEqualToString:@"blue"])
    {
        return [UIColor blueColor];
    }
    else if ([name isEqualToString:@"clear"])
    {
        return [UIColor clearColor];
    }
    return [UIColor scrollViewTexturedBackgroundColor];
}
@end
