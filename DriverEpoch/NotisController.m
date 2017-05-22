//
//  NotisController.m
//  DriverEpoch
//
//  Created by 刘毅 on 2017/5/22.
//  Copyright © 2017年 http://halohily.com. All rights reserved.
//

#import "NotisController.h"
#import "OrderCell.h"
@interface NotisController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *myTable;
@property (nonatomic, strong) NSMutableArray *tableData;
@property (nonatomic, strong) UIView *loadingView;
@property (nonatomic, strong) UIView *blankView;
@end

@implementation NotisController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initloading];
    [self setupView];
    [self setupData];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setupView
{
    self.navigationController.navigationBar.hidden = NO;
    self.view.backgroundColor = DEColor(245, 245, 245);
    self.title = @"通知列表";
    UITableView *table = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, DEAppWidth, DEAppHeight - 64) style:UITableViewStylePlain];
    table.delegate = self;
    table.dataSource = self;
    table.backgroundColor = DEColor(245, 245, 245);
    [table registerClass:[OrderCell class] forCellReuseIdentifier:@"orderCell"];
    table.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view insertSubview:table atIndex:0];
    self.myTable = table;
}
- (void)setupData
{
    NSMutableArray *orders = [[NSUserDefaults standardUserDefaults] objectForKey:@"orderStates"];
    self.tableData = orders;
    if (orders.count == 0)
    {
        [self.view insertSubview:self.blankView atIndex:1];
    }
    else{
        self.myTable.frame = CGRectMake(0, 0, DEAppWidth, 168 * self.tableData.count > DEAppHeight ? DEAppHeight : 168 * self.tableData.count + 64);
        [self.myTable reloadData];
    }
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.loadingView removeFromSuperview];
    });
}

#pragma mark loadingView
- (void)initloading
{
    UIView *loadingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, DEAppWidth, DEAppHeight)];
    loadingView.backgroundColor = DEColor(245, 245, 245);
    
    
    UIImageView *logo = [[UIImageView alloc] initWithFrame:CGRectMake(DEAppWidth / 2 - 50, 200, 100, 100)];
    [logo setImage:[UIImage imageNamed:@"logo"]];
    [loadingView addSubview:logo];
    
    CABasicAnimation *animation =[CABasicAnimation animationWithKeyPath:@"opacity"];
    animation.fromValue = [NSNumber numberWithFloat:1.0f];
    animation.toValue = [NSNumber numberWithFloat:0.0f];
    animation.autoreverses = YES;    //回退动画（动画可逆，即循环）
    animation.duration = 0.5f;
    animation.repeatCount = MAXFLOAT;
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;//removedOnCompletion,fillMode配合使用保持动画完成效果
    animation.timingFunction=[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    [logo.layer addAnimation:animation forKey:@"aAlpha"];
    
    UILabel *tips = [[UILabel alloc] initWithFrame:CGRectMake(0, 320, DEAppWidth, 20)];
    tips.textColor = DENavBarColorBlue;
    tips.text = @"加载中...";
    tips.textAlignment =  NSTextAlignmentCenter;
    tips.font = [UIFont systemFontOfSize:20.0];
    [loadingView addSubview:tips];
    
    self.loadingView = loadingView;
    [self.view addSubview:loadingView];
}

- (UIView *)blankView
{
    if (!_blankView)
    {
        UIView *blank = [[UIView alloc] initWithFrame:CGRectMake(0, 64, DEAppWidth, DEAppHeight - 64)];
        blank.backgroundColor = DEColor(245, 245, 245);
        UILabel *logo = [[UILabel alloc] initWithFrame:CGRectMake(DEAppWidth / 2 - 35, 200, 70, 70)];
        logo.font = [UIFont fontWithName:@"iconfont" size:50.0];
        logo.textAlignment = NSTextAlignmentCenter;
        logo.textColor = DENavBarColorBlue;
        logo.text = @"\U0000e7ec";
        [blank addSubview:logo];
        
        UILabel *tips = [[UILabel alloc] initWithFrame:CGRectMake(0, 280, DEAppWidth, 20)];
        tips.textColor = DENavBarColorBlue;
        tips.textAlignment = NSTextAlignmentCenter;
        tips.font = [UIFont systemFontOfSize:18.0];
        tips.text = @"暂无通知";
        [blank addSubview:tips];
        
        _blankView = blank;
    }
    return _blankView;
}
#pragma mark tableview delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.tableData.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 168;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    OrderCell *cell = [self.myTable dequeueReusableCellWithIdentifier:@"orderCell"];
    cell.name.text = [self.tableData objectAtIndex:indexPath.row][@"name"];
    cell.address.text = [self.tableData objectAtIndex:indexPath.row][@"address"];
    NSString *state = [self.tableData objectAtIndex:indexPath.row][@"state"];
    if ([state isEqualToString:@"0"]){
        cell.state.text = @"\U0000e697";
    }
    else{
        cell.state.text = @"\U0000e63c";
    }
    return cell;
}

-(void)viewWillDisappear:(BOOL)animated
{
    self.navigationController.navigationBar.hidden = YES;
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"orderStates"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"addOrderStates" object:nil];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
