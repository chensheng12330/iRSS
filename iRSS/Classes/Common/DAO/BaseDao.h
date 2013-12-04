//
//  BaseDao.h
//  UniversalArchitecture
//
//  Created by sherwin.chen on 12-12-6.
//  Copyright (c) 2012年 sherwin.chen. All rights reserved.
//

//版权所有：版权所有(C) 2013，陈胜 [Sherwin.Chen]
//系统名称：<#使用系统#>
//文件名称：BaseDao.h
//作　　者：陈胜
//个人联系：chensheng12330@gmail.com or @checkchen2011
//创建日期：12-12-06
//修改日期：13-06-17
//完成日期：<#完成日期#>
//版   本：版本v0.0.1
//功能说明：数据访问服务基础
//---------------------------------------------------------

#import <Foundation/Foundation.h>
#import "Entity.h"

#import "MKNetworkKit.h"//net  server
#import "SHDBManage.h"  //data server
#import "MWFeedParser.h"

#define DAO_REQUEST__KEY (@"dao_request_key")

#define DAO_ERROR_TYPE (@"e_type")


typedef enum
{
    DO_DB,  //DB File
    DO_LOC, //Local Files
    DO_SER  //web Server
}DataOrigin;  //被请求的数据来源


typedef enum {
    DT_NULL=0,
    DT_String = 1,
    DT_EntityObject,
    DT_NSArray,
    DT_Dictionary,
    DT_NSNumber
}DataType;//被请求的数据的类型

@class BaseDao;

@protocol DataServeDelegate <NSObject>

/*!
 @method     requestFinished
 @abstract   base
 @discussion delegate，返回成功后的代理
 @param1    请求的本类对象
 @param2    请求的数据来源
 @param3    请求返回的数据类型，字符串描述
 @param4    请求返回的具体数据
 @result 
 */
- (void)requestFinished:(BaseDao *)  dao
             dataOrigin:(DataOrigin) dataOrigin
               dataType:(DataType)   dataType
                   data:(NSObject*)  object;

/*!
 @method     requestFailed
 @abstract   base
 @discussion 请求失败后，返回的代理
 param1      请求的本类对象
 param2      失败的相关信息，可以为空
 @result      
 */
- (void)requestFailed:(BaseDao *) dao failedInfo:(NSString*) info;
@end


#define DAO_FLAG_REQ (@"request_tag")  //请求tag标识

static MKNetworkEngine *mkNetReqEngine;

@interface BaseDao : NSObject
{
    
    id<DataServeDelegate> _delegate;
    NSMutableDictionary *_userInfo;  //信息字段记录
}
/*
 reqPIDQueues: 说明
 
 1、数据结构为队列容器，装载所有向网络请求的唯一请求ID值()。
 2、reqPID可使用 当前请求时的unix时间截存入
 3、
 
 */
@property (nonatomic, retain) NSMutableArray *reqPIDQueues; //使用请求DOA函数PID对列，记录每次API请求
@property (nonatomic, assign) id<DataServeDelegate> delegate;
@property (nonatomic, readonly) NSMutableDictionary *userInfo;
@end
