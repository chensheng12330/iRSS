//
//  BlogListDao.h
//  iRSS
//
//  Created by sherwin on 13-12-4.
//  Copyright (c) 2013年 sherwin. All rights reserved.
//

//版权所有：版权所有(C) 2013，陈胜 [Sherwin.Chen]
//系统名称：iRSS
//文件名称：BlogListDao.h
//作　　者：陈胜
//个人联系：chensheng12330@gmail.com or @checkchen2011
//创建日期：13-12-4
//修改日期：<#修改日期#>
//完成日期：<#完成日期#>
//版   本：版本v0.0.1
//版本说明：/*版本说明*/
//功能说明：提供博客信息的操作接口
//---------------------------------------------------------

#import "BaseDao.h"
#import "BlogListEntity.h"

@interface BlogListDao : BaseDao<MWFeedParserDelegate>

//根据RSS_URL获取博客列表
-(void) asynGetBlogListWithRSSUrl:(NSString*) strRssUrl RSSID:(NSInteger) pid;

//从数据库中获取博客列表数据
-(NSMutableArray*)  synchGetBlogListFromDBWithRSSID:(NSInteger) pid;

//存放数据
-(BOOL) saveBlogListInfoToDBWithBlogListEntity:(BlogListEntity*)blogListInfo;

//更新数据
-(BOOL) updateBlogInfoWithBlogListEntity:(BlogListEntity*)blogListInfo;

//获取未读的博客数目
+(NSInteger) getUnreadBlogCount;
@end
