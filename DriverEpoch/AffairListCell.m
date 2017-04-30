//
//  AffairListCell.m
//  DriverEpoch
//
//  Created by 刘毅 on 2017/4/29.
//  Copyright © 2017年 http://halohily.com. All rights reserved.
//

#import "AffairListCell.h"

@implementation AffairListCell

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
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        UILabel *line = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, DEAppWidth, 0.5)];
        line.backgroundColor = DEBGColorGray;
        [self addSubview:line];
        
        UILabel *icon = [[UILabel alloc] initWithFrame:CGRectMake(15, 10, 20, 20)];
        icon.font = [UIFont fontWithName:@"iconfont" size:20];
        icon.textColor = DENavBarColorBlue;
        [self addSubview:icon];
        self.affairIcon = icon;
        
        UILabel *affair = [[UILabel alloc] initWithFrame:CGRectMake(50, 12.5, DEAppWidth * 0.6, 15)];
        affair.font = [UIFont systemFontOfSize:15.0];
        [self addSubview:affair];
        self.affair = affair;
        
        UILabel *holder = [[UILabel alloc] initWithFrame:CGRectMake(DEAppWidth * 0.7, 14, DEAppWidth * 0.2, 12)];
        holder.textColor = DEColor(153, 153, 153);
        holder.textAlignment = NSTextAlignmentRight;
        holder.font = [UIFont systemFontOfSize:12.0];
        [self addSubview:holder];
        self.holderLabel = holder;
        
    }
    return self;
}

@end
