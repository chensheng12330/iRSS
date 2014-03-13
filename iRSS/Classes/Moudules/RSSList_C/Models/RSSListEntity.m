//
//  RSSListEntity.m
//  iRSS
//
//  Created by sherwin on 13-12-3.
//  Copyright (c) 2013年 sherwin. All rights reserved.
//

#import "RSSListEntity.h"

@implementation RSSListEntity

- (id)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (void)dealloc
{
    self.strRssName = nil;
    self.strRssUrl  = nil;
    self.strRssClass= nil;
    self.deAdd_time = nil;
    [super dealloc];
}

-(NSString*) description
{
    NSString *superStr = [super description];
    
    superStr = [superStr stringByAppendingFormat:@"RssName:[%@] RssUrl:[%@] RssClass:[%@] \n \
                unReadNum:[%ld] add_time:[%@]",_strRssName,_strRssUrl,_strRssClass,(long)_nUnReadNum,_deAdd_time];
    
    return superStr;
}
@end
