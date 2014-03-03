//
//  Common.h
//  MPRSP
//
//  Created by sherwin on 13-4-19.
//  Copyright (c) 2013年 SoftStone. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "MMDrawerController.h"
//#define MVC_MODE 1

#define COM [Common sharedCommon]




@interface Common : NSObject
@property (nonatomic, assign) MMDrawerController* mmDrawerControl;

+(Common*) sharedCommon;


-(NSString*) getDeviceID;

-(NSString*) getContentHtmlString:(NSString*) string Type:(int)type;


- (UIImage *) stretchiOS5:(NSString *)icon;
@end
