//
//  SHKeyedArchiverManage.m
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
//功能说明：<#说明#>
//---------------------------------------------------------

#import "SHKeyedArchiverManage.h"
#import "SHMacroDefine.h"


#define KEYARCH_FOLDER  (@"KeyedArchiver")
static SHKeyedArchiverManage *_sharedKeyedArchiverManage = nil;

@implementation SHKeyedArchiverManage
#pragma mark - object init

+(SHKeyedArchiverManage*) sharedKeyedArchiverManage
{
    @synchronized(self)
    {
        if (nil == _sharedKeyedArchiverManage ) {
            _sharedKeyedArchiverManage = [[self alloc] init];
        }
    }
    return _sharedKeyedArchiverManage;
}

+(id)alloc
{
    @synchronized([SHKeyedArchiverManage class]) //线程访问加锁
    {
        NSAssert(_sharedKeyedArchiverManage == nil, @"Shewin: Attempted to allocate a second instance of a singleton.Please call +[sharedExerciseManage] method.");
        _sharedKeyedArchiverManage  = [super alloc];
        return _sharedKeyedArchiverManage;
    }
    return nil;
}

- (id)init
{
    self = [super init];
    if (self) {
        
        self.defaultSaveFilePath =  [[SH_DefaultCaches objectAtIndex:0] stringByAppendingPathComponent:KEYARCH_FOLDER];
        
        //创建缓存目录
        [NSFileManager createFolderIfNotExisting:self.defaultSaveFilePath];
        
    }
    return self;
}

+ (id)allocWithZone:(NSZone *)zone
{
    @synchronized(self) {
        if (nil == _sharedKeyedArchiverManage) {
            _sharedKeyedArchiverManage = [super allocWithZone:zone];
            return _sharedKeyedArchiverManage;
        }
    }
    return nil;
}

- (id)copyWithZone:(NSZone *)zone
{
    return self;
}

- (void)dealloc
{
    [super dealloc];
    _sharedKeyedArchiverManage = nil;
    self.defaultSaveFilePath   = nil;
}

- (oneway void)release
{
    // do nothing
    if( _sharedKeyedArchiverManage == nil)
    {
        NSLog(@"SHDBManage: retainCount is 0.");
        return;
    }
    [super release];
    return;
}

- (id)retain
{
    return self;
}

- (NSUInteger)retainCount
{
    return NSUIntegerMax; // This is sooo not zero
}

#pragma mark - Public Method
//获取序列化对象数据
-(NSData*) getKeyedArchiverDataWithUniqueKey:(NSString *)uniqueKey
{
    if (uniqueKey==NULL || [uniqueKey isEqualToString:@""]) { return nil;}
    
    NSString *fileFullPath = [self.defaultSaveFilePath stringByAppendingPathComponent:uniqueKey];
    
    NSData *data = nil;
    
    if([NSFileManager isFileExists:fileFullPath])
    {
        data = [[[NSData alloc] initWithContentsOfFile:fileFullPath] autorelease];
    }
    
    return data;
}

//存入序列化对象数据
-(void) saveKeyedArchiverData:(NSData*) _data ForUniqueKey:(NSString *)uniqueKey
{
    if (uniqueKey==NULL ||_data==NULL || [uniqueKey isEqualToString:@""]) { return;}
    
    NSString *fileFullPath = [self.defaultSaveFilePath stringByAppendingPathComponent:uniqueKey];
    
    [_data writeToFile:fileFullPath atomically:YES];
    
    return;
}

//删除序列化对象数据
-(void) deleteKeyedArchiverDataForUniqueKey:(NSString *)uniqueKey
{
    if (uniqueKey==NULL || [uniqueKey isEqualToString:@""]) { return;}
    
    NSString *fileFullPath = [self.defaultSaveFilePath stringByAppendingPathComponent:uniqueKey];
    
    NSError *error =nil;
    [SH_DefaultFileManager removeItemAtPath:fileFullPath error:&error];
    
    if (error) {
        NSLog(@"%@",error);
    }
    return;
}

@end
