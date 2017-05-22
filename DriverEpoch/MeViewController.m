//
//  MeViewController.m
//  DriverEpoch
//
//  Created by halohily on 2017/3/9.
//  Copyright © 2017年 http://halohily.com. All rights reserved.
//

#import "MeViewController.h"
#import "AffairListCell.h"
#import "UserViewController.h"
#import "DELoginViewController.h"
#import "AppDelegate.h"
#import "HistoryPlacesController.h"
#import "OrdersController.h"
#import "PointsController.h"
@interface MeViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UIImageView *carImage;
@property (nonatomic, strong) UILabel *nickname;
@property (nonatomic, strong) UITableView *affairList;
@property (nonatomic, strong) NSArray *affairArr;
@property (nonatomic, strong) NSArray *settingArr;

@end

@implementation MeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupData];
    [self setupView];
    // Do any additional setup after loading the view.
}

- (void)setupData
{
    NSArray *array = @[@{@"affair": @"个人信息", @"icon": @"\U0000e89e", @"holder": @""}, @{@"affair": @"历史预定", @"icon": @"\U0000e61a", @"holder": @""}, @{@"affair": @"历史足迹", @"icon": @"\U0000e8d0", @"holder": @""}, @{@"affair": @"我的积分", @"icon": @"\U0000e86e", @"holder": @""}];
    self.affairArr = array;
    
    NSArray *temp = @[@{@"affair": @"清除缓存", @"icon": @"\U0000e8c1", @"holder": @"200K"}, @{@"affair": @"退出登录", @"icon": @"\U0000e603", @"holder": @""}];
    self.settingArr = temp;
    NSLog(@"%@",array);
}
- (void)setupView
{
    self.view.backgroundColor = DEColor(245, 245, 245);
    UIImageView *image = [[UIImageView alloc] initWithFrame:CGRectMake((DEAppWidth - 80)/2, 120, 80, 80)];
    image.layer.cornerRadius = 40;
    image.layer.masksToBounds = YES;
    [image setImage:[UIImage imageNamed:@"logo"]];
    [self.view addSubview:image];
    self.carImage = image;
    
    
    UILabel *nickname = [[UILabel alloc] initWithFrame:CGRectMake(0, 220, DEAppWidth, 20)];
    nickname.font = [UIFont systemFontOfSize:15.0];
    nickname.textColor = [UIColor blackColor];
    nickname.text = @"Enjoy Driving";
    nickname.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:nickname];
    self.nickname = nickname;
    
    UITableView *list = [[UITableView alloc] initWithFrame:CGRectMake(0, 260, DEAppWidth, 20 + self.affairArr.count * 40 + self.settingArr.count * 40) style:UITableViewStylePlain];
    list.scrollEnabled = NO;
    list.delegate = self;
    list.dataSource = self;
    list.separatorStyle = UITableViewCellSeparatorStyleNone;
    [list registerClass:[AffairListCell class] forCellReuseIdentifier:@"affairCell"];
    [self.view addSubview:list];
    self.affairList = list;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark tableview delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0)
        return self.affairArr.count;
    else
        return self.settingArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    AffairListCell *cell = [self.affairList dequeueReusableCellWithIdentifier:@"affairCell"];
    if (indexPath.section == 0)
    {
        cell.affair.text = self.affairArr[indexPath.row][@"affair"];
        cell.affairIcon.text = self.affairArr[indexPath.row][@"icon"];
        cell.holderLabel.text = self.affairArr[indexPath.row][@"holder"];
    }
    else
    {
        cell.affair.text = self.settingArr[indexPath.row][@"affair"];
        cell.affairIcon.text = self.settingArr[indexPath.row][@"icon"];
        cell.holderLabel.text = self.settingArr[indexPath.row][@"holder"];
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0 && indexPath.row == 0){
        UserViewController *userVC = [[UserViewController alloc] init];
        [self.navigationController pushViewController:userVC animated:YES];
    }
    if (indexPath.section == 1 && indexPath.row == 1){
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"确认退出登录?" message:nil preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            NSLog(@"点击取消");
            [alert dismissViewControllerAnimated:YES completion:nil];
            
        }]];
        [alert addAction:[UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            NSLog(@"点击确认");
            [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"username"];
            [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"nickname"];
            [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"id"];
            [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"car"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            DELoginViewController *loginVC = [[DELoginViewController alloc] init];
            [self presentViewController:loginVC animated:YES completion:^{
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                    // 耗时的操作
                    dispatch_async(dispatch_get_main_queue(), ^{
                        // 更新界面
                        AppDelegate * appDelegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
                        appDelegate.tabbarVC.selectedIndex = 0;
                    });
                });
            }];
        }]];
        [self presentViewController:alert animated:YES completion:nil];

    }
    if (indexPath.section == 0 && indexPath.row == 2){
        HistoryPlacesController *historyVC = [[HistoryPlacesController alloc] init];
        [self.navigationController pushViewController:historyVC animated:YES];
    }
    if (indexPath.section == 0 && indexPath.row == 1){
        OrdersController *orderVC = [[OrdersController alloc] init];
        [self.navigationController pushViewController:orderVC animated:YES];
    }
    if (indexPath.section == 0 && indexPath.row == 3){
        PointsController *pointsVC = [[PointsController alloc] init];
        [self.navigationController pushViewController:pointsVC animated:YES];
    }
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, DEAppWidth, 10)];
    header.backgroundColor = DEColor(245, 245, 245);
    
    return header;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}
@end
