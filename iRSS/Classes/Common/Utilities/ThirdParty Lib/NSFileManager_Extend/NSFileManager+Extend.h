//
//  NSFileManager+Extend.h
//  MAE_Standard
//
//  Created by sherwin.chen on 13-6-6.
//  Copyright (c) 2013年 sherwin.chen. All rights reserved.
//

#import <Foundation/Foundation.h>

@class EntityCommon;
@class DirectoryElement;

@interface NSFileManager (Extend)

/******************************************************************************
 函数名称 : + (NSString *)getRootDocumentPath:(NSString *)fileName
 函数描述 : 获取sandbox中Document文件夹中fileName的绝对路径
 输入参数 : (NSString *)fileName
 输出参数 : N/A
 返回参数 : (NSString *)
 备注信息 :
 ******************************************************************************/
+ (NSString *)getRootDocumentPath:(NSString *)fileName;

/******************************************************************************
 函数名称 : + (NSString *)getRootCachesPath:(NSString *)fileName
 函数描述 : 获取sandbox中Caches文件夹中fileName的绝对路径
 输入参数 : (NSString *)fileName
 输出参数 : N/A
 返回参数 : (NSString *)
 备注信息 :
 ******************************************************************************/
+ (NSString *)getRootCachesPath:(NSString *)fileName;

/******************************************************************************
 函数名称 : +(BOOL)isFileExists:(NSString *)fileFullPath
 函数描述 : 判断文件在绝对路径fileFullPath是否存在
 输入参数 : (NSString *)fileFullPath
 输出参数 : N/A
 返回参数 : (BOOL)
 备注信息 :
 ******************************************************************************/
+(BOOL)isFileExists:(NSString *)fileFullPath;

/******************************************************************************
 函数名称 : +(BOOL)createFolderIfNotExisting:(NSString *)folderFullPath
 函数描述 : 创建绝对路径folderFullPath文件夹,当文件夹不存在的时候
 输入参数 : (NSString *)folderFullPath
 输出参数 : N/A
 返回参数 : (BOOL)
 备注信息 :
 ******************************************************************************/
+(BOOL)createFolderIfNotExisting:(NSString *)folderFullPath;

/******************************************************************************
 函数名称 : +(NSString *)newFilePathForCreateFileAtPath:(NSString *)filePath
 函数描述 : 当创建文件存在重名时，则重命名该文件（格式:文件名(数字).扩展名）
 输入参数 : (NSString *)filePath
 输出参数 : N/A
 返回参数 : (BOOL)
 备注信息 :
 ******************************************************************************/
//+(NSString *)newFilePathForCreateFileAtPath:(NSString *)filePath;

/******************************************************************************
 函数名称 : + (NSMutableArray *)getFolderContents:(NSString *)folderFullPath
 函数描述 : 返回绝对路径folderfullPath中的所有文件及文件夹
 输入参数 : (NSString *)folderFullPath
 输出参数 : N/A
 返回参数 : (NSMutableArray *)
 备注信息 :
 ******************************************************************************/
+ (NSMutableArray *)getFolderContents:(NSString *)folderFullPath;

/******************************************************************************
 函数名称 : + (NSInteger)getFolderCount:(NSString *)folderFullPath
 函数描述 : 返回绝对路径folderFullPath中的所有文件总数量
 输入参数 : (NSString *)folderFullPath
 输出参数 : N/A
 返回参数 : (NSInteger)
 备注信息 :
 ******************************************************************************/
+ (NSInteger)getFolderCount:(NSString *)folderFullPath;

/******************************************************************************
 函数名称 : + (UInt64 )getFolderSize:(NSString *)folderFullPath
 函数描述 : 返回绝对路径folderFullPath中的所有文件总大小
 输入参数 : (NSString *)folderFullPath
 输出参数 : N/A
 返回参数 : (UInt64)
 备注信息 :
 ******************************************************************************/
+ (UInt64)getFolderSize:(NSString *)folderFullPath;

/******************************************************************************
 函数名称 : + (UInt64 )getFolderSize:(NSString *)fileFullPath
 函数描述 : 返回绝对路径fileFullPath中的文件大小
 输入参数 : (NSString *)fileFullPath
 输出参数 : N/A
 返回参数 : (UInt64)
 备注信息 :
 ******************************************************************************/
+ (UInt64) getFileSize:(NSString *)fileFullPath;

/******************************************************************************
 函数名称 : + (UInt64) getFileArraySize:(NSArray *)fileFullPathArray
 函数描述 : 返回fileFullPathArray中的绝对路径文件总大小
 输入参数 : (NSString *)fileFullPathArray
 输出参数 : N/A
 返回参数 : (UInt64)
 备注信息 :
 ******************************************************************************/
+ (UInt64) getFileArraySize:(NSArray *)fileFullPathArray;

/******************************************************************************
 函数名称 : +(BOOL)isPhotoFile:(NSString *)fileName
 函数描述 : fileName文件是否是符合要求的图片格式
 输入参数 : (NSString *)fileName
 输出参数 : N/A
 返回参数 : (BOOL)
 备注信息 :
 ******************************************************************************/
+(BOOL)isPhotoFile:(NSString *)fileName;

/******************************************************************************
 函数名称 : + (NSMutableArray *)filterPhotosFromArray:(NSMutableArray *)elementArray
 函数描述 : elementArray中的文件是否是符合要求的图片格式
 输入参数 : (NSMutableArray *)elementArray
 输出参数 : N/A
 返回参数 : (NSMutableArray *)
 备注信息 :
 ******************************************************************************/
+ (NSMutableArray *)filterPhotosFromArray:(NSMutableArray *)elementArray;

/******************************************************************************
 函数名称 : + (NSString *)stringForAllFileSize:(UInt64)fileSize
 函数描述 : 格式话返回文件大小
 输入参数 : (UInt64)fileSize
 输出参数 : N/A
 返回参数 : (NSString *)
 备注信息 :
 ******************************************************************************/
+ (NSString *)stringForAllFileSize:(UInt64)fileSize;

@end



@interface EntityCommon : NSObject

@end

typedef enum{
    //普通文件
    ElementType_NomalFiles = 0,
    //文件夹
    ElementType_Folder = 1
    
}ElementLocationType;

@interface DirectoryElement : NSObject
//文件名称
@property (strong, nonatomic) NSString      *name;
//文件名称(大写)
@property (strong, nonatomic) NSString      *nameForSort;
//绝对路径
@property (strong, nonatomic) NSString      *path;
//特定为ElementType_NomalFiles，文件大小
@property (assign, nonatomic) UInt64        fileSize;
//特定为ElementType_Folder，文件夹中子文件数目
@property (assign, nonatomic) NSInteger     numChilds;
//UI是否选中该文件或文件夹标识
@property (assign, nonatomic) BOOL          selected;
//创建时间
@property (strong, nonatomic) NSDate        *date;
//修改时间
@property (strong, nonatomic) NSDate        *modificationDate;
//特定为ElementType_NomalFiles，文件扩展名(大写)
@property (strong, nonatomic) NSString      *fileExtension;
//类型
@property (assign, nonatomic) NSInteger     elementType;
//备于特殊用途，如存储上传到Dropbox的路径或其他。
@property (strong, nonatomic) NSString      *specialPath;

//property for photos in camera.
//URL
@property (strong, nonatomic) NSURL         *url;
//缩略图
@property (strong, nonatomic) UIImage       *imageLogo;

@end
