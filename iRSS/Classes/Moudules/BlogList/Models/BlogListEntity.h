//
//  BlogListEntity.h
//  iRSS
//
//  Created by sherwin on 13-12-4.
//  Copyright (c) 2013年 sherwin. All rights reserved.
//

//版权所有：版权所有(C) 2013，陈胜 [Sherwin.Chen]
//系统名称：iRSS
//文件名称：BlogListEntity.h
//作　　者：陈胜
//个人联系：chensheng12330@gmail.com or @checkchen2011
//创建日期：13-12-4 天气非常的好
//修改日期：<#修改日期#>
//完成日期：<#完成日期#>
//版   本：版本v0.0.1
//版本说明：/*版本说明*/
//功能说明：博客信息实体
//---------------------------------------------------------

#import "Entity.h"

@interface BlogListEntity : Entity
@property (nonatomic, assign) NSInteger nRSSID;//当前所属RSS ID
@property (nonatomic, copy) NSString *strIdentifier;
@property (nonatomic, copy) NSString *strTitle;
@property (nonatomic, copy) NSString *strLink;
@property (nonatomic, copy) NSDate *deDate;  //发表日期
@property (nonatomic, copy) NSDate *deUpdated;
@property (nonatomic, copy) NSString *strSummary; //Description
@property (nonatomic, copy) NSString *strContent; //可选 ，更细详
@property (nonatomic, copy) NSArray *strEnclosures;//其它更多

//publisher [站点名]
//creator   [作者]

@property (nonatomic, assign)BOOL bIsRead; //是否已读
@end
