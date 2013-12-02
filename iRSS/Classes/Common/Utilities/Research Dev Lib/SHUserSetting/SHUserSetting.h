//
//  SHUserSetting.h
//  TestFrame
//
//  Created by sherwin.chen on 13-6-16.
//  Copyright (c) 2013年 sherwin.chen. All rights reserved.
//

//版权所有：版权所有(C) 2013，陈胜 [Sherwin.Chen]
//系统名称：<#使用系统#>
//文件名称：SHUserSetting.h
//作　　者：陈胜
//个人联系：chensheng12330@gmail.com or @checkchen2011
//创建日期：2013.06.16.2123
//修改日期：<#修改日期#>
//完成日期：<#完成日期#>
//版   本：版本v0.0.1
//功能说明：
/*
 1、提供对Setting.bundle的读写操作
 2、提供NSUserDefaults基础数据服务API.支持:NSString, NSData, NSNumber, NSDictionary, NSArray
 3、本类提供Setting.plist修改的事件监听服务方法
 4、退出消息通知
 注意：
 应用退出时，需要保存当前已设置的值
 */
//---------------------------------------------------------

#import <Foundation/Foundation.h>

#define SHUS [SHUserSetting standardUserSetting]

@interface SHUserSetting : NSObject

//NSUserDefaults 初使化对象方法
//---------------------------------------------------------
+ (SHUserSetting *)standardUserSetting;
//+ (void)resetStandardUserDefaults;


//NSUserDefaults 接口，基础数据服务接口
//---------------------------------------------------------
- (id)objectForKey:(NSString *)defaultName;
- (void)setObject:(id)value forKey:(NSString *)defaultName;
- (void)removeObjectForKey:(NSString *)defaultName;

//
//---------------------------------------------------------


@end
