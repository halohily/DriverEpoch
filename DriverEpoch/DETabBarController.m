//
//  DETabBarController.m
//  DriverEpoch
//
//  Created by halohily on 2017/3/9.
//  Copyright © 2017年 http://halohily.com. All rights reserved.
//

#import "DETabBarController.h"
#import "DENavigationController.h"
#import "DEViewController.h"
#import "DrivingViewController.h"
#import "InfoViewController.h"
#import "MeViewController.h"

@interface DETabBarController ()

@end

@implementation DETabBarController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self setupTabbar];
    // Do any additional setup after loading the view.
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setupTabbar
{
    DrivingViewController *vc1 = [[DrivingViewController alloc] init];
    [self addChildViewController:vc1 withImage:[UIImage imageNamed:@"tabbar_video"] selectedImage:[UIImage imageNamed:@"tabbar_video_hl"] withTittle:@"行车"];
    
    InfoViewController *vc2 = [[InfoViewController alloc] init];
    [self addChildViewController:vc2 withImage:[UIImage imageNamed:@"tabbar_news"] selectedImage:[UIImage imageNamed:@"tabbar_news_hl"] withTittle:@"资讯"];
    
    MeViewController *vc3 = [[MeViewController alloc] init];
    [self addChildViewController:vc3 withImage:[UIImage imageNamed:@"tabbar_setting"] selectedImage:[UIImage imageNamed:@"tabbar_setting_hl"] withTittle:@"我"];
    
}

- (void)addChildViewController:(UIViewController *)controller withImage:(UIImage *)image selectedImage:(UIImage *)selectImage withTittle:(NSString *)tittle
{
    
    DENavigationController *nav = [[DENavigationController alloc] initWithRootViewController:controller];
    
    [nav.tabBarItem setImage:image];
    [nav.tabBarItem setSelectedImage:selectImage];
    
    controller.title = tittle;
    
    [nav.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor blackColor]} forState:UIControlStateSelected];
    nav.tabBarItem.titlePositionAdjustment = UIOffsetMake(0, -3);
    [self addChildViewController:nav];
    
}

@end
