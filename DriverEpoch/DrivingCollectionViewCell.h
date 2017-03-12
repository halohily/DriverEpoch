//
//  DrivingCollectionViewCell.h
//  DriverEpoch
//
//  Created by 刘毅 on 2017/3/12.
//  Copyright © 2017年 http://halohily.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DrivingCollectionViewCell : UICollectionViewCell

@property (nonatomic, weak) UIImageView *itemImage;
@property (nonatomic, weak) UILabel *itemName;
-(instancetype)mycell;
@end
