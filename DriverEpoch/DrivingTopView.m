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
    
    UIImageView *locationIcon = [[UIImageView alloc] init];
    locationIcon.frame = CGRectMake(10, 10, 10, 15);
    locationIcon.image = [UIImage imageNamed:@"location_icon"];
    [self addSubview:locationIcon];
    self.locationImage = locationIcon;
    
    UILabel *location = [[UILabel alloc] init];
    location.frame = CGRectMake(30, 10, 200, 15);
    location.textColor = [UIColor whiteColor];
    location.font = [UIFont systemFontOfSize:15];
    location.textAlignment = NSTextAlignmentLeft;
    location.text  = @"北京理工大学";
    [self addSubview:location];
    self.locationLabel = location;
    
    UIButton *locate = [[UIButton alloc] init];
    locate.frame = CGRectMake(240, 10, 10, 15);
    [locate setImage:[UIImage imageNamed:@"location_icon"] forState:UIControlStateNormal];
    [locate addTarget:self action:@selector(reLocatingClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:locate];
    self.reLocatingBtn = locate;
    
}
-(void)reLocatingClick:(UIButton *)sender
{
    
}
@end
