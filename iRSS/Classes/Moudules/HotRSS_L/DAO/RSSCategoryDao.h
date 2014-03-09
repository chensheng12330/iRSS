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

typedef enum
{
    RGF_ID  =1<<0,
    RGF_NAME=1<<1,
    RGF_NUM =1<<2,
    RGF_ICON=1<<3
}RSSGroupFileds;

@interface RSSCategoryDao : BaseDao

//******查找

/*!
 @header 获取所有的RSS目录列表
 @abstract BaseDao
 @return   (NSArray*) 返回RSSCategoryEntity数组对象
 @see
 @author   sherwin.chen
 @version  1.0.0
 */
-(NSMutableArray*) getAllRSSCategorys;

//增
/*!
 @header   增加一条记录到RSSGroup表中
 @par1     rssCateEntity RSS目录夹实体对象
 @abstract RSSCategory
 @return   (BOOL) 操作是否成功
 @see
 @author   sherwin.chen
 @version  1.0.0
 */
-(BOOL) addForRSSCategoryEntity:(RSSCategoryEntity*) rssCateEntity;

//删
/*!
 @header   据据rss_category_id值删除对应的表记录
 @abstract RSSCategory
 @par      nID:RSSGroup 主键值，唯一id.
 @return   (BOOL) 操作是否成功
 @see
 @author   sherwin.chen
 @version  1.0.0
 */
-(BOOL) delRSSGroupRecWithCateID:(NSInteger) nID;

//改
/*!
 @header   修改RSSGroup表中对应id的字段信息，提供字段可选位[RSSGroupFileds]
 @par      Par1| rssCateEntity : RSS目录夹实体对象
 @par      Par2| fileds : 需要修改的字段位选,提供RSSGroupFileds位合并 如: RGF_ID|RGF_NAME
 @return   (BOOL) 操作是否成功
 @see
 @author   sherwin.chen
 @version  1.0.0
 */
-(BOOL) updateRSSGroupRecWithRSEntity:(RSSCategoryEntity*) rssCateEntity fileds:(int) type;
@end
