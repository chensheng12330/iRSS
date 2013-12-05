//
//  BlogListEntity.m
//  iRSS
//
//  Created by sherwin on 13-12-4.
//  Copyright (c) 2013年 sherwin. All rights reserved.
//

#import "BlogListEntity.h"

@implementation BlogListEntity

- (id)init
{
    self = [super init];
    if (self) {
        self.bIsRead = NO;
        self.nRSSID  = rand();
    }
    return self;
}

- (void)dealloc
{
    self.strTitle   = nil;
    self.strLink    = nil;
    self.strSummary = nil;
    self.strContent = nil;
    self.deDate     = nil;
    self.deUpdated  = nil;
    
    self.strEnclosures = nil;
    self.strIdentifier = nil;
    
    [super dealloc];
}

-(NSString*) description
{
    NSString *superStr = [super description];
    superStr = [superStr stringByAppendingFormat:@"nRSSID:[%d] \nTitle:[%@] Link:[%@] Summary:[%@] \nContent:[%@] Date:[%@] Update:[%@]\nEnclosures:[%@] Identiffire:[%@] isRead:[%d]",_nRSSID,_strTitle,_strLink,_strSummary,_strContent,_deDate,_deUpdated,_strEnclosures,_strIdentifier,_bIsRead];
    
    return superStr;
}
@end
