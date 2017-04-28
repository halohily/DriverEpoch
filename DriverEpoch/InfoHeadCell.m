//
//  InfoHeadCell.m
//  DriverEpoch
//
//  Created by 刘毅 on 2017/4/16.
//  Copyright © 2017年 http://halohily.com. All rights reserved.
//

#import "InfoHeadCell.h"

@implementation InfoHeadCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        self.contentView.backgroundColor = [UIColor whiteColor];
        UIImageView *imageview = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, DEAppWidth, 180)];
        [self.contentView addSubview:imageview];
        self.backImg = imageview;
        
        UILabel *title = [[UILabel alloc]initWithFrame:CGRectMake(0, 130, DEAppWidth, 16)];
        title.textAlignment = NSTextAlignmentCenter;
        title.font = [UIFont boldSystemFontOfSize:16.0];
        title.textColor = [UIColor whiteColor];
        [_backImg addSubview:title];
        self.titleLabel = title;
        
        UILabel *time = [[UILabel alloc] initWithFrame:CGRectMake(DEAppWidth/2 - 50, 150, 50, 10)];
        time.textAlignment = NSTextAlignmentLeft;
        time.font = [UIFont fontWithName:@"iconfont" size:10.0];
        time.textColor = [UIColor whiteColor];
        [_backImg addSubview:time];
        self.timeLabel = time;
        
        UILabel *source = [[UILabel alloc] initWithFrame:CGRectMake(DEAppWidth/2 + 10, 150, 70, 10)];
        source.textAlignment = NSTextAlignmentLeft;
        source.font = [UIFont fontWithName:@"iconfont" size:10.0];
        source.textColor = [UIColor whiteColor];
        [_backImg addSubview:source];
        self.sourceLabel = source;
        
        
        
    }
    return self;
}
@end
