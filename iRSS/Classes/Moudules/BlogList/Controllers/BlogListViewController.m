//
//  BlogListViewController.m
//  iRSS
//
//  Created by sherwin on 13-12-2.
//  Copyright (c) 2013年 sherwin. All rights reserved.
//

#import "BlogListViewController.h"
#import "BlogListDao.h"

@interface BlogListViewController ()
@property (nonatomic, retain) BlogListDao *blogListDao;
@end

@implementation BlogListViewController

- (id)init
{
    self = [super init];
    if (self) {
        _blogListDao = [[BlogListDao alloc] init];
    }
    return self;
}

- (void)dealloc
{
    self.rssListEntity = nil;
    self.blogListDao   = nil;
    [super dealloc];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
	// Do any additional setup after loading the view.
    [_blogListDao asynGetBlogListWithRSSUrl:self.rssListEntity.strRssUrl];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
