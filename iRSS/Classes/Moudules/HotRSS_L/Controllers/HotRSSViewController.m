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
{

}
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
    
    self.title = @"目录夹";
    
    _rssCateDao = [[RSSCategoryDao alloc] init];
    self.dataSource = [_rssCateDao getAllRSSCategorys];
    
    
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:1];
    _tableView.delegate  = self;
    _tableView.dataSource= self;
    [self.view addSubview:_tableView];

    //
    UIBarButtonItem *item1 = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"btn_category_add"] style:UIBarButtonItemStylePlain target:self action:@selector(addNew)];
    UIBarButtonItem *item2 = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"btn_category_edit"] style:UIBarButtonItemStylePlain target:self action:@selector(edit:)];
    
    [self.navigationItem setRightBarButtonItems:@[item2,item1]];
    
    [item1 release];
    [item2 release];
    
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
    
    RSSCategoryCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if(cell == nil) {
        NSArray* objs = [[NSBundle mainBundle] loadNibNamed:@"RSSCategoryCell" owner:self options:nil];
        cell = [objs objectAtIndex:0];
    }
    
    RSSCategoryEntity *cateEnty = [self.dataSource objectAtIndex:indexPath.row];
    
    UIImage *image = [UIImage imageNamed:cateEnty.strIconName==NULL?@"icon":cateEnty.strIconName];
    image = [COM scaleToSize:image size:CGSizeMake(40, 40)];
    //[cell.ivImageView setImage:image];
    [cell.imageView setImage:image];
    
    [cell.lbTitile setText:cateEnty.strName];
    [cell.lbNum setText:[NSString stringWithFormat:@"[%d]",cateEnty.nRssNum]];
    
    return cell;
}

#pragma mark - UITableView Delegate methods

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

- (void)tableView:(UITableView*)tableView didEndEditingRowAtIndexPath:(NSIndexPath *)indexPath
{
    RSSCategoryEntity *rssCateEnty = [self.dataSource objectAtIndex:indexPath.row];
    if([self.rssCateDao delRSSGroupRecWithCateID:rssCateEnty.nId])
    {
        [self.dataSource removeObjectAtIndex:indexPath.row];
        [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    }
    else
    {
        //self.view add
    }

    //操作数据库
}

#pragma mark - Action Function
-(void) edit:(UIBarButtonItem*)sender
{
    [self.tableView setEditing:!self.tableView.editing animated:NO];
}

-(void) addNew
{
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"*选择*" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"新建目录夹" otherButtonTitles:@"导入RSS目录",@"备份RSS目录",nil];
    [actionSheet showInView:self.view];
    [actionSheet release];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex==0) { //new
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"新建目录夹" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        alertView.alertViewStyle = UIAlertViewStylePlainTextInput;
        alertView.tag =1;
        [alertView show];
        [alertView release];
    }
    else if (buttonIndex==1) //import
    {
        
    }
    else if (buttonIndex==2)//export
    {
        
    }
    return;
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex==1) {
        
        NSString *newCategoryName = [alertView textFieldAtIndex:0].text;
        if (newCategoryName==NULL || [newCategoryName isEqualToString:@""]) {
            SH_Alert(@"请输入新的目录夹名称...");
            return;
        }
        
        RSSCategoryEntity *rssCateEnty = [[RSSCategoryEntity alloc] init];
        rssCateEnty.strName = newCategoryName;
        
        BOOL isState = [self.rssCateDao addForRSSCategoryEntity:rssCateEnty];
        if (!isState)
        {
            SH_Alert(@"该目录夹已存在,请重新输入...");
        }
        else
        {
            [self.dataSource addObject:rssCateEnty];
            [self.tableView  reloadData];
        }

        [rssCateEnty release];
    }
    return;
}

@end
