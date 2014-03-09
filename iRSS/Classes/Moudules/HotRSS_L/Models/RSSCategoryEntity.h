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
#import <objc/runtime.h>

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


//Runtime:
// http://www.cocoachina.com/bbs/read.php?tid=97773
// http://www.cocoachina.com/bbs/simple/?t97803.html

-(id) initWithDictionary:(NSDictionary*) dict;

@end


//
//@interface RSSEntity:Entity
//@property (nonatomic, copy) NSString *itemID;
//@property (nonatomic, copy) NSString *name;
//@property (nonatomic, copy) NSString *iconName;
//@property (nonatomic, assign) int unixDate;
//
////模型初使化接口
//-(id) initWithDictionary:(NSDictionary*) jsonDict;
//
//@end
//
//@interface UserInfoEntity : Entity
//@property (nonatomic, retain) NSString *name;
//@property (nonatomic, retain) NSString *mail;
//
//-(id) initWithDictionary:(NSDictionary*) jsonDict;
//@end

