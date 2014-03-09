//
//  HotRSSViewController.m
//  iRSS
//
//  Created by sherwin on 13-12-2.
//  Copyright (c) 2013年 sherwin. All rights reserved.
//

#import "RSSCategoryDao.h"
#import "RSSCategoryCell.h"
#import "HotRSSViewController.h"

@interface HotRSSViewController ()
@property (nonatomic, retain) RSSCategoryDao *rssCateDao;
@property (nonatomic, retain) UITableView *tableView;
@property (nonatomic, retain) NSMutableArray *dataSource;
@end

@implementation HotRSSViewController

- (void)dealloc
{
    [super dealloc];
    self.tableView = nil;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    _rssCateDao = [[RSSCategoryDao alloc] init];
    self.dataSource = [_rssCateDao getAllRSSCategorys];
    
    
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:1];
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
    return 44;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"Cell";
    
    RSSCategoryCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if(cell == nil) {
        NSArray* objs = [[NSBundle mainBundle] loadNibNamed:@"RSSCategoryCell" owner:self options:nil];
        cell = [objs objectAtIndex:0];
    }
    
    RSSCategoryEntity *cateEnty = [self.dataSource objectAtIndex:indexPath.row];
    
    [cell.ivImageView setImage:[UIImage imageNamed:cateEnty.strIconName==NULL?@"icon":cateEnty.strIconName]];
    
    [cell.lbTitile setText:cateEnty.strName];
    [cell.lbNum setText:[NSString stringWithFormat:@"[%d]",cateEnty.nRssNum]];
    
    return cell;
}

#pragma mark - UITableView Delegate methods

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

@end
