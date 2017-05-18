//
//  DEPOICell.h
//  DriverEpoch
//
//  Created by 刘毅 on 2017/4/30.
//  Copyright © 2017年 http://halohily.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol DEPOICellDelegate <NSObject>

- (void)callNumber:(NSString *)tel;
- (void)naviForIndex:(NSUInteger)index;
- (void)date;
@end
@interface DEPOICell : UITableViewCell

@property (nonatomic, weak) id<DEPOICellDelegate> delegate;
@property (nonatomic, strong) UILabel *name;
@property (nonatomic, strong) UILabel *distance;
@property (nonatomic, strong) UILabel *location;
@property (nonatomic, strong) UIView *datingBtn;
@property (nonatomic, strong) NSString *tel;
@property (nonatomic, assign) NSUInteger index;
@end
