//
//  LocationViewController.m
//  DriverEpoch
//
//  Created by halohily on 2017/3/10.
//  Copyright © 2017年 http://halohily.com. All rights reserved.
//

#import "LocationViewController.h"

@interface LocationViewController ()<UITableViewDelegate, UITableViewDataSource>

@end

@implementation LocationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupView];
}

- (void)setupView
{
    self.view.backgroundColor = DEColor(244, 245, 246);
    
    UIView *top = [[UIView alloc] initWithFrame:CGRectMake(0, 0, DEAppWidth, 100)];
    top.backgroundColor = DENavBarColorBlue;
    [self.view addSubview:top];
    
    UIButton *closeBtn = [[UIButton alloc] initWithFrame:CGRectMake(15, 35, 25, 25)];
    
    [closeBtn setTitle:@"\U0000e86d" forState:UIControlStateNormal];
    closeBtn.titleLabel.font = [UIFont fontWithName:@"iconfont" size:25.0];
    
    [closeBtn addTarget:self action:@selector(closeBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [top addSubview:closeBtn];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(DEAppWidth * 0.25, 35, DEAppWidth * 0.5, 20)];
    titleLabel.font = [UIFont boldSystemFontOfSize:20];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.text = @"定位当前地址";
    [top addSubview:titleLabel];
    
    UILabel *headerLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 120, 200, 15)];
    headerLabel.font = [UIFont systemFontOfSize:15];
    headerLabel.textAlignment = NSTextAlignmentLeft;
    headerLabel.textColor = DEColor(101, 102, 103);
    headerLabel.text = @"当前地址";
    [self.view addSubview:headerLabel];
    
    UIView *locationView = [[UIView alloc] initWithFrame:CGRectMake(0, 145, DEAppWidth, 45)];
    locationView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:locationView];
    
    UILabel *location = [[UILabel alloc] initWithFrame:CGRectMake(15, 15, DEAppWidth * 0.6, 15)];
    location.textColor = DEColor(51, 52, 53);
    location.textAlignment = NSTextAlignmentLeft;
    location.font = [UIFont systemFontOfSize:15];
    location.text = self.locationStr;
    self.locationLabel = location;
    [locationView addSubview:location];
    
    UIButton *reLocate = [[UIButton alloc] initWithFrame:CGRectMake(DEAppWidth - 90, 15, 80, 15)];
    [reLocate setTitle:@"\U0000e8a4 重新定位" forState:UIControlStateNormal];
    [reLocate setTitleColor:DEColor(26, 152, 252) forState:UIControlStateNormal];
    reLocate.titleLabel.font = [UIFont fontWithName:@"iconfont" size:15.0];
    reLocate.contentHorizontalAlignment = NSTextAlignmentRight;
    [reLocate addTarget:self action:@selector(reLocateClick) forControlEvents:UIControlEventTouchUpInside];
    [locationView addSubview:reLocate];
    
    UILabel *headerLabelMore = [[UILabel alloc] initWithFrame:CGRectMake(15, 215, 200, 15)];
    headerLabelMore.font = [UIFont systemFontOfSize:15];
    headerLabelMore.textAlignment = NSTextAlignmentLeft;
    headerLabelMore.textColor = DEColor(101, 102, 103);
    headerLabelMore.text = @"附近地址";
    [self.view addSubview:headerLabelMore];
    
    UITableView *addressTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 240, DEAppWidth, 135) style:UITableViewStylePlain];
    addressTable.delegate = self;
    addressTable.dataSource = self;
    [self.view addSubview:addressTable];
    
    
}

- (void)reLocateClick
{
    NSLog(@"--reLocateClicked--");
    [self.delegate respondsToSelector:@selector(reLocate)];
    [self.delegate reLocate];
    [self dismissViewControllerAnimated:YES completion:NULL];

}

- (void)closeBtnClick
{
    [self dismissViewControllerAnimated:YES completion:NULL];
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark tableview delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.pois count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 45;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc] init];
    cell.textLabel.font = [UIFont systemFontOfSize:15];
    cell.textLabel.textColor = DEColor(51, 52, 53);
    cell.textLabel.textAlignment = NSTextAlignmentLeft;
    cell.textLabel.text = self.pois[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleGray;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [[NSUserDefaults standardUserDefaults] setObject:self.pois[indexPath.row] forKey:@"address"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    NSNotification *changeAddNotice = [[NSNotification alloc] initWithName:@"changeAddress" object:nil userInfo:nil];
    [[NSNotificationCenter defaultCenter] postNotification:changeAddNotice];
    [self closeBtnClick];
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
