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
@property (nonatomic, assign) UITextField *tfURLStr;

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
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;//self.dataSource.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section==0) {
        return 20;
    }
    return 1.0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 5.0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = nil;
    
    for (NSString *info  in self.dataSource) {
        
    
        NSInteger nTag = [info integerValue];
        
        if (nTag == 1 && indexPath.section==0) {
            NSArray *arViews = [[NSBundle mainBundle] loadNibNamed:@"NewRSSCellView" owner:self options:nil];
            cell = (UITableViewCell*)[arViews objectAtIndex:0];
            
            self.btnSwitchURL = (UIButton*)[cell viewWithTag:1];
            [self.btnSwitchURL addTarget:self action:@selector(switchRSSType:) forControlEvents:UIControlEventTouchUpInside];
            
            self.btnSwitchBlog= (UIButton*)[cell viewWithTag:2];
            [self.btnSwitchBlog addTarget:self action:@selector(switchRSSType:) forControlEvents:UIControlEventTouchUpInside];
            //初使化selecet状态
        }
        else if (nTag == 2 && indexPath.section==1)
        {
            cell = [[UITableViewCell alloc] initWithStyle:0 reuseIdentifier:@"newRss"];
            self.tfURLStr = [[UITextField alloc] initWithFrame:CGRectInset(cell.bounds, 5, 5)];
            [self.tfURLStr setBackground:[UIImage imageNamed:@"bk_new_rss_tfurl"]];
            [cell addSubview:self.tfURLStr];
        }
        else if (nTag == 3 && indexPath.section==2)
        {
            cell = [[UITableViewCell alloc] initWithStyle:0 reuseIdentifier:@"newRss"];
            UIButton *btnDo = [UIButton buttonWithType:0];
            [btnDo setFrame:CGRectInset(cell.bounds, 20, 5)];
            [btnDo setTitle:@"增加" forState:UIControlStateNormal];
            [btnDo setBackgroundImage:[COM stretchiOS5:@"btn_new_rss_do"] forState:UIControlStateNormal];
            [btnDo addTarget:self action:@selector(actionDO:) forControlEvents:UIControlEventTouchUpInside];
            [cell addSubview:btnDo];
        }
        else if (nTag == 4 && indexPath.section==1)
        {
            
        }
    
    }
    
    //cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    
    //cell.textLabel.text = [NSString stringWithFormat:@"Cell %d", indexPath.row];
    
    return cell;
}

#pragma mark - UITableView Delegate methods

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

-(void) actionDO:(UIButton *) sender
{
    
}

-(void) switchRSSType:(UIButton*) sender
{
    
}
@end
