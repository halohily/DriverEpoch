//
//  PlaceCell.m
//  DriverEpoch
//
//  Created by 刘毅 on 2017/5/21.
//  Copyright © 2017年 http://halohily.com. All rights reserved.
//

#import "PlaceCell.h"

@implementation PlaceCell

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
        self.backgroundColor = [UIColor whiteColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        UIView *head = [[UIView alloc] initWithFrame:CGRectMake(0, 0, DEAppWidth, 12)];
        head.backgroundColor = DEColor(245, 245, 245);
        [self.contentView addSubview:head];
        
        UIView *line_1 = [[UIView alloc] initWithFrame:CGRectMake(0, 12, DEAppWidth, 0.5)];
        line_1.backgroundColor = DEBGColorGray;
        [self.contentView addSubview:line_1];
        
        UILabel *logo = [[UILabel alloc] initWithFrame:CGRectMake(10, 22.5, 30, 30)];
        logo.font = [UIFont fontWithName:@"iconfont" size:20.0];
        logo.textAlignment = NSTextAlignmentCenter;
        logo.textColor = DENavBarColorBlue;
        logo.text = @"\U0000e8ba";
        [self.contentView addSubview:logo];
        self.logo = logo;
        
        UILabel *name = [[UILabel alloc] initWithFrame:CGRectMake(50, 27.5, DEAppWidth * 0.6, 20)];
        name.textColor = [UIColor blackColor];
        name.font = [UIFont systemFontOfSize:20.0];
        name.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:name];
        self.name = name;
        
        UIView *line_2 = [[UIView alloc] initWithFrame:CGRectMake(0, 62.5, DEAppWidth, 0.5)];
        line_2.backgroundColor = DEBGColorGray;
        [self.contentView addSubview:line_2];
        
        UILabel *address = [[UILabel alloc] initWithFrame:CGRectMake(30, 83, DEAppWidth - 60, 32)];
        address.textColor = [UIColor blackColor];
        address.textAlignment = NSTextAlignmentLeft;
        address.lineBreakMode = NSLineBreakByWordWrapping;
        address.numberOfLines = 0;
        address.font = [UIFont systemFontOfSize:13.0];
        [self.contentView addSubview:address];
        self.address = address;
        
        UIView *line_3 = [[UIView alloc] initWithFrame:CGRectMake(0, 135, DEAppWidth, 0.5)];
        line_3.backgroundColor = DEBGColorGray;
        [self.contentView addSubview:line_3];
        
        UILabel *time = [[UILabel alloc] initWithFrame:CGRectMake(10, 145.5, DEAppWidth * 0.8, 12)];
        time.textAlignment = NSTextAlignmentLeft;
        time.textColor = [UIColor grayColor];
        time.font = [UIFont systemFontOfSize:12.0];
        [self.contentView addSubview:time];
        self.time = time;
        
        UIView *line_4 = [[UIView alloc] initWithFrame:CGRectMake(0, 167.5, DEAppWidth, 0.5)];
        line_4.backgroundColor = DEBGColorGray;
        [self.contentView addSubview:line_4];
    }
    return self;
}

@end
