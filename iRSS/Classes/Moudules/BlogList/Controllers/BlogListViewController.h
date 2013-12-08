//
//  BlogListViewController.h
//  iRSS
//
//  Created by sherwin on 13-12-2.
//  Copyright (c) 2013年 sherwin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RSSListEntity.h"
#import "BlogListDao.h"

@interface BlogListViewController : BaseViewController<DataServeDelegate,
UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, retain) RSSListEntity *rssListEntity;
@end
