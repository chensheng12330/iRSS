//
//  SHUserSettingDao.m
//  MAE_Standard
//
//  Created by sherwin.chen on 13-6-18.
//  Copyright (c) 2013年 sherwin.chen. All rights reserved.
//

#import "SHUserSettingDao.h"



#define SHUSD_APP_MODE_KEY      (@"appMode")
#define SHUSD_CAROUS_Style_KEY  (@"carouselStyle")

#define SHUSD_UserName_KEY      (@"UserName_KEY")
#define SHUSD_Password_KEY      (@"Password_KEY")


@implementation SHUserSettingDao

#pragma mark - Method
+(MVC_MODE)getAppMVCMode
{
    NSNumber* value = [SHUS objectForKey:SHUSD_APP_MODE_KEY];
    
    if (value ==NULL) {
        value = [NSNumber numberWithInt:1];
    }
    
    return (MVC_MODE)[value intValue];
}


+(int) getCarouselStyle
{
    NSNumber* value = [SHUS objectForKey:SHUSD_CAROUS_Style_KEY];
    
    if (value ==NULL) {
        value = [NSNumber numberWithInt:0];
    }
    
    return [value intValue];
}


+(NSString*) getUserName
{
    NSString * value = [SHUS objectForKey:SHUSD_UserName_KEY];
    return value;
}

+(NSString*) getPassword
{
    NSString * value = [SHUS objectForKey:SHUSD_Password_KEY];
    return value;
}

+(void) setUserName:(NSString*)_name
{
    [SHUS setObject:_name forKey:SHUSD_UserName_KEY];
}

+(void) setPassword:(NSString*)_pwd
{
    [SHUS setObject:_pwd forKey:SHUSD_Password_KEY];
}


+(NSArray*) getClassArry
{
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"class_string" ofType:@"plist"];
    NSArray *classArray = [NSArray arrayWithContentsOfFile:filePath];
    return classArray;
}

+(NSArray*) getTabbarItemImages
{
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"tabbar_item_list" ofType:@"plist"];
    NSArray *classArray = [NSArray arrayWithContentsOfFile:filePath];
    return classArray;
}

+(NSArray*) getContactData
{
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"ContactDataFile" ofType:@"plist"];
    NSArray *contactData = [NSArray arrayWithContentsOfFile:filePath];
    return contactData;
}
@end
