//
//  RSSCategoryEntity.m
//  iRSS
//
//  Created by sherwin on 14-3-5.
//  Copyright (c) 2014年 sherwin. All rights reserved.
//

#import "RSSCategoryEntity.h"

@implementation RSSCategoryEntity

- (id)init
{
    self = [super init];
    if (self) {
        self.strIconName    = nil;
        self.strName        = nil;
        self.nRssNum        = 0;
    }
    return self;
}

- (void)dealloc
{
    [super dealloc];
    self.nRssNum = 0;
    self.strName = nil;
    self.strIconName=nil;
}

-(NSString *)description
{
    NSString *superStr = [super description];
    superStr = [superStr stringByAppendingFormat:@"CateName:[%@], Icon:[%@], RSSNum:[%d]",_strName,_strIconName,_nRssNum];
    return superStr;
}

@end
