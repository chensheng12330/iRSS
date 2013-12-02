//
//  WebInterfaceURL.m
//  MPRSP
//
//  Created by sherwin on 13-5-6.
//  Copyright (c) 2013年 SoftStone. All rights reserved.
//

#import "WebInterfaceURL.h"

#define WEB_URL_HOST (@"http://172.16.10.155:8080/")

@implementation WebInterfaceURL

+(NSString*) getHomePageURL
{
    NSString *path = @"mpr/seb-portal-home/mvc/index";
    return [NSString stringWithFormat:@"%@%@",WEB_URL_HOST,path];
}

+(NSString*) getSearchProductURL:(NSString *) productName
{
    NSString *path = @"mpr/seb-portal-home/mvc/pcmprgoods?gName=";
    return [NSString stringWithFormat:@"%@%@%@",WEB_URL_HOST,path,productName];
}

+(NSString*) getQueryOrderListURL:(NSString *)userName  DevUDID:(NSString*) deviceID
{
    NSString *path = @"mpr/pc/api/mprsp/querydp?";
    return [NSString stringWithFormat:@"%@%@userName=%@&deviceID=%@",WEB_URL_HOST,path,userName,deviceID];
}

+(NSString*) getRegisterURL
{
    NSString *path = @"mpr/seb-portal-user/mprWorldLogin.html";
    return [NSString stringWithFormat:@"%@%@",WEB_URL_HOST,path];
}

+(NSString*) getLoginURL
{
    NSString *path = @"mpr/pc/api/mprsp/login?";
    return [NSString stringWithFormat:@"%@%@",WEB_URL_HOST,path];
}

+(NSString*) getAutoLoginURL
{
    NSString *path = @"mpr/seb-portal-user/userLogin.html";
    return [NSString stringWithFormat:@"%@%@",WEB_URL_HOST,path];
}

+(NSString*) getQueryGoodListURL:(NSString *)classificationId
{
    NSString *path = @"mpr/seb-portal-home/mvc/pcproductgoodsList?classificationId=";
    return [NSString stringWithFormat:@"%@%@%@",WEB_URL_HOST,path,classificationId];
}

+(NSString*) getsearchByMPRCodeURL:(NSString *)mprcode
{
    NSString *path = @"mpr/seb-portal-home/mvc/isbngoodslist?mprcode=";
    return [NSString stringWithFormat:@"%@%@%@",WEB_URL_HOST,path,mprcode];
}

+(NSString*) getAccountCenterURL
{
    NSString *path = @"mpr/seb-portal-user/mvc/user";
    return [NSString stringWithFormat:@"%@%@",WEB_URL_HOST,path];
}

+(NSString*) getDeviceAuthURL:(NSString*) deviceID
{
    NSString *path = @"mpr/pc/api/mprsp/deviceauth?deviceID=";
    return [NSString stringWithFormat:@"%@%@%@",WEB_URL_HOST,path,deviceID];
}
@end
