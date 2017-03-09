//
//  DrivingTopView.h
//  DriverEpoch
//
//  Created by halohily on 2017/3/9.
//  Copyright © 2017年 http://halohily.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DrivingTopView : UIView

@property (nonatomic, weak) UIImageView *locationImage;
@property (nonatomic, weak) UILabel *locationLabel;
@property (nonatomic, weak) UIButton *reLocatingBtn;
@property (nonatomic, weak) UILabel *temperatureLabel;
@property (nonatomic, weak) UILabel *weatherLabel;
@property (nonatomic, weak) UIImageView *weatherImage;

- (instancetype)initWithFrame:(CGRect)frame;

@end
