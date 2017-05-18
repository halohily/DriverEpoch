//
//  InfoDetailController.m
//  DriverEpoch
//
//  Created by 刘毅 on 2017/4/16.
//  Copyright © 2017年 http://halohily.com. All rights reserved.
//

#import "InfoDetailController.h"

@interface InfoDetailController ()<UIWebViewDelegate>
@property (nonatomic, strong) UIWebView *webView;
@property (nonatomic, strong) UIView *loading;
@end

@implementation InfoDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initloading];
    [self.view addSubview:self.loading];
    // Do any additional setup after loading the view.
    UIWebView *myWebview = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, DEAppWidth, DEAppHeight)];
    myWebview.delegate = self;
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:self.url]];
    [myWebview loadRequest:request];
    [self.view insertSubview:myWebview atIndex:0];
    self.webView = myWebview;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark loadingView
- (void)initloading
{
    UIView *loadingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, DEAppWidth, DEAppHeight)];
    loadingView.backgroundColor = DEColor(245, 245, 245);
    
    UIButton *backBtn = [[UIButton alloc] initWithFrame:CGRectMake(12, 30, 30, 30)];
    backBtn.titleLabel.font = [UIFont fontWithName:@"iconfont" size:30.0];
    
    [backBtn setTitle:@"\U0000e604" forState:UIControlStateNormal];
    backBtn.titleLabel.textColor = [UIColor whiteColor];
    backBtn.titleLabel.textAlignment = NSTextAlignmentLeft;
    backBtn.backgroundColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.5];
    backBtn.layer.cornerRadius = 15;
    backBtn.layer.masksToBounds = YES;
    [loadingView addSubview:backBtn];
    [backBtn addTarget:self action:@selector(backClick) forControlEvents:UIControlEventTouchUpInside];
    
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
    
    self.loading = loadingView;
    
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.loading removeFromSuperview];
    });
}

- (void)backClick
{
    [self.navigationController popViewControllerAnimated:YES];
}


@end
