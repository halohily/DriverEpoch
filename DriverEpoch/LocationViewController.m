//
//  LocationViewController.m
//  DriverEpoch
//
//  Created by halohily on 2017/3/10.
//  Copyright © 2017年 http://halohily.com. All rights reserved.
//

#import "LocationViewController.h"

@interface LocationViewController ()

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
    
    UIButton *closeBtn = [[UIButton alloc] initWithFrame:CGRectMake(15, 35, 20, 20)];
    [closeBtn setImage:[UIImage imageNamed:@"left_icon_close"] forState:UIControlStateNormal];
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
    
    UIButton *reLocate = [[UIButton alloc] initWithFrame:CGRectMake(DEAppWidth * 0.8, 15, DEAppWidth * 0.2, 15)];
    [reLocate setTitle:@"重新定位" forState:UIControlStateNormal];
    [reLocate setTitleColor:DEColor(26, 152, 252) forState:UIControlStateNormal];
    reLocate.titleLabel.font = [UIFont systemFontOfSize:15];
    reLocate.contentHorizontalAlignment = NSTextAlignmentCenter;
    [reLocate addTarget:self action:@selector(reLocateClick) forControlEvents:UIControlEventTouchUpInside];
    [locationView addSubview:reLocate];
    
}

- (void)reLocateClick
{
    NSLog(@"--reLocateClicked--");
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
