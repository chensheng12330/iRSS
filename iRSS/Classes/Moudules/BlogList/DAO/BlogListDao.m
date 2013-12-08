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
    NSLog(@"feedParserDidStart");
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
    blogInfoEnty.strTitle     = [item.title stringByConvertingHTMLToPlainText];
    blogInfoEnty.strLink      = item.link;
    blogInfoEnty.strSummary   = [item.summary stringByConvertingHTMLToPlainText];
    blogInfoEnty.strContent   = item.content;
    blogInfoEnty.strIdentifier= item.identifier;
    blogInfoEnty.strEnclosures= item.enclosures;
    blogInfoEnty.deDate       = item.date;
    blogInfoEnty.deUpdated    = item.updated;
    
    [self saveBlogListInfoToDBWithBlogListEntity:blogInfoEnty];
    
    NSLog(@"%@",blogInfoEnty);
    [blogInfoEnty release];
    return;
}

- (void)feedParserDidFinish:(MWFeedParser *)parser
{
    SEL sentAction = @selector(requestFinished:dataOrigin:dataType:data:);
    if(_delegate!=NULL && [_delegate retainCount]>0 && [_delegate respondsToSelector:sentAction])
    {
        //解析完成,读取该RSS_ID的数据库数据
        NSArray *reuslt = [self synchGetBlogListFromDBWithRSSID:parser.nPID];
        [_delegate requestFinished:self dataOrigin:DO_DB dataType:DT_NSArray data:reuslt];
    }
    return;
}

- (void)feedParser:(MWFeedParser *)parser didFailWithError:(NSError *)error
{
    SEL sentAction = @selector(requestFailed:failedInfo:);
    if(_delegate!=NULL && [_delegate retainCount]>0 && [_delegate respondsToSelector:sentAction])
    {
        [_delegate requestFailed:self failedInfo:[error debugDescription] ];
    }
    return;
}

#pragma mark - DB Opertion

-(NSMutableArray*)  synchGetBlogListFromDBWithRSSID:(NSInteger) pid
{
    FMDatabase *db = SHDBM.db;
    DBMQuickCheck(db);
    FMResultSet *rs =nil;
    
    rs = [db executeQuery:@"select * from BlogInfoTable order by date desc "];
    
    //get query db log
    DEBUG_DB_ERROR_LOG;
    
    NSMutableArray *returnArrVal = [[[NSMutableArray alloc] init] autorelease];
    //get note'user info
    while ([rs next])
    {
        BlogListEntity *blogInfoEnty = [[BlogListEntity alloc] init];
        blogInfoEnty.nId      = [rs intForColumnIndex:0];
        blogInfoEnty.nRSSID   = [rs intForColumnIndex:1];
        blogInfoEnty.strTitle = [rs stringForColumnIndex:2];
        blogInfoEnty.strLink  = [rs stringForColumnIndex:3];
        blogInfoEnty.deDate   = [NSDate dateWithTimeIntervalSince1970:[rs doubleForColumnIndex:4]];
        blogInfoEnty.strSummary  = [rs stringForColumnIndex:5];
        blogInfoEnty.bIsRead  = [rs boolForColumnIndex:6];
        
        [returnArrVal addObject:blogInfoEnty];
        [blogInfoEnty release];
    }
    
    //close the result set.
    [rs close];
    
    return returnArrVal;
}

-(BOOL) saveBlogListInfoToDBWithBlogListEntity:(BlogListEntity*)blogListInfo
{
    FMDatabase *db = SHDBM.db;
    DBMQuickCheck((db && blogListInfo));
    
    //search blog_UNQ(link) from db,if exist，Compare blog_date, is new date ,save blog info to db.
    FMResultSet *rs =nil;
    rs = [db executeQuery:@"select id,date from BlogInfoTable where link=? and rss_id=?",blogListInfo.strLink, [NSNumber numberWithInteger:blogListInfo.nRSSID]];
    if ([rs next]) {
        NSObject *table_id = [rs objectForColumnIndex:0];
        NSDate   *oldDate = [NSDate dateWithTimeIntervalSince1970:[rs intForColumnIndex:1]];
        
        [rs close];
        
        if ([oldDate compare:blogListInfo.deDate]) {
            //更新记录
            [db executeUpdate:@"update BlogInfoTable set \
             title=?,\
             link=?,\
             date=?,\
             summary=?,\
             is_read=0\
             where id=? ",
             blogListInfo.strTitle,
             blogListInfo.strLink,
             [NSNumber numberWithInteger:[blogListInfo.deDate timeIntervalSince1970]],
             blogListInfo.strSummary,
             table_id];
        }
        
        DEBUG_DB_ERROR_LOG;
        return YES;
    }
    
    
    //add to BlogListTable
    [db executeUpdate:@"insert into BlogInfoTable( \
     rss_id,\
     title, \
     link,\
     date,\
     summary) \
     values (?,?,?,?,?)",
     [NSNumber numberWithInteger:blogListInfo.nRSSID],
     blogListInfo.strTitle,
     blogListInfo.strLink,
     [NSNumber numberWithInteger:[blogListInfo.deDate timeIntervalSince1970]],
     blogListInfo.strSummary
     ];
    
    //get add db log
    DEBUG_DB_ERROR_LOG;
    return TRUE;
}

-(BOOL) updateBlogInfoWithBlogListEntity:(BlogListEntity*)blogListInfo
{
    FMDatabase *db = SHDBM.db;
    DBMQuickCheck((db && blogListInfo));
    
    FMResultSet *rs =nil;
    rs = [db executeQuery:@"select id from BlogInfoTable where link=? and rss_id=?",blogListInfo.strLink, [NSNumber numberWithInteger:blogListInfo.nRSSID]];
    
    if ([rs next]) {
        
        NSObject *table_id = [rs objectForColumnIndex:0];
        [rs close];
        
        //更新记录
        [db executeUpdate:@"update BlogInfoTable set \
         title=?,\
         link=?,\
         date=?,\
         summary=?,\
         is_read=? \
         where id=? ",
         blogListInfo.strTitle,
         blogListInfo.strLink,
         [NSNumber numberWithInteger:[blogListInfo.deDate timeIntervalSince1970]],
         blogListInfo.strSummary,
         [NSNumber numberWithBool:blogListInfo.bIsRead],
         table_id];
        
        DEBUG_DB_ERROR_LOG;
    }
    return YES;
}

@end
