//
//  LocationViewController.h
//  DriverEpoch
//
//  Created by halohily on 2017/3/10.
//  Copyright © 2017年 http://halohily.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LocationViewDelegate <NSObject>

- (void)reLocate;

@end
@interface LocationViewController : UIViewController

@property (nonatomic, strong) NSString *locationStr;
@property (nonatomic, strong) UILabel *locationLabel;
@property (nonatomic, strong) NSMutableArray *pois;
@property (nonatomic, weak) id<LocationViewDelegate> delegate;

@end
