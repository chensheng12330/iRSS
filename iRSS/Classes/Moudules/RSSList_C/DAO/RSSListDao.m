//
//  RSSListDao.m
//  iRSS
//
//  Created by sherwin.chen on 13-12-2.
//  Copyright (c) 2013年 sherwin. All rights reserved.
//

#import "RSSListDao.h"
#import "RSSListEntity.h"

@implementation RSSListDao

- (id)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (void)dealloc
{
    [super dealloc];
}

#pragma mark - SH_DAO_Interface
-(NSMutableArray *) getBookRSSList:(int) rss_class_id
{
    FMDatabase *db = SHDBM.db;
    DBMQuickCheck(db);
    FMResultSet *rs =nil;
    
    rs = [db executeQuery:@"select * from RSSTable where rss_class=? order by add_time desc ",@(rss_class_id)];
    
    //get query db log
    DEBUG_DB_ERROR_LOG;
    
    NSMutableArray *returnArrVal = [[[NSMutableArray alloc] init] autorelease];
    //get note'user info
    while ([rs next])
    {
        
        RSSListEntity *rssListEnty = [[RSSListEntity alloc] init];
        rssListEnty.nId = [rs intForColumnIndex:0];
        rssListEnty.strRssName = [rs stringForColumnIndex:1];
        rssListEnty.strRssUrl  = [rs stringForColumnIndex:2];
        rssListEnty.strRssClass= [rs stringForColumnIndex:3];
        rssListEnty.nUnReadNum = [rs intForColumnIndex:4];
        rssListEnty.deAdd_time = [NSString ToNSDateWithDouble:[rs doubleForColumnIndex:5]];
        
        [returnArrVal addObject:rssListEnty];
        [rssListEnty release];
    }
    
    //close the result set.
    [rs close];
    
    return returnArrVal;
}

@end
