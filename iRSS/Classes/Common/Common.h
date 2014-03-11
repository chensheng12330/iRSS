//
//  Common.h
//  MPRSP
//
//  Created by sherwin on 13-4-19.
//  Copyright (c) 2013年 SoftStone. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "MMDrawerController.h"
#import "RSSListViewController.h"

#import "RSSCategoryDao.h"
#import "RSSListDao.h"

#define COM [Common sharedCommon]


@interface Common : NSObject
@property (nonatomic, assign) MMDrawerController *mmDrawerControl;
@property (nonatomic, assign) RSSListViewController *viewController;


+(Common*) sharedCommon;


-(NSString*) getDeviceID;

-(NSString*) getContentHtmlString:(NSString*) string Type:(int)type;


- (UIImage *) stretchiOS5:(NSString *)icon;
- (UIImage *)scaleToSize:(UIImage *)img size:(CGSize)size;
@end
