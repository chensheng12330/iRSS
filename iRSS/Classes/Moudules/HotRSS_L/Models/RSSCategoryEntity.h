//
//  RSSCategoryEntity.h
//  iRSS
//
//  Created by sherwin on 14-3-5.
//  Copyright (c) 2014年 sherwin. All rights reserved.
//

//版权所有：版权所有(C) 2013，陈胜 [Sherwin.Chen]
//系统名称：iRSS
//文件名称：RSSCategoryEntity.h
//作　　者：陈胜
//个人联系：chensheng12330@gmail.com or @checkchen2011
//创建日期：14-3-5
//修改日期：<#修改日期#>
//完成日期：<#完成日期#>
//版   本：版本v1.0.0
//版本说明：/*1.0初版本*/
//功能说明：RSS源分类目录实体
//---------------------------------------------------------

#import "Entity.h"

/*!
 @Description  RSS源分类目录实体
 @see      Entity.h
 @author   sherwin.chen
 @version  1.0.0
 */
@interface RSSCategoryEntity : Entity
@property (nonatomic, copy) NSString *strName;      //分类名
@property (nonatomic, copy) NSString *strIconName;  //分类icon图标
@property (nonatomic, assign) NSInteger nRssNum;    //rss条数目
@end