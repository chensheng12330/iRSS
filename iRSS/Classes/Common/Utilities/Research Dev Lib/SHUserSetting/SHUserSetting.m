//
//  SHUserSetting.m
//  TestFrame
//
//  Created by sherwin.chen on 13-6-16.
//  Copyright (c) 2013年 sherwin.chen. All rights reserved.
//

//版权所有：版权所有(C) 2013，陈胜 [Sherwin.Chen]
//系统名称：<#使用系统#>
//文件名称：<#文件名称#>
//作　　者：陈胜
//个人联系：chensheng12330@gmail.com or @checkchen2011 
//修改日期：<#修改日期#>
//完成日期：<#完成日期#>
//版   本：<#版本v0.0.0#>
//功能说明：<#说明#>
//---------------------------------------------------------

#import "SHUserSetting.h"

#define NUD [NSUserDefaults standardUserDefaults]

#define SHUserSettingKey (@"SHUserSettingKey")

static SHUserSetting *_shareUserSetting;

@interface SHUserSetting ()

- (void)registerDefaults;
@end

@implementation SHUserSetting

#pragma mark - object init
+ (SHUserSetting *)standardUserSetting
{
    @synchronized(self)
    {
        if (nil == _shareUserSetting ) {
            _shareUserSetting = [[self alloc] init];
            [_shareUserSetting registerDefaults];
        }
    }
    return _shareUserSetting;
}

+(id)alloc
{
    @synchronized([SHUserSetting class]) //线程访问加锁
    {
        NSAssert(_shareUserSetting == nil, @"Shewin: Attempted to allocate a second instance of a singleton.Please call +[sharedExerciseManage] method.");
        _shareUserSetting  = [super alloc];
        return _shareUserSetting;
    }
    return nil;
}

- (id)init
{
    self = [super init];
    if (self) {
        //database init
        //[self initDatabase];
    }
    return self;
}

+ (id)allocWithZone:(NSZone *)zone
{
    @synchronized(self) {
        if (nil == _shareUserSetting) {
            _shareUserSetting = [super allocWithZone:zone];
            return _shareUserSetting;
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
    [super dealloc];
    _shareUserSetting = nil;
}

- (oneway void)release
{
    // do nothing
    if( _shareUserSetting == nil)
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

//- (id)autorelease
//{
//    return self;
//}

- (NSUInteger)retainCount
{
    return NSUIntegerMax; // This is sooo not zero
}




#pragma mark - Method

- (void)registerDefaults
{
    /* First get the movie player settings defaults (scaling, controller type, background color,
	 repeat mode, application audio session) set by the user via the built-in iPhone Settings
	 application */
    
    NSString *testValue = [NUD stringForKey:SHUserSettingKey];
    if (testValue == nil)
    {
        // No default movie player settings values have been set, create them here based on our
        // settings bundle info.
        //
        // The values to be set for movie playback are:
        //
        //    - scaling mode (None, Aspect Fill, Aspect Fit, Fill)
        //    - controller style (None, Fullscreen, Embedded)
        //    - background color (Any UIColor value)
        //    - repeat mode (None, One)
		//    - use application audio session (On, Off)
		//	  - background image
        //占位标识
        
        
        //用户设置读取
        NSString *pathStr = [[NSBundle mainBundle] bundlePath];
        NSString *settingsBundlePath = [pathStr stringByAppendingPathComponent:@"Settings.bundle"];
        NSString *finalPath = [settingsBundlePath stringByAppendingPathComponent:@"Root.plist"];
        
        //
        NSDictionary *settingsDict = [NSDictionary dictionaryWithContentsOfFile:finalPath];
        NSArray *prefSpecifierArray = [settingsDict objectForKey:@"PreferenceSpecifiers"];
        
        //add
        //id defaultObj = nil;
        
        NSMutableDictionary *defaultDic = [[[NSMutableDictionary alloc] init] autorelease];
        
        [defaultDic setObject:@"SHUserSettingKey" forKey:SHUserSettingKey];
        
        NSDictionary *prefItem;
        for (prefItem in prefSpecifierArray)
        {
            NSString *keyValueStr = [prefItem objectForKey:@"Key"];
            id defaultValue = [prefItem objectForKey:@"DefaultValue"];
            
            if (defaultValue) {
                [defaultDic setObject:defaultValue forKey:keyValueStr];
            }
        }
  
        //NSDictionary *appDefaults = nil;
        /*
        // since no default values have been set, create them here
        NSDictionary *appDefaults =  [NSDictionary dictionaryWithObjectsAndKeys:
                                      scalingModeDefault, kScalingModeKey,
                                      controlStyleDefault, kControlStyleKey,
                                      backgroundColorDefault, kBackgroundColorKey,
									  repeatModeDefault, kRepeatModeKey,
									  useApplicationAudioSession, kUseApplicationAudioSessionKey,
                                      movieBackgroundImageDefault, kMovieBackgroundImageKey,
                                      ipConfig,kIPConfig,
									  nil];
        */
        [[NSUserDefaults standardUserDefaults] registerDefaults:defaultDic];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        //id val = [NUD objectForKey:@"appMode"];
    }
	else
	{
		/*
         Writes any modifications to the persistent domains to disk and updates all unmodified
         persistent domains to what is on disk.
         */
		[[NSUserDefaults standardUserDefaults] synchronize];
	}
}

- (id)objectForKey:(NSString *)defaultName
{
    return [NUD objectForKey:defaultName];
}

- (void)setObject:(id)value forKey:(NSString *)defaultName
{
    return [NUD setObject:value forKey:defaultName];
}

- (void)removeObjectForKey:(NSString *)defaultName
{
    return [NUD removeObjectForKey:defaultName];
}

@end
