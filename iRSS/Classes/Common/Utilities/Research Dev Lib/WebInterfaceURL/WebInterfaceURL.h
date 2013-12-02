//
//  WebInterfaceURL.h
//  MPRSP
//
//  Created by sherwin on 13-5-6.
//  Copyright (c) 2013年 SoftStone. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WebInterfaceURL : NSObject

+(NSString*) getHomePageURL;

+(NSString*) getSearchProductURL:(NSString *) productName;

+(NSString*) getQueryOrderListURL:(NSString *)userName  DevUDID:(NSString*) deviceID;

+(NSString*) getRegisterURL;

+(NSString*) getLoginURL;

+(NSString*) getAutoLoginURL;

+(NSString*) getQueryGoodListURL:(NSString *)classificationId;

+(NSString*) getsearchByMPRCodeURL:(NSString *)mprcode;

+(NSString*) getAccountCenterURL;

+(NSString*) getDeviceAuthURL:(NSString*) deviceID;

@end
