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
@end
