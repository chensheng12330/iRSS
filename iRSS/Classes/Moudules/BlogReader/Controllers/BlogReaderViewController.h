//
//  BlogReaderViewController.h
//  iRSS
//
//  Created by sherwin on 13-12-2.
//  Copyright (c) 2013年 sherwin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HMSideMenu.h"
#import "QuadCurveMenu.h"

@interface BlogReaderViewController : BaseViewController
<UIWebViewDelegate,UIGestureRecognizerDelegate,QuadCurveMenuDelegate>

@property (nonatomic, retain) NSString *strUrlLink;
@end
