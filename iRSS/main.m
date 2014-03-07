//
//  main.m
//  iRSS
//
//  Created by sherwin on 13-12-2.
//  Copyright (c) 2013年 sherwin. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "AppDelegate.h"

//测试
#import "DBTestCase.h"

int main(int argc, char *argv[])
{
    DBTestCase *test = [[[DBTestCase alloc] init] autorelease];
    [test testGo];
    
    @autoreleasepool {
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
    }
}
