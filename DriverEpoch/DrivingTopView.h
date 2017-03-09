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

@end








@interface DrivingTopView : UIView

@property (nonatomic, weak) id <DrivingTopViewDelegate> delegate;

@property (nonatomic, weak) UIImageView *locationImage;
@property (nonatomic, weak) UILabel *locationLabel;

@property (nonatomic, weak) UILabel *temperatureLabel;
@property (nonatomic, weak) UILabel *weatherLabel;
@property (nonatomic, weak) UIImageView *weatherImage;
@property (nonatomic, weak) UIView *locationBtn;
- (instancetype)initWithFrame:(CGRect)frame;

@end
