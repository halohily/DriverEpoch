//
//  DrivingViewController.m
//  DriverEpoch
//
//  Created by halohily on 2017/3/9.
//  Copyright © 2017年 http://halohily.com. All rights reserved.
//

#import "DrivingViewController.h"
#import "LocationViewController.h"

@interface DrivingViewController ()<DrivingTopViewDelegate>

@property (nonatomic, weak) NSString *locationStr;
@end

@implementation DrivingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupView];
    // Do any additional setup after loading the view.
}

- (void)setupView
{
    self.view.backgroundColor = [UIColor whiteColor];
    DrivingTopView *topview = [[DrivingTopView alloc] initWithFrame:CGRectMake(0, 0, DEAppWidth, 100)];
    [self.view addSubview:topview];
    topview.delegate = self;
    self.locationStr = topview.locationLabel.text;
    self.topView = topview;
    
}

- (void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBar.hidden = YES;
}





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) reLocateBtnClick
{
//    self.topView.locationLabel.text = @"s";
    NSLog(@"222");
    LocationViewController *locationView = [[LocationViewController alloc] init];
    locationView.locationStr = self.locationStr;
    [self presentViewController:locationView animated:YES completion:NULL];
    
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
