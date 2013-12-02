//
//  SHKeyedArchiverManage.h
//  MAE_Standard
//
//  Created by sherwin.chen on 13-6-19.
//  Copyright (c) 2013年 sherwin.chen. All rights reserved.
//

//版权所有：版权所有(C) 2013，陈胜 [Sherwin.Chen]
//系统名称：<#使用系统#>
//文件名称：SHKeyedArchiverManage.h
//作　　者：陈胜
//个人联系：chensheng12330@gmail.com or @checkchen2011
//创建日期：13-6-19
//修改日期：<#修改日期#>
//完成日期：<#完成日期#>
//版   本：版本v0.0.1
//功能说明：
/*
 1、提供数据的管理【增，删，改】 特别是针对 序列化对象进行管理
 2、存入对象数据时，请确定 uniqueKey的唯一性，本类没有对已存的uniqueKey进行判断
 3、本类单列化
 4、可对存入数据的文件夹进行设置
 */
//---------------------------------------------------------

#import <Foundation/Foundation.h>

#define SHKAM [SHKeyedArchiverManage sharedKeyedArchiverManage]

@interface SHKeyedArchiverManage : NSObject

//默认保存路径
@property (nonatomic, retain) NSString *defaultSaveFilePath;

+(SHKeyedArchiverManage*) sharedKeyedArchiverManage;

//获取序列化对象数据
-(NSData*) getKeyedArchiverDataWithUniqueKey:(NSString *)uniqueKey;

//存入序列化对象数据
-(void) saveKeyedArchiverData:(NSData*) _data ForUniqueKey:(NSString *)uniqueKey;

//删除序列化对象数据
-(void) deleteKeyedArchiverDataForUniqueKey:(NSString *)uniqueKey;
@end
