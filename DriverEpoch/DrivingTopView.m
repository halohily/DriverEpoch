//
//  DrivingTopView.m
//  DriverEpoch
//
//  Created by halohily on 2017/3/9.
//  Copyright © 2017年 http://halohily.com. All rights reserved.
//

#import "DrivingTopView.h"

@interface DrivingTopView()



@end



@implementation DrivingTopView


- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        [self initialization];
    }
    return self;
}

- (void)initialization
{
    self.backgroundColor = DENavBarColorBlue;
    
    UIView *locationView = [[UIView alloc] initWithFrame:CGRectMake(10, 45, 20 + DEAppWidth * 0.5, 20)];
    locationView.backgroundColor = [UIColor clearColor];
    
    UILabel *locationIcon = [[UILabel alloc] init];
    locationIcon.frame = CGRectMake(0, 0, 20, 20);
    locationIcon.font = [UIFont fontWithName:@"iconfont" size:20.0];
    locationIcon.text = @"\U0000e8ba";
    locationIcon.textColor = [UIColor whiteColor];
    [locationView addSubview:locationIcon];
    self.locationImage = locationIcon;
    
    UILabel *location = [[UILabel alloc] init];
    location.frame = CGRectMake(30, 0, DEAppWidth * 0.5, 20);
    location.textColor = [UIColor whiteColor];
    location.font = [UIFont systemFontOfSize:20];
    location.textAlignment = NSTextAlignmentLeft;
    [locationView addSubview:location];
    self.locationLabel = location;
    
    [self addSubview:locationView];
    
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(reLocatingClick:)];
    [locationView addGestureRecognizer:tapGestureRecognizer];
    
    self.locationBtn = locationView;
        
    UILabel *temperature = [[UILabel alloc] init];
    temperature.frame = CGRectMake(DEAppWidth * 0.75, 40, DEAppWidth * 0.08, 15);
    temperature.textColor = [UIColor whiteColor];
    temperature.font = [UIFont systemFontOfSize:15];
    temperature.textAlignment = NSTextAlignmentCenter;
//    temperature.text = @"17°";
    [self addSubview:temperature];
    self.temperatureLabel = temperature;
    
    UILabel *weather = [[UILabel alloc] init];
    weather.frame = CGRectMake(DEAppWidth * 0.75, 56, DEAppWidth * 0.08, 12);
    weather.textColor = [UIColor whiteColor];
    weather.font = [UIFont systemFontOfSize:12];
    weather.textAlignment = NSTextAlignmentCenter;
//    weather.text = @"晴天";
    [self addSubview:weather];
    self.weatherLabel = weather;

    UIButton *weatherInfo = [[UIButton alloc] initWithFrame:CGRectMake(DEAppWidth * 0.85, 40, 26, 26)];
    [weatherInfo setTitle:@"\U0000e65c" forState:UIControlStateNormal];
    weatherInfo.titleLabel.font = [UIFont fontWithName:@"iconfont" size:26.0];
    [weatherInfo addTarget:self action:@selector(weatherInfoClick) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:weatherInfo];
    self.weatherInfos = weatherInfo;
    
}
-(void)reLocatingClick:(UIButton *)sender
{
    NSLog(@"click");
    [self.delegate respondsToSelector:@selector(reLocateBtnClick)];
    [self.delegate reLocateBtnClick];
}

- (void)weatherInfoClick
{
    NSLog(@"weatherinfo click");
    [self.delegate respondsToSelector:@selector(weatherInfo)];
    [self.delegate weatherInfo];
}
@end
