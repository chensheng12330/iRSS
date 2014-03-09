//
//  DBTestCase.m
//  iRSS
//
//  Created by sherwin on 14-3-7.
//  Copyright (c) 2014年 sherwin. All rights reserved.
//

#import "DBTestCase.h"
#import "RSSCategoryDao.h"

@implementation DBTestCase

-(void)testGo
{
    //[self testRSSCategoryDao];
    //[RSSCategoryEntity get];
}

////////Test isOK
/*!
 测试个数:
 开测时间:
 完测时间:
 完结状态:
 */
-(void) testRSSCategoryDao
{
    RSSCategoryDao *rsDao = [[RSSCategoryDao alloc] init];
    NSArray* ar= [rsDao getAllRSSCategorys];
    
    RSSCategoryEntity *rsctEntyU = [ar objectAtIndex:0];
    rsctEntyU.strIconName = @"testICON10086";
    rsctEntyU.strName     = @"testName10086";
    rsctEntyU.nRssNum     = 999;
    [rsDao updateRSSGroupRecWithRSEntity:rsctEntyU fileds:RGF_NAME|RGF_ICON|RGF_NUM];
 
    [rsDao delRSSGroupRecWithCateID:rsctEntyU.nId];
    
    return;
    RSSCategoryEntity *rsctEnty = [[RSSCategoryEntity alloc] init];
    rsctEnty.strName = @"测试数据2";
    rsctEnty.strIconName = @"adf厅在在人";
    rsctEnty.nRssNum = 10000000;
    BOOL ss = [rsDao addForRSSCategoryEntity:rsctEnty];
    
    int i;
    i++;
    return;
}

@end
