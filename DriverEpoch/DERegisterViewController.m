//
//  DERegisterViewController.m
//  DriverEpoch
//
//  Created by 刘毅 on 17/3/11.
//  Copyright © 2017年 http://halohily.com. All rights reserved.
//

#import "DERegisterViewController.h"
#import "MBProgressHUD.h"
#import "AFNetworking.h"
@interface DERegisterViewController ()

@end

@implementation DERegisterViewController

@synthesize Icon;
@synthesize username , password , confirmpassword;
@synthesize User , Designer , Register , BackToLogin;
@synthesize DividingLine1 , DividingLine2;
@synthesize flag;
@synthesize mytype;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    CGFloat height = [UIScreen mainScreen].bounds.size.height;
    
//    [self.navigationController setNavigationBarHidden:YES animated:YES];
    self.view.backgroundColor = [UIColor colorWithRed:242/255.0 green:242/255.0 blue:244/255.0 alpha:1];
    
    Icon = [[UIImageView alloc] initWithFrame:CGRectMake((width - 100) / 2, height * 0.135, 80, 80)];
    [Icon setImage:[UIImage imageNamed:@"user_default"]];
    [self.view addSubview:Icon];
    self.flag = [NSNumber numberWithInt:0];
    mytype = @"user";
    
    UIView *whiteView = [[UIView alloc] initWithFrame:CGRectMake(DEAppWidth * 0.04, DEAppHeight * 0.135 + 130, DEAppWidth * 0.92, 120)];
    whiteView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:whiteView];
    
    username = [[UITextField alloc] initWithFrame:CGRectMake(DEAppWidth * 0.04, 0, DEAppWidth * 0.84, 40)];
    username.delegate = self;
    username.backgroundColor = [UIColor whiteColor];
    username.textColor = [UIColor colorWithRed:166/255.0 green:166/255.0 blue:166/255.0 alpha:1];
    username.font = [UIFont fontWithName:@"Times New Roman" size:12];
    username.placeholder = @"用户名";
    username.autocorrectionType = UITextAutocorrectionTypeNo;
    username.autocapitalizationType = UITextAutocapitalizationTypeNone;
    username.clearButtonMode = UITextFieldViewModeWhileEditing;
    [whiteView addSubview:username];
    
    password = [[UITextField alloc] initWithFrame:CGRectMake(DEAppWidth * 0.04, 40, DEAppWidth * 0.84, 40)];
    password.delegate = self;
    password.backgroundColor = [UIColor whiteColor];
    password.textColor = [UIColor colorWithRed:166/255.0 green:166/255.0 blue:166/255.0 alpha:1];
    password.font = [UIFont fontWithName:@"Times New Roman" size:12];
    password.placeholder = @"密码";
    password.secureTextEntry = YES;
    password.autocorrectionType = UITextAutocorrectionTypeNo;
    password.autocapitalizationType = UITextAutocapitalizationTypeNone;
    password.clearButtonMode = UITextFieldViewModeWhileEditing;
    [whiteView addSubview:password];
    
    confirmpassword = [[UITextField alloc] initWithFrame:CGRectMake(DEAppWidth * 0.04, 80, DEAppWidth * 0.84, 40)];
    confirmpassword.delegate = self;
    confirmpassword.backgroundColor = [UIColor whiteColor];
    confirmpassword.textColor = [UIColor colorWithRed:166/255.0 green:166/255.0 blue:166/255.0 alpha:1];
    confirmpassword.font = [UIFont fontWithName:@"Times New Roman" size:12];
    confirmpassword.placeholder = @"再次确认密码";
    confirmpassword.secureTextEntry = YES;
    confirmpassword.autocorrectionType = UITextAutocorrectionTypeNo;
    confirmpassword.autocapitalizationType = UITextAutocapitalizationTypeNone;
    confirmpassword.clearButtonMode = UITextFieldViewModeWhileEditing;
    //    [confirmpassword addTarget:self action:@selector(didDone:) forControlEvents:UIControlEventEditingDidEnd];
    [whiteView addSubview:confirmpassword];
    
    DividingLine1 = [[UILabel alloc] initWithFrame:CGRectMake(0, 40, DEAppWidth * 0.92, PHYSICAL_1_PX)];
    DividingLine1.layer.borderColor = [[UIColor colorWithRed:166/255.0 green:166/255.0  blue:166/255.0  alpha:1] CGColor];
    DividingLine1.layer.borderWidth = 1;
    [whiteView addSubview:DividingLine1];
    
    DividingLine2 = [[UILabel alloc] initWithFrame:CGRectMake(0, 80, DEAppWidth * 0.92, PHYSICAL_1_PX)];
    DividingLine2.layer.borderColor = [[UIColor colorWithRed:166/255.0 green:166/255.0  blue:166/255.0  alpha:1] CGColor];
    DividingLine2.layer.borderWidth = 1;
    [whiteView addSubview:DividingLine2];
        
    Register = [[UIButton alloc] initWithFrame:CGRectMake(width * 0.04, height * 0.135 + 265, width * 0.92, 40)];
    Register.layer.cornerRadius = 4;
    Register.layer.masksToBounds = YES;
    [Register setTitle:@"立即注册" forState:UIControlStateNormal];
    Register.titleLabel.font = [UIFont systemFontOfSize:15];
    [Register setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [Register setBackgroundColor:[UIColor colorWithRed:107/255.0 green:107/255.0 blue:118/255.0 alpha:1]];
    [Register addTarget:self action:@selector(PushRegister:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:Register];
    
    BackToLogin = [[UIButton alloc] initWithFrame:CGRectMake(0, height * 0.135 + 330, width, 20)];
    [BackToLogin setTitle:@"返回登录" forState:UIControlStateNormal];
    BackToLogin.titleLabel.font = [UIFont systemFontOfSize:12];
    [BackToLogin setTitleColor:[UIColor colorWithRed:107/255.0 green:107/255.0 blue:118/255.0 alpha:1] forState:UIControlStateNormal];
    [BackToLogin addTarget:self action:@selector(backtoLoginViewController:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:BackToLogin];
}


- (IBAction)backtoLoginViewController:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    CGRect frame = textField.frame;
    
    
    //  所加的数字 83   默认为32  因为键盘上方还会出现联想提示文字框，所以多加一些
    
    int offset = frame.origin.y + 83 - (self.view.frame.size.height - 216.0);//键盘高度216
    
    NSTimeInterval animationDuration = 0.30f;
    [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
    [UIView setAnimationDuration:animationDuration];
    
    //将视图的Y坐标向上移动offset个单位，以使下面腾出地方用于软键盘的显示
    if(offset > 0)
        self.view.frame = CGRectMake(0.0f, -offset, self.view.frame.size.width, self.view.frame.size.height);
    
    [UIView commitAnimations];
}

//当用户按下return键或者按回车键，keyboard消失
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    if(textField == confirmpassword)
    {
        NSString *str1 = password.text;
        NSString *str2 = confirmpassword.text;
        if(![str1 isEqualToString:str2])
        {
            self.flag = [NSNumber numberWithInt:1];
            confirmpassword.text = nil;
        }
    }
    return YES;
}

//输入框编辑完成以后，将视图恢复到原始状态
-(void)textFieldDidEndEditing:(UITextField *)textField
{
    self.view.frame =CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
}

//  简单实现 点击空白 收回键盘
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event

{
    
    [username resignFirstResponder];
    [password resignFirstResponder];
    [confirmpassword resignFirstResponder];
}
-(IBAction)PushRegister:(id)sender
{
    
    [username resignFirstResponder];
    [password resignFirstResponder];
    NSString *user = username.text;
    NSString *ps = password.text;
    NSString *ps_r = confirmpassword.text;
    if ([user  isEqual: @""] || user == nil || user.length < 6) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.mode = MBProgressHUDModeText;
        hud.label.text = @"请输入6位以上用户名";
        [hud hideAnimated:YES afterDelay:1];
    
        
    }
    else if ([ps  isEqual: @""] || ps == nil || ps.length < 6) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.mode = MBProgressHUDModeText;
        hud.label.text = @"请输入6位以上密码";
        [hud hideAnimated:YES afterDelay:1];
    }
    else if (![ps isEqualToString:ps_r]) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.mode = MBProgressHUDModeText;
        hud.label.text = @"两次输入密码不一致";
        [hud hideAnimated:YES afterDelay:1];
    }
    else {
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.mode = MBProgressHUDModeIndeterminate;
        hud.label.text = @"加载中";
        [hud hideAnimated:YES afterDelay:5];
        
        NSDictionary *parameters = @{@"if": @"Register", @"username": user, @"password":ps};
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        [manager POST:SERVER_ADDRESS parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
            
        }
             success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                 NSLog(@"%@", responseObject);
                 NSNumber *code = [responseObject objectForKey:@"code"];
                 if (code.intValue == 1)
                {
                    [MBProgressHUD hideHUDForView:self.view animated:YES];
                    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
                    hud.mode = MBProgressHUDModeText;
                    hud.label.text = @"注册成功，快去登录吧";
                    [hud hideAnimated:YES afterDelay:1.0];
                    [self.navigationController popViewControllerAnimated:YES];
                    confirmpassword.text = nil;
                    username.text = nil;
                    password.text = nil;
                    [username resignFirstResponder];
                    [password resignFirstResponder];
                    [confirmpassword resignFirstResponder];
                }
                else{
                    
                    [MBProgressHUD hideHUDForView:self.view animated:YES];
                    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
                    hud.mode = MBProgressHUDModeText;
                    hud.label.text = @"此账户已注册，换个账户吧";
                    [hud hideAnimated:YES afterDelay:1];
                    confirmpassword.text = nil;
                    username.text = nil;
                    password.text = nil;
                    [username resignFirstResponder];
                    [password resignFirstResponder];
                    [confirmpassword resignFirstResponder];
                }

             }
             failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull   error) {
                 
                 NSLog(@"%@",error);  //这里打印错误信息
                 
             }];        
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
