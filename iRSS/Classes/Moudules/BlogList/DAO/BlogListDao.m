//
//  BlogListDao.m
//  iRSS
//
//  Created by sherwin on 13-12-4.
//  Copyright (c) 2013年 sherwin. All rights reserved.
//

#import "BlogListDao.h"

@implementation BlogListDao

-(void) asynGetBlogListWithRSSUrl:(NSString*) strRssUrl
{
    MWFeedParser *feedPar = [[MWFeedParser alloc] initWithFeedURL:[NSURL URLWithString:strRssUrl]];
    [mkNetReqEngine enqueueOperation:feedPar];
}
@end
