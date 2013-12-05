//
//  BlogListDao.m
//  iRSS
//
//  Created by sherwin on 13-12-4.
//  Copyright (c) 2013年 sherwin. All rights reserved.
//

#import "BlogListDao.h"

@implementation BlogListDao

-(void) asynGetBlogListWithRSSUrl:(NSString*) strRssUrl  RSSID:(NSInteger) pid
{
    MWFeedParser *feedPar = [[MWFeedParser alloc] initWithFeedURL:[NSURL URLWithString:strRssUrl]];
    feedPar.nPID = pid;
    feedPar.delegate = self;
    [MKNET enqueueOperation:feedPar];
}

- (void)feedParserDidStart:(MWFeedParser *)parser
{
    
}

- (void)feedParser:(MWFeedParser *)parser didParseFeedInfo:(MWFeedInfo *)info
{
    NSLog(@"%@",[info description]);
}

- (void)feedParser:(MWFeedParser *)parser didParseFeedItem:(MWFeedItem *)item
{
    //插入到数据库
    NSInteger rssID = parser.nPID;
    BlogListEntity *blogInfoEnty = [[BlogListEntity alloc] init];
    blogInfoEnty.nRSSID       = rssID;
    blogInfoEnty.strTitle     = item.title;
    blogInfoEnty.strLink      = item.link;
    blogInfoEnty.strSummary   = item.summary;
    blogInfoEnty.strContent   = item.content;
    blogInfoEnty.strIdentifier= item.identifier;
    blogInfoEnty.strEnclosures= item.enclosures;
    
    [self saveBlogListInfoToDBWithBlogListEntity:blogInfoEnty];
    [blogInfoEnty release];
    return;
}

- (void)feedParserDidFinish:(MWFeedParser *)parser
{
    
}

- (void)feedParser:(MWFeedParser *)parser didFailWithError:(NSError *)error
{
    
}

#pragma mark - DB Opertion
-(BOOL) saveBlogListInfoToDBWithBlogListEntity:(BlogListEntity*)blogListInfo
{
    FMDatabase *db = SHDBM.db;
    DBMQuickCheck(db);
    
    //add to BlogListTable
    [db executeUpdate:@"insert into BlogList( \
     id, \
     title, \
     link,\
     date,\
     updated,\
     summary,\
     content,\
     rss_id) \
     values (?,?,?,?,?,?,?,?)",
     @"'NULL'",
     blogListInfo.strTitle,
     blogListInfo.strLink,
     [NSNumber numberWithInteger:[blogListInfo.deDate timeIntervalSince1970]],
     [NSNumber numberWithInteger:[blogListInfo.deUpdated timeIntervalSince1970]],
     blogListInfo.strSummary,
     blogListInfo.strContent,
     [NSNumber numberWithInteger:blogListInfo.nRSSID]
     ];
    
    //get add db log
    DEBUG_DB_ERROR_LOG;
    return TRUE;
}

@end
