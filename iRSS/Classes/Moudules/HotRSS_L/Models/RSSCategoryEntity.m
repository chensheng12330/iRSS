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
        self.strIconName    = @"icon";
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

-(id) initWithDictionary:(NSDictionary*) dict
{
    if (dict==NULL) {
        DLog(@"War2: Dictionary cannot is NULL.");
        return nil;
    }
    self = [self init];
    
    self.nId            = [[dict objectForKey:@"id"] integerValue];
    self.nRssNum        = [[dict objectForKey:@"rssNum"] integerValue];
    self.strName        = [dict objectForKey:@"name"];
    self.strIconName    = [dict objectForKey:@"iconName"];
    
    return self;
}

//KVC
-(void)setValuesForKeysWithDictionary:(NSDictionary *)keyedValues
{
    
}

-(NSString *)description
{
    NSString *superStr = [super description];
    superStr = [superStr stringByAppendingFormat:@"CateName:[%@], Icon:[%@], RSSNum:[%d]",_strName,_strIconName,_nRssNum];
    return superStr;
}

@end
