//
//  TestBase.h
//  iRSS
//
//  Created by sherwin on 14-3-7.
//  Copyright (c) 2014年 sherwin. All rights reserved.
//
//版权所有：版权所有(C) 2013，陈胜 [Sherwin.Chen]
//系统名称：iRSS
//文件名称：TestBase.h
//作　　者：陈胜
//个人联系：chensheng12330@gmail.com or @checkchen2011
//创建日期：14-3-7
//修改日期：<#修改日期#>
//完成日期：<#完成日期#>
//版   本：版本v0.0.1
//版本说明：/*<#版本说明#>*/
//功能说明：测试用例基类
//---------------------------------------------------------
#import <Foundation/Foundation.h>

@interface TestBase : NSObject
- (unsigned int) testCaseCount;
- (BOOL) isEmpty;

//测试入口
- (void)testGo;
@end
