//
//  RSSListViewController.h
//  iRSS
//
//  Created by sherwin on 13-12-2.
//  Copyright (c) 2013年 sherwin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RSSListViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,retain) UITableView * tableView;

@end
