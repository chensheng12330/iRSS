//
//  BaseViewController.m
//  MAE_Standard
//
//  Created by sherwin.chen on 13-6-30.
//  Copyright (c) 2013年 sherwin.chen. All rights reserved.
//

#import "BaseViewController.h"

@implementation BaseViewController

-(void) basenavItems_Clicked:(id) sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (id)init
{
    self = [super init];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self adjustViewSize];
    
    if(OSVersionIsAtLeastiOS7()){
        [[NSNotificationCenter defaultCenter]
         addObserver:self
         selector:@selector(contentSizeDidChangeNotification:)
         name:UIContentSizeCategoryDidChangeNotification
         object:nil];
    }
    
    
    //监控网络
    //[NetworkChangedNotification addDeviceNotificationObserver:self Selector:@selector(networkChange:)];
    
    return;
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter]
     removeObserver:self];
    [super dealloc];
    return;
}

-(void)contentSizeDidChangeNotification:(NSNotification*)notification{
    [self contentSizeDidChange:notification.userInfo[UIContentSizeCategoryNewValueKey]];
}

-(void)contentSizeDidChange:(NSString *)size{
    //Implement in subclass
}


-(void)networkChange:(NSNotification* )note
{
    
}

-(void) adjustViewSize
{
    CGRect frame = [UIScreen mainScreen].bounds;
    if ((DEVICE_IS_IPHONE5) && DEVICE_IS_IOS7) {
        if (self.navigationController.navigationBar==Nil || self.navigationController.navigationBarHidden) {
            frame.size.height -=20;
        }
    }
    else
    {
        if (self.navigationController.navigationBar==Nil || self.navigationController.navigationBarHidden) {

            frame.size.height -= 20 ;
        }
        else{
            frame.size.height -= 20 + 44;
        }
        
        if (DEVICE_IS_IOS7) {
            frame.origin.y += 20;
            frame.size.height += 20 ;
        }
    }
    self.view.frame = frame;
    
    self.view.backgroundColor = [UIColor whiteColor];
    return;
}
@end
