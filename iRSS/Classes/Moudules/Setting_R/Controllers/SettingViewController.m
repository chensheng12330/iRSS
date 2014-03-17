//
//  SettingViewController.m
//  iRSS
//
//  Created by sherwin on 13-12-2.
//  Copyright (c) 2013年 sherwin. All rights reserved.
//

#import "RSSCategoryCell.h"
#import "SettingViewController.h"

@interface SettingViewController ()
@property (nonatomic, retain) UITableView *tableView;
@property (nonatomic, retain) NSArray *dataSource;
@end

@implementation SettingViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)dealloc
{
    [super dealloc];
    self.tableView = nil;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
	// Do any additional setup after loading the view.
    self.dataSource = @[@"新增RSS",@"编辑RSS",@"离线下载",@"缓存清理",@"版本信息"];  // @{@"title":,@"image":@[@""]};
    
    self.title = @"设置";
    
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:0];
    _tableView.delegate  = self;
    _tableView.dataSource= self;
    [self.view addSubview:_tableView];
    
    return;
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
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if(cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:0 reuseIdentifier:@"Cell"];
    }
    
    UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"setting_cell_%d",indexPath.row]];
    //image = [COM scaleToSize:image size:CGSizeMake(40, 40)];

    [cell.textLabel setText:[self.dataSource objectAtIndex:indexPath.row]];
    [cell.imageView setImage:image];  //[UIImage imageNamed:]];   //[NSString stringWithFormat:@"setting_cell_%d",indexPath.row]]];
    
    return cell;
}

#pragma mark - UITableView Delegate methods

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        //add new ss
        [COM.mmDrawerControl closeDrawerAnimated:YES completion:^(BOOL finished) {
            [COM.viewController addNewRss];
        }];
        
    }
    else if (indexPath.row == 1)
    {
        //编辑RSS
    }
    else if (indexPath.row == 2)
    {
        //离线下载
    }
    else if (indexPath.row ==3)
    {
        //cache clear
    }
    else if (indexPath.row ==4)
    {
        //version info
    }
}
@end
