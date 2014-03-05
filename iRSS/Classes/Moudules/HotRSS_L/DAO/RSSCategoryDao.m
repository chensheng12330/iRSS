//
//  RSSCategory.m
//  iRSS
//
//  Created by sherwin on 14-3-5.
//  Copyright (c) 2014年 sherwin. All rights reserved.
//

#import "RSSCategoryDao.h"


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

@end
