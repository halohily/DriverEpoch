//
//  DrivingViewController.m
//  DriverEpoch
//
//  Created by halohily on 2017/3/9.
//  Copyright © 2017年 http://halohily.com. All rights reserved.
//

#import "DrivingViewController.h"
#import "DrivingTopView.h"

@interface DrivingViewController ()

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
    DrivingTopView *topView = [[DrivingTopView alloc] initWithFrame:CGRectMake(0, 64, DEAppWidth, 50)];
    [self.view addSubview:topView];
    
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
