//
//  WeatherController.m
//  DriverEpoch
//
//  Created by 刘毅 on 2017/4/30.
//  Copyright © 2017年 http://halohily.com. All rights reserved.
//

#import "WeatherController.h"

@interface WeatherController ()

@end

@implementation WeatherController

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        self.view.frame = CGRectMake(100, 100, 50, 50);
        self.view.backgroundColor = [UIColor blueColor];
    }
    self.modalPresentationStyle = UIModalPresentationFormSheet;
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
