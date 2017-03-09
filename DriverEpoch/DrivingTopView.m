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
    
    UIImageView *locationIcon = [[UIImageView alloc] init];
    locationIcon.frame = CGRectMake(0, 0, 15, 20);
    locationIcon.image = [UIImage imageNamed:@"location_icon"];
    [locationView addSubview:locationIcon];
    self.locationImage = locationIcon;
    
    UILabel *location = [[UILabel alloc] init];
    location.frame = CGRectMake(20, 0, DEAppWidth * 0.5, 20);
    location.textColor = [UIColor whiteColor];
    location.font = [UIFont systemFontOfSize:20];
    location.textAlignment = NSTextAlignmentLeft;
    location.text  = @"北京理工大学";
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
    temperature.textAlignment = NSTextAlignmentLeft;
    temperature.text = @"17°";
    [self addSubview:temperature];
    self.temperatureLabel = temperature;
    
    UILabel *weather = [[UILabel alloc] init];
    weather.frame = CGRectMake(DEAppWidth * 0.75, 56, DEAppWidth * 0.08, 12);
    weather.textColor = [UIColor whiteColor];
    weather.font = [UIFont systemFontOfSize:12];
    weather.textAlignment = NSTextAlignmentLeft;
    weather.text = @"晴天";
    [self addSubview:weather];
    self.weatherLabel = weather;

    UIImageView *weatherIcon = [[UIImageView alloc] init];
    weatherIcon.frame = CGRectMake(DEAppWidth * 0.85, 40, 26, 26);
    weatherIcon.image = [UIImage imageNamed:@"location_icon"];
    [self addSubview:weatherIcon];
    self.weatherImage = weatherIcon;
}
-(void)reLocatingClick:(UIButton *)sender
{
    NSLog(@"click");
    [self.delegate respondsToSelector:@selector(reLocateBtnClick)];
    [self.delegate reLocateBtnClick];
}
@end
