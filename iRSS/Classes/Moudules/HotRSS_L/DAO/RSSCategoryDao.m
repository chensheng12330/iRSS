//
//  RSSCategory.m
//  iRSS
//
//  Created by sherwin on 14-3-5.
//  Copyright (c) 2014年 sherwin. All rights reserved.
//

#import "RSSCategoryDao.h"

@interface  RSSCategoryDao()

//表中是否存在该id记录
/*!
 @header 查找RSSGoup表数据，是否存在该ID值的记录
 @par    Par1 : nCateID 查询的category's id值
 @return (BOOL) 状态值，TRUE存在.
 */
-(BOOL) isExistID:(int) nCateID;

/*!
 @header 查找RSSGoup表数据，是否存在该Name值的记录
 @par    Par1 : nCateName 查询的category's name值
 @return (int) 状态值, >=0:存在该条记录的ID值  <0:未能查到.
 */
-(int) isExistName:(NSString*) nCateName;
@end

@implementation RSSCategoryDao

#pragma mark - DB Opertion

-(NSMutableArray*) getAllRSSCategorys
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

-(int) isExistName:(NSString*) nCateName
{
    FMDatabase *db = SHDBM.db;
    DBMQuickCheck(db && nCateName);
    FMResultSet *rs =nil;
    int nID=-1;
    
    rs = [db executeQuery:@"select count(*) from RSSGroup where name=? ",nCateName];
    if ([rs next]) {
        nID = [rs intForColumnIndex:0];
    }
    
    [rs close];
    return nID;
}

-(BOOL) addForRSSCategoryEntity:(RSSCategoryEntity*) rssCateEntity
{
    FMDatabase *db = SHDBM.db;
    DBMQuickCheck((db && rssCateEntity));
    
    if ([self isExistName:rssCateEntity.strName]) { DLog(@"War-5: DB The RSSGroup's Name is Exist."); return NO; }
    
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
    
    int newID = [self isExistName:rssCateEntity.strName];
    rssCateEntity.nId = newID;
    
    //get add db log
    DEBUG_DB_ERROR_LOG;

    return dbStatu;
}

-(BOOL) delRSSGroupRecWithCateID:(NSInteger) nID
{
    FMDatabase *db = SHDBM.db;
    DBMQuickCheck((db));
    
    if (nID<0) {
        DLog(@"War-5: DB The Category'ID not Ture.");
    }
    
    BOOL dbStatu =[db executeUpdate:@"delete from RSSGroup where id=? ",@(nID)];

    DEBUG_DB_ERROR_LOG;
    
    return dbStatu;
}

-(BOOL) updateRSSGroupRecWithRSEntity:(RSSCategoryEntity*) rssCateEntity fileds:(int) type
{
    FMDatabase *db = SHDBM.db;
    DBMQuickCheck((db));
    
    if (rssCateEntity==NULL || type<RGF_ID) {
        DLog(@"War-1: rssCateEntity canot is NULL, and type between RGF_ID and RGF_ICON.");
        return NO;
    }
    
    //BOOL bit1 = (BOOL)type & RGF_ID;
    BOOL can0 = NO;
    BOOL bit2 = (BOOL)type & RGF_NAME;
    BOOL bit3 = (BOOL)type & RGF_NUM;
    BOOL bit4 = (BOOL)type & RGF_ICON;

    
    NSMutableString *sqlStr = [[[NSMutableString alloc] initWithString:@"update RSSGroup set "] autorelease];
    if (bit2) {
        [sqlStr appendFormat:@"name='%@'",rssCateEntity.strName]; can0=YES;
    }
    
    if (can0) { [sqlStr appendString:@","];}
    
    if (bit3) {
        [sqlStr appendFormat:@"number=%ld ",(long)rssCateEntity.nRssNum]; can0=YES;
    }
    
    if (can0) { [sqlStr appendString:@","];}
    
    if (bit4) {
        [sqlStr appendFormat:@"icon_name='%@' ",rssCateEntity.strIconName];
    }
    
    [sqlStr appendFormat:@" where id=%ld ", (long)rssCateEntity.nId];
    
    BOOL dbStatu = [db executeUpdate:sqlStr];
   
    DEBUG_DB_ERROR_LOG;
    
    return dbStatu;
}
@end
