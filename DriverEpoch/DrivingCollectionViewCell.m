//
//  DrivingCollectionViewCell.m
//  DriverEpoch
//
//  Created by 刘毅 on 2017/3/12.
//  Copyright © 2017年 http://halohily.com. All rights reserved.
//

#import "DrivingCollectionViewCell.h"

@implementation DrivingCollectionViewCell

-(instancetype)mycell
{
    DrivingCollectionViewCell *myCell = [[DrivingCollectionViewCell alloc] init];
    
    myCell.frame = CGRectMake(0, 0, DEAppWidth/2 - 2, DEAppWidth/2 - 2);
    myCell.backgroundColor = [UIColor whiteColor];
    UIImageView *image = [[UIImageView alloc] initWithFrame:CGRectMake(DEAppWidth/8, 20, DEAppWidth/4, DEAppWidth/4)];
    [myCell.contentView addSubview:image];
    myCell.itemImage = image;
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(DEAppWidth/8, 35 + DEAppWidth/4, DEAppWidth/4, 20)];
    label.textColor = [UIColor blackColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:20.0];
    [myCell.contentView addSubview:label];
    myCell.itemName = label;
    return myCell;
}
@end
