//
//  NewRSSViewController.m
//  iRSS
//
//  Created by sherwin.chen on 14-3-15.
//  Copyright (c) 2014年 sherwin. All rights reserved.
//

#import "NewRSSViewController.h"

@interface NewRSSViewController ()
@property (nonatomic, retain) UITableView *tableView;
@property (nonatomic, retain) NSMutableArray *dataSource;

@property (nonatomic, assign) UIButton *btnSwitchURL;
@property (nonatomic, assign) UIButton *btnSwitchBlog;
@end

@implementation NewRSSViewController

- (void)dealloc
{
    self.tableView = nil;
    self.dataSource= nil;
    
    _btnSwitchBlog = nil;
    _btnSwitchURL  = nil;
    
    [super dealloc];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    self.dataSource = [[[NSMutableArray alloc] initWithObjects:@"1",@"2",@"3",nil] autorelease];
    
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

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = nil;
    
    NSInteger nTag = [[self.dataSource objectAtIndex:indexPath.row] integerValue];
    
    if (nTag == 1) {
        NSArray *arViews = [[NSBundle mainBundle] loadNibNamed:@"NewRSSCellView" owner:self options:nil];
        cell = (UITableViewCell*)[arViews objectAtIndex:0];
        
        self.btnSwitchURL = (UIButton*)[cell viewWithTag:1];
        self.btnSwitchBlog= (UIButton*)[cell viewWithTag:2];
        //初使化selecet状态
    }
    else if (nTag == 2)
    {
        
    }
    else if (nTag == 3)
    {
        
    }
    else if (nTag == 4)
    {
        
    }
    
    
    
    //cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    
    cell.textLabel.text = [NSString stringWithFormat:@"Cell %d", indexPath.row];
    
    return cell;
}

#pragma mark - UITableView Delegate methods

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}
@end
