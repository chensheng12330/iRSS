//
//  SHUserSettingDao.h
//  MAE_Standard
//
//  Created by sherwin.chen on 13-6-18.
//  Copyright (c) 2013年 sherwin.chen. All rights reserved.
//

//版权所有：版权所有(C) 2013，陈胜 [Sherwin.Chen]
//系统名称：<#使用系统#>
//文件名称：SHUserSettingDao.h
//作　　者：陈胜
//个人联系：chensheng12330@gmail.com or @checkchen2011
//创建日期：13-6-18
//修改日期：<#修改日期#>
//完成日期：<#完成日期#>
//版   本：版本v0.0.1
//版本说明：/*<#版本说明#>*/
//功能说明：
/*
 1、提供用户设置对象的数据访问服务
 2、文件使用Root.plist进行本地储存
 3、基础数据可进行改变
 */
//---------------------------------------------------------


#import "BaseDao.h"
#import "SHUserSetting.h"


#define SHUSD SHUserSettingDao
typedef enum {
    MVC_TOOLBAR = 0,
    MVC_NAVBAR
}MVC_MODE;

@interface SHUserSettingDao : BaseDao

/*!
 @method     getAppMVCMode
 @abstract   <#property#>
 @discussion 获取APP视图导航模式 MVC模式[0:toolbar  1:navbar]
 @param      <#property#>
 @param      <#property#>
 @result     <#property#>
 */
+(MVC_MODE) getAppMVCMode;

/*!
 @method     getCarouselStyle
 @abstract   <#property#>
 @discussion 获取滑动视图展现方式
 @param      <#property#>
 @param      <#property#>
 @result     <#property#>
 */
+(int) getCarouselStyle;


+(NSString*) getUserName;
+(NSString*) getPassword;

+(void) setUserName:(NSString*)_name;
+(void) setPassword:(NSString*)_pwd;

//获取类列表
+(NSArray*) getClassArry;

//获取tabbarItems images
+(NSArray*) getTabbarItemImages;

//获取联系数据
+(NSArray*) getContactData;


@end
