//
//  BaseDao.m
//  UniversalArchitecture
//
//  Created by Sherwin.Chen on 12-12-6.
//  Copyright (c) 2012年 Sherwin.Chen. All rights reserved.
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

#import "BaseDao.h"

@implementation BaseDao

- (id)init
{
    self = [super init];
    if (self) {
        self.delegate = nil;
        
        _userInfo     = [[NSMutableDictionary alloc] init];
        _reqPIDQueues = [[NSMutableArray alloc] init];
    }
    return self;
}

-(void) setDelegate:(id<DataServeDelegate>)fdelegate
{
    _delegate = fdelegate;
    
    if (fdelegate==NULL) {
        //通知网络服务释放对列中的网络请求
        if (self.reqPIDQueues.count>0) {
            for (NSString *strPID in self.reqPIDQueues) {
                
                //[[NSNotificationCenter defaultCenter] postNotificationName:NETWORK_SERVICES_NOTIFI_KEY object:strPID];
            }
            [_reqPIDQueues removeAllObjects];
        }
    }
}

- (void)dealloc
{
    self.delegate     = nil;
    
    //通知网络服务释放对列中的网络请求
    if (self.reqPIDQueues.count>0) {
        for (NSString *strPID in self.reqPIDQueues) {
            
            //[[NSNotificationCenter defaultCenter] postNotificationName:NETWORK_SERVICES_NOTIFI_KEY object:strPID];
        }
    }
    
    //对象清理
    
    self.reqPIDQueues = nil;
    [_userInfo release];
    [super dealloc];
}

//#pragma mark -- HandleRequestInterface
//// 请求成功
//-(void)requestDone:(NetRequest*) netRequest UserInfo:(NSObject*) userInfo
//{
//    //从消息队列中移除当前请求
//    //所有重写当前方法的子类，必须调用该父类的此方法，即[super requestDone.....];
//    [self.reqPIDQueues removeObject:netRequest.reqPID];
//    
//}
//
//// 数据请求失败
///*
// 1.此方法，子类可重写，也可不重写，默认对错误的处理都包括在此方法中。如果子类重写此方法
// 则必须使用 [self.reqPIDQueues removeObject:netRequest.reqPID]; 此代码段
// */
//-(void)requestFailed:(NetRequest*) netRequest Error:(NSError*)error UserInfo:(NSObject*) userInfo
//{
//    //从消息队列中移除当前请求
//    [self.reqPIDQueues removeObject:netRequest.reqPID];
//    
//    SEL sentAction = @selector(requestFailed:failedInfo:);
//    if(_delegate!=NULL && [_delegate retainCount]>0 && [_delegate respondsToSelector:sentAction])
//    {
//        [self.userInfo setObject:@"1" forKey:DAO_ERROR_TYPE];
//        [_delegate requestFailed:self failedInfo:error.localizedDescription];
//    }
//    
//    [self.userInfo removeObjectForKey:DAO_ERROR_TYPE];
//    //[self.userInfo setObject:nil forKey:DAO_ERROR_TYPE];
//    return;
//}


- (id)queryWithEntity:(Entity *)entity inDatabase:(FMDatabase *)db { return nil; }
- (BOOL)insertWithEntity:(Entity *)entity inDatabase:(FMDatabase *)db { return NO; }
- (BOOL)updateWithEntity:(Entity *)entity inDatabase:(FMDatabase *)db { return NO; }
- (BOOL)deleteWithEntity:(Entity *)entity inDatabase:(FMDatabase *)db { return NO; }

@end
