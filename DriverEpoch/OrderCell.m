//
//  OrderCell.m
//  DriverEpoch
//
//  Created by 刘毅 on 2017/5/22.
//  Copyright © 2017年 http://halohily.com. All rights reserved.
//

#import "OrderCell.h"

@implementation OrderCell

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        self.address.frame = CGRectMake(30, 83, DEAppWidth - 100, 32);
        UILabel *state = [[UILabel alloc] initWithFrame:CGRectMake(DEAppWidth - 40, 89, 20, 20)];
        state.textColor = DENavBarColorBlue;
        state.font = [UIFont fontWithName:@"iconfont" size:18.0];
        state.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:state];
        self.state = state;
    }
    return self;
}
@end
