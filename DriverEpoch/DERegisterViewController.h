//
//  DERegisterViewController.h
//  DriverEpoch
//
//  Created by 刘毅 on 17/3/11.
//  Copyright © 2017年 http://halohily.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DERegisterViewController : UIViewController <UITextFieldDelegate>
@property (strong , nonatomic) UIImageView *Icon;
@property (strong , nonatomic) UITextField *username , *password , *confirmpassword;
@property (strong , nonatomic) UIButton *User , *Designer , *Register , *BackToLogin;
@property (strong , nonatomic) UILabel *DividingLine1 , *DividingLine2;
@property (strong, nonatomic) NSNumber *flag;
@property (strong, nonatomic) NSString *mytype;

@end
