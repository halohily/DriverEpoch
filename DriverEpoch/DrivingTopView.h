//
//  DrivingTopView.h
//  DriverEpoch
//
//  Created by halohily on 2017/3/9.
//  Copyright © 2017年 http://halohily.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol DrivingTopViewDelegate <NSObject>

@required

- (void) reLocateBtnClick;

- (void) weatherInfo;
@end








@interface DrivingTopView : UIView

@property (nonatomic, weak) id <DrivingTopViewDelegate> delegate;

@property (nonatomic, strong) UILabel *locationImage;
@property (nonatomic, strong) UILabel *locationLabel;

@property (nonatomic, strong) UILabel *temperatureLabel;
@property (nonatomic, strong) UILabel *weatherLabel;
@property (nonatomic, strong) UIButton *weatherInfos;
@property (nonatomic, strong) UIView *locationBtn;
@property (nonatomic, strong) UILabel *notisNum;
- (instancetype)initWithFrame:(CGRect)frame;

@end
