//
//  BlogListViewController.m
//  iRSS
//
//  Created by sherwin on 13-12-2.
//  Copyright (c) 2013年 sherwin. All rights reserved.
//

#import "BlogListDao.h"
#import "BlogListViewController.h"
#import "BlogListTableViewCell.h"
#import "BlogReaderViewController.h"


@interface BlogListViewController ()
@property (nonatomic, retain) UITableView *tableView;
@property (nonatomic, retain) NSMutableArray *dataSource;
@property (nonatomic, retain) BlogListDao *blogListDao;
@end

@implementation BlogListViewController

- (id)init
{
    self = [super init];
    if (self) {
        _blogListDao = [[BlogListDao alloc] init];
        _blogListDao.delegate = self;
        _dataSource  = [[NSMutableArray alloc] initWithCapacity:10];
    }
    return self;
}

- (void)dealloc
{
    self.tableView     = nil;
    self.dataSource    = nil;
    self.rssListEntity = nil;
    self.blogListDao   = nil;
    [super dealloc];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:1];
    _tableView.delegate  = self;
    _tableView.dataSource= self;
    [self.view addSubview:_tableView];
    
    self.title = self.rssListEntity.strRssName;
    
    self.view.backgroundColor = [UIColor whiteColor];
	// Do any additional setup after loading the view.
    [_blogListDao asynGetBlogListWithRSSUrl:self.rssListEntity.strRssUrl RSSID:self.rssListEntity.nId];;
    
    //self.dataSource  =[_blogListDao synchGetBlogListFromDBWithRSSID:self.rssListEntity.nId];
    //[_blogListDao saveBlogListInfoToDBWithBlogListEntity:[self.dataSource objectAtIndex:0]];
}

-(void) viewDidAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:NO];
    [super viewDidAppear:animated];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableView Datasource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 112;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"BlogListTableViewCell";
    
    BlogListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if(cell == nil) {
        cell = [[BlogListTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    BlogListEntity *blogEnty = [self.dataSource objectAtIndex:indexPath.row];
    
    cell.lbTitile.text = blogEnty.strTitle;
    cell.tvSummary.text= blogEnty.strSummary;
    cell.lbCreator.text= blogEnty.strLink;
    cell.lbDate.text   = [blogEnty.deDate description];
    
    if (blogEnty.bIsRead) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }
    else
    {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    
    return cell;
}

#pragma mark - UITableView Delegate methods

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    
    BlogListEntity *blogInfoEnty = [self.dataSource objectAtIndex:indexPath.row];
    blogInfoEnty.bIsRead = YES;
    
    [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:0];
    
    //将该记录设置为已读
    [self.blogListDao updateBlogInfoWithBlogListEntity:blogInfoEnty];
    
    BlogReaderViewController *readMVC = [[BlogReaderViewController alloc] init];
    readMVC.strUrlLink = blogInfoEnty.strLink;
    
    [self.navigationController setNavigationBarHidden:YES];
    [self.navigationController pushViewController:readMVC animated:YES];
    [readMVC release];
}


#pragma mark - SH_DataServeDelegate
- (void)requestFinished:(BaseDao *)  dao
             dataOrigin:(DataOrigin) dataOrigin
               dataType:(DataType)   dataType
                   data:(NSArray*)  object
{
    if (1) { //刷新
        [self.dataSource  addObjectsFromArray:object];
        
        if (self.dataSource.count==0) {
            self.dataSource  =[_blogListDao synchGetBlogListFromDBWithRSSID:self.rssListEntity.nId];
        }
        
        [self.tableView reloadData];
    }
    else  //load more
    {
        
    }
}

- (void)requestFailed:(BaseDao *) dao failedInfo:(NSString*) info
{
    NSLog(@"%@",info);
    
    self.dataSource  =[_blogListDao synchGetBlogListFromDBWithRSSID:self.rssListEntity.nId];
    [self.tableView reloadData];
}
@end
