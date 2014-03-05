//
//  Entity.m
//  AmwayMCommerce
//
//  Created by sherwin.chen on 12-12-28.
//
//

//版权所有：版权所有(C) 2013，陈胜 [Sherwin.Chen]
//系统名称：<#使用系统#>
//文件名称：Entity.m
//作　　者：陈胜
//个人联系：chensheng12330@gmail.com or @checkchen2011
//创建日期：12-12-28
//修改日期：13-06-17
//完成日期：<#完成日期#>
//版   本：版本v0.0.1
//功能说明：数据实体基类
//---------------------------------------------------------

#import "Entity.h"

@implementation Entity

- (id)init {
    self = [super init];
    if (self) {
        // Initialization code here.
    }
    return self;
}

- (void)dealloc
{
    [super dealloc];
}

-(NSString*) description
{
    NSString *superStr = [super description];
    
    superStr = [superStr stringByAppendingFormat:@"{%@} id:[%d] ",NSStringFromClass([self class]),_nId];
    return superStr;
}
@end
