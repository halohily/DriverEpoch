//
//  DELoginViewController.h
//  DriverEpoch
//
//  Created by 刘毅 on 17/3/11.
//  Copyright © 2017年 http://halohily.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DELoginViewController : UIViewController <UITextFieldDelegate>

@property (strong , nonatomic) UIImageView *Icon;
@property (strong , nonatomic) UITextField *username , *password;
@property (strong , nonatomic) UIButton *User , *Designer , *Login , *GotoRegister;
@property (strong , nonatomic) UILabel *DividingLine;
@property (strong, nonatomic) NSString *mytype;

@end
