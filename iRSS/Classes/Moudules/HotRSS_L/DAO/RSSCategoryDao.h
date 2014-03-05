//
//  RSSCategory.h
//  iRSS
//
//  Created by sherwin on 14-3-5.
//  Copyright (c) 2014年 sherwin. All rights reserved.
//

//版权所有：版权所有(C) 2013，陈胜 [Sherwin.Chen]
//系统名称：iRSS
//文件名称：BlogListDao.h
//作　　者：陈胜
//个人联系：chensheng12330@gmail.com or @checkchen2011
//创建日期：13-12-4
//修改日期：<#修改日期#>
//完成日期：<#完成日期#>
//版   本：版本v0.0.1
//版本说明：/*版本说明*/
//功能说明：提供RSS源类目管理的操作接口
//---------------------------------------------------------

/* 功能函数
 1、RSS Category列表增、删、改、查
 */
#import "BaseDao.h"
#import "RSSCategoryEntity.h"

@interface RSSCategory : BaseDao

//******查找

/*!
 @header 获取所有的RSS目录列表
 @abstract BaseDao
 @return   NSArray[NSMutableArray]
 @see reference
 @author   sherwin.chen
 @version  1.0.0
 */
-(NSArray*) getAllRSSCategorys;

//增
/*!
 @header   增加一条记录到RSSGroup表中
 @par1     rssCateEntity RSS目录夹实体对象
 @abstract <#property#>
 @return   <#property#>
 @see      <#property#>
 @author   <#property#>
 @version  <#property#>
 */
-(BOOL) addForRSSCategoryEntity:(RSSCategoryEntity*) rssCateEntity;
@end
