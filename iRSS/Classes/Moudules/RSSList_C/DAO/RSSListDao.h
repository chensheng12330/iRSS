//
//  RSSListDao.h
//  iRSS
//
//  Created by sherwin.chen on 13-12-2.
//  Copyright (c) 2013年 sherwin. All rights reserved.
//

#import "BaseDao.h"

@interface RSSListDao : BaseDao

//获取已订阅RSS数据列表
-(NSMutableArray *) getBookRSSList;

//更新数据

//增加数据 
-(BOOL) addRSSWithURLString:(NSString *) strUrl;
-(BOOL) addRSSWithKeyword:(NSString *)strKey; //空格处理

//删除数据

/*!
 @method     1
 @abstract   2
 @discussion
 @param      4
 @param      5
 @result     6
 */
-(BOOL)deleteRSSWithRSSID:(NSString*) strID;

@end
