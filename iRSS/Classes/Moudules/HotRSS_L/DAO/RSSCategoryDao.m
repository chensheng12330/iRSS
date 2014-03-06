//
//  RSSCategory.m
//  iRSS
//
//  Created by sherwin on 14-3-5.
//  Copyright (c) 2014年 sherwin. All rights reserved.
//

#import "RSSCategoryDao.h"

@interface  RSSCategory()

//表中是否存在该id记录
-(BOOL) isExistID:(int) nCateID;
@end

@implementation RSSCategory

#pragma mark - DB Opertion

-(NSArray*) getAllRSSCategorys
{
    FMDatabase *db = SHDBM.db;
    DBMQuickCheck(db);
    FMResultSet *rs =nil;
    
    rs = [db executeQuery:@"select * from RSSGroup order by id asc "];
    
    //get query db log
    DEBUG_DB_ERROR_LOG;
    
    NSMutableArray *returnArrVal = [[[NSMutableArray alloc] init] autorelease];
    //get note'user info
    while ([rs next])
    {
        RSSCategoryEntity *rssCateEnty = [[RSSCategoryEntity alloc] init];
        
        rssCateEnty.nId      = [rs intForColumnIndex:0];
        rssCateEnty.strName  = [rs stringForColumnIndex:1];
        rssCateEnty.nRssNum  = [rs intForColumnIndex:2];
        rssCateEnty.strIconName  = [rs stringForColumnIndex:3];
        
        [returnArrVal addObject:rssCateEnty];
        [rssCateEnty release];
    }
    
    //close the result set.
    [rs close];
    
    return returnArrVal;
}

-(BOOL) isExistID:(int) nCateID
{
    FMDatabase *db = SHDBM.db;
    DBMQuickCheck(db && (nCateID>0));
    FMResultSet *rs =nil;
    rs = [db executeQuery:@"select count(*) from RSSGroup where id=?",@(nCateID)];
    if ([rs next]) {
        [rs close];
        return YES;
    }
    return NO;
}

-(BOOL) addForRSSCategoryEntity:(RSSCategoryEntity*) rssCateEntity
{
    FMDatabase *db = SHDBM.db;
    DBMQuickCheck((db && rssCateEntity));
    
    if (![self isExistID:rssCateEntity.nId]) { return NO; }
    
    //add to BlogListTable
    BOOL dbStatu =[db executeUpdate:@"insert into RSSGroup( \
     name, \
     number,\
     icon_name) \
     values (?,?,?)",
     rssCateEntity.strName,
     @(rssCateEntity.nRssNum),
     rssCateEntity.strIconName
     ];
    
    //获取id值，填入rsscateEntity中去
    
    //操作
    
    //get add db log
    DEBUG_DB_ERROR_LOG;

    return dbStatu;
}

-(BOOL) delRSSGroupRecWithCateID:(NSInteger) nID
{
    return YES;
}

-(BOOL) updateRSSGroupRecWithRSEntity:(RSSCategoryEntity*) rssCateEntity fileds:(int) type
{
    return YES;
}
@end
