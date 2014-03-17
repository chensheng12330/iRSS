//
//  RSSListViewController.m
//  iRSS
//
//  Created by sherwin on 13-12-2.
//  Copyright (c) 2013年 sherwin. All rights reserved.
//

#import "RSSListViewController.h"
#import "MMDrawerVisualStateManager.h"
#import "UIViewController+MMDrawerController.h"
#import "MMDrawerBarButtonItem.h"
#import "MMNavigationController.h"

#import "RSSLogoView.h"
#import "RSSListTableViewCell.h"
#import "HotRSSViewController.h"
#import "SettingViewController.h"
#import "NewRSSViewController.h"
#import "BlogListViewController.h"

#import "RSSListDao.h"
#import "RSSListEntity.h"

@interface RSSListViewController ()
@property (nonatomic, retain) NSMutableArray *dateSource;
@property (nonatomic, retain) RSSListDao *rssListDao;
@end

@implementation RSSListViewController

- (id)init
{
    self = [super init];
    if (self) {
        [self setRestorationIdentifier:@"MMExampleCenterControllerRestorationKey"];
        self.rssListDao = [[[RSSListDao alloc] init] autorelease];
        //self.dateSource = nil;
    }
    return self;
}
- (void)dealloc
{
    self.rssListDao = nil;
    self.dateSource = nil;
    [super dealloc];
    
}

-(void) reloadTableViewDataWithRSSClassID:(int) nfRssClassID
{
    self.nRssClassID = nfRssClassID;
    self.dateSource = [_rssListDao getBookRSSList:nfRssClassID];
    [self.tableView reloadData];
    
    return;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    [self.tableView setDelegate:self];
    [self.tableView setDataSource:self];
    [self.view addSubview:self.tableView];
    [self.tableView setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight];
    
    UITapGestureRecognizer * doubleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(doubleTap:)];
    [doubleTap setNumberOfTapsRequired:2];
    [self.view addGestureRecognizer:doubleTap];
    
    UITapGestureRecognizer * twoFingerDoubleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(twoFingerDoubleTap:)];
    [twoFingerDoubleTap setNumberOfTapsRequired:2];
    [twoFingerDoubleTap setNumberOfTouchesRequired:2];
    [self.view addGestureRecognizer:twoFingerDoubleTap];
    
    
    [self setupLeftMenuButton];
    [self setupRightMenuButton];
    
    if(OSVersionIsAtLeastiOS7()){
        UIColor * barColor = [UIColor
                              colorWithRed:247.0/255.0
                              green:249.0/255.0
                              blue:250.0/255.0
                              alpha:1.0];
        [self.navigationController.navigationBar setBarTintColor:barColor];
    }
    else {
        UIColor * barColor = [UIColor
                              colorWithRed:78.0/255.0
                              green:156.0/255.0
                              blue:206.0/255.0
                              alpha:1.0];
        [self.navigationController.navigationBar setTintColor:barColor];
    }
    
    /*
    UIImageView * logo = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    [logo setImage:[UIImage imageNamed:@"RSS.png"]];
    logo.alpha = 0.5;
    [self.navigationItem setTitleView:logo];
    */
    [self.navigationItem setTitle:@"iRSS"];
    
    [self.navigationController.view.layer setCornerRadius:10.0f];
    
    
    UIView *backView = [[UIView alloc] init];
    [backView setBackgroundColor:[UIColor colorWithRed:208.0/255.0
                                                 green:208.0/255.0
                                                  blue:208.0/255.0
                                                 alpha:1.0]];
    [self.tableView setBackgroundView:backView];
    
    //get datasource from dao
    //可记住用户当前选择项目
    [self reloadTableViewDataWithRSSClassID:1]; //1 标识为初使化列表
    return;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    COM.mmDrawerControl.enablePan = YES;
    NSLog(@"Center will appear");
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    NSLog(@"Center did appear");
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    NSLog(@"Center will disappear");
}

-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    NSLog(@"Center did disappear");
}

-(void)setupLeftMenuButton{
    MMDrawerBarButtonItem * leftDrawerButton = [[MMDrawerBarButtonItem alloc] initWithTarget:self action:@selector(leftDrawerButtonPress:)];
    [self.navigationItem setLeftBarButtonItem:leftDrawerButton animated:YES];
}

-(void)setupRightMenuButton{
    MMDrawerBarButtonItem * rightDrawerButton = [[MMDrawerBarButtonItem alloc] initWithTarget:self action:@selector(rightDrawerButtonPress:)];
    [self.navigationItem setRightBarButtonItem:rightDrawerButton animated:YES];
}

-(void)contentSizeDidChange:(NSString *)size{
    [self.tableView reloadData];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dateSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"MMCenterTableViewCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        
        cell = [[MMCenterTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
        [cell setSelectionStyle:UITableViewCellSelectionStyleGray];
    }
    
    /*
    UIColor * selectedColor = [UIColor
                               colorWithRed:1.0/255.0
                               green:15.0/255.0
                               blue:25.0/255.0
                               alpha:1.0];
    UIColor * unselectedColor = [UIColor
                                 colorWithRed:79.0/255.0
                                 green:93.0/255.0
                                 blue:102.0/255.0
                                 alpha:1.0];
    */
    
    RSSListEntity *listEnty = [self.dateSource objectAtIndex:indexPath.row];
    cell.textLabel.text = listEnty.strRssName;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"(%ld)",(long)listEnty.nUnReadNum];
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    RSSListEntity *listEnty = [self.dateSource objectAtIndex:indexPath.row];
    BlogListViewController *blogListVC = [[BlogListViewController alloc] init];
    blogListVC.rssListEntity = listEnty;
    
    COM.mmDrawerControl.enablePan = NO;
    [self.navigationController pushViewController:blogListVC animated:YES];
}

#pragma mark - Button Handlers
-(void)leftDrawerButtonPress:(id)sender{
    [self.mm_drawerController toggleDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
}

-(void)rightDrawerButtonPress:(id)sender{
    [self.mm_drawerController toggleDrawerSide:MMDrawerSideRight animated:YES completion:nil];
}

-(void)doubleTap:(UITapGestureRecognizer*)gesture{
    [self.mm_drawerController bouncePreviewForDrawerSide:MMDrawerSideLeft completion:nil];
}

-(void)twoFingerDoubleTap:(UITapGestureRecognizer*)gesture{
    [self.mm_drawerController bouncePreviewForDrawerSide:MMDrawerSideRight completion:nil];
}

#pragma mark - external inteface

-(void) addNewRss
{
    NewRSSViewController *newRssVC = [[NewRSSViewController alloc] init];
    [self presentViewController:newRssVC animated:YES completion:^{
        
    }];
}
@end
