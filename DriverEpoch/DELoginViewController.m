//
//  DELoginViewController.m
//  DriverEpoch
//
//  Created by 刘毅 on 17/3/11.
//  Copyright © 2017年 http://halohily.com. All rights reserved.
//

#import "DELoginViewController.h"
#import "DERegisterViewController.h"
#import "AppDelegate.h"
#import "MBProgressHUD.h"
#import "AFNetworking.h"
@interface DELoginViewController ()

@end

@implementation DELoginViewController

@synthesize Icon;
@synthesize username , password;
@synthesize User , Designer , Login , GotoRegister;
@synthesize DividingLine;
@synthesize mytype;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    self.view.backgroundColor = [UIColor colorWithRed:242/255.0 green:242/255.0 blue:244/255.0 alpha:1];
    
    Icon = [[UIImageView alloc] initWithFrame:CGRectMake((DEAppWidth - 100) / 2, DEAppHeight * 0.142, 100, 100)];
    [Icon setImage:[UIImage imageNamed:@"logo"]];
    [self.view addSubview:Icon];
    
    UIView *whiteView = [[UIView alloc] initWithFrame:CGRectMake(DEAppWidth * 0.04, DEAppHeight * 0.142 + 150, DEAppWidth * 0.92, 80)];
    whiteView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:whiteView];
    
    username = [[UITextField alloc] initWithFrame:CGRectMake(DEAppWidth * 0.04, 0, DEAppWidth * 0.84, 40)];
    username.delegate = self;
    username.backgroundColor = [UIColor clearColor];
    username.textColor = [UIColor colorWithRed:166/255.0 green:166/255.0 blue:166/255.0 alpha:1];
    username.font = [UIFont fontWithName:@"Times New Roman" size:12];
    username.placeholder = @"请输入用户名";
    username.autocorrectionType = UITextAutocorrectionTypeNo;
    username.autocapitalizationType = UITextAutocapitalizationTypeNone;
    username.clearButtonMode = UITextFieldViewModeWhileEditing;
    //    [username becomeFirstResponder];
    [whiteView addSubview:username];
    
    password = [[UITextField alloc] initWithFrame:CGRectMake(DEAppWidth * 0.04, 40, DEAppWidth * 0.84, 40)];
    password.delegate = self;
    password.backgroundColor = [UIColor whiteColor];
    password.textColor = [UIColor colorWithRed:166/255.0 green:166/255.0 blue:166/255.0 alpha:1];
    password.font = [UIFont fontWithName:@"Times New Roman" size:12];
    password.placeholder = @"请输入密码";
    password.secureTextEntry = YES;
    password.autocorrectionType = UITextAutocorrectionTypeNo;
    password.autocapitalizationType = UITextAutocapitalizationTypeNone;
    password.clearButtonMode = UITextFieldViewModeWhileEditing;
    [whiteView addSubview:password];
    
    DividingLine = [[UILabel alloc] initWithFrame:CGRectMake(0, 40, DEAppWidth * 0.92, PHYSICAL_1_PX)];
    DividingLine.layer.borderColor = [[UIColor colorWithRed:166/255.0 green:166/255.0  blue:166/255.0  alpha:1] CGColor];
    DividingLine.layer.borderWidth = 1;
    [whiteView addSubview:DividingLine];
        
    Login = [[UIButton alloc] initWithFrame:CGRectMake(DEAppWidth * 0.04, DEAppHeight * 0.142 + 245, DEAppWidth * 0.92, 40)];
    Login.layer.cornerRadius = 4;
    Login.layer.masksToBounds = YES;
    [Login setTitle:@"登录" forState:UIControlStateNormal];
    Login.titleLabel.font = [UIFont systemFontOfSize:15];
    [Login setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [Login setBackgroundColor:[UIColor colorWithRed:107/255.0 green:107/255.0 blue:118/255.0 alpha:1]];
    [Login addTarget:self action:@selector(Loginclicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:Login];
    
    GotoRegister = [[UIButton alloc] initWithFrame:CGRectMake(0, DEAppHeight * 0.142 + 310, DEAppWidth, 20)];
    [GotoRegister setTitle:@"没有账号？快来注册" forState:UIControlStateNormal];
    GotoRegister.titleLabel.font = [UIFont systemFontOfSize:12];
    [GotoRegister setTitleColor:[UIColor colorWithRed:107/255.0 green:107/255.0 blue:118/255.0 alpha:1] forState:UIControlStateNormal];
    [GotoRegister addTarget:self action:@selector(gotoRegisterViewController:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:GotoRegister];
    

}

- (IBAction)gotoRegisterViewController:(id)sender
{
    DERegisterViewController *RegisterView = [[DERegisterViewController alloc] init];
    [self.navigationController pushViewController:RegisterView animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    
}
- (IBAction)Loginclicked:(id)sender
{
    if([username.text  isEqual: @""] || [password.text  isEqual: @""])
    {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.mode = MBProgressHUDModeText;
        hud.label.text = @"请填写完整！";
        [hud hideAnimated:YES afterDelay:1.0];
    }
    else
    {
        NSString *name = username.text;
        NSString *word = password.text;
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.mode = MBProgressHUDModeIndeterminate;
        hud.label.text = @"加载中";
        [hud hideAnimated:YES afterDelay:5.0];
        
        NSDictionary *parameters = @{@"if": @"Login", @"username": name, @"password":word};
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
                      hud.label.text = @"登录成功！";
                      [hud hideAnimated:YES afterDelay:2.0];
                      NSMutableDictionary *singledic = [responseObject objectForKey:@"data"];
                      
                      [[NSUserDefaults standardUserDefaults] setObject:[singledic objectForKey:@"username"] forKey:@"username"];
                      [[NSUserDefaults standardUserDefaults] setObject:[singledic objectForKey:@"nickname"] forKey:@"nickname"];
                      [[NSUserDefaults standardUserDefaults] setObject:[singledic objectForKey:@"id"] forKey:@"id"];
                      [[NSUserDefaults standardUserDefaults] setObject:[singledic objectForKey:@"car"] forKey:@"car"];
                      
                      [[NSUserDefaults standardUserDefaults] synchronize];
                      
                      [self dismissViewControllerAnimated:YES completion:NULL];
                  }
                  else{
                      
                      [MBProgressHUD hideHUDForView:self.view animated:YES];
                      MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
                      hud.mode = MBProgressHUDModeText;
                      hud.label.text = @"登录失败";
                      [hud hideAnimated:YES afterDelay:1];
                      username.text = nil;
                      password.text = nil;
                      [username resignFirstResponder];
                      [password resignFirstResponder];
                  }
                  
              }
              failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull   error) {
                  
                  NSLog(@"%@",error);  //这里打印错误信息
                  [MBProgressHUD hideHUDForView:self.view animated:YES];
                  MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
                  hud.mode = MBProgressHUDModeText;
                  hud.label.text = @"网络错误！";
                  [hud hideAnimated:YES afterDelay:1.0];
              }];        

//        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
//        NSDictionary *parameters = @{@"if":@"Login",
//                                     @"username":name,
//                                     @"password":word,
//                                     @"type":self.mytype
//                                     };
//        NSLog(@"%@",parameters);
//        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json",@"text/plain",@"text/html", @"text/javascript", nil];
//        [manager POST:SERVER_IP parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
//            NSLog(@"JSON: %@", responseObject);
//            [MBProgressHUD hideHUDForView:self.view animated:YES];
//            NSLog(@"json  %@",responseObject);
//            NSNumber *code = [responseObject objectForKey:@"code"];
//            if (code.intValue == 1)
//            {
//                MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
//                hud.mode = MBProgressHUDModeText;
//                hud.labelText = @"登录成功！";
//                [hud hide:YES afterDelay:2];
//                NSMutableDictionary *singledic = [responseObject objectForKey:@"data"];
//                
//                // 存userdata
//                if ([self.mytype isEqualToString:@"user"]) {// 用户
//                    NSMutableDictionary *userInfo = [[NSMutableDictionary alloc] init];
//                    [userInfo setValue:[singledic objectForKey:@"id"] forKey:@"user_id"];
//                    [userInfo setValue:[singledic objectForKey:@"user_name"] forKey:@"user_name"];
//                    [userInfo setValue:[singledic objectForKey:@"icon"] forKey:@"icon"];
//                    [userInfo setValue:[singledic objectForKey:@"tel"] forKey:@"tel"];
//                    [userInfo setValue:[singledic objectForKey:@"address"] forKey:@"address"];
//                    [[UserData getUserInfo] saveUserInfo:userInfo];
//                }
//                if ([self.mytype isEqualToString:@"designer"]) {// 设计师
//                    NSMutableDictionary *designerInfo = [[NSMutableDictionary alloc] init];
//                    [designerInfo setValue:[singledic objectForKey:@"id"] forKey:@"designer_id"];
//                    [[UserData getUserInfo] saveDesignerInfo:designerInfo];
//                }
//                // 显示主界面
//                AppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
//                [appDelegate loadTabBarControllers];
//                [[NSNotificationCenter defaultCenter] postNotificationName:EP_LOGIN object:nil];
//                [self dismissViewControllerAnimated:YES completion:^{}];
//            }
//            
//            else{
//                [MBProgressHUD hideHUDForView:self.view animated:YES];
//                MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
//                hud.mode = MBProgressHUDModeText;
//                hud.labelText = @"登录失败!";
//                [hud hide:YES afterDelay:2];
//                username.text = nil;
//                password.text = nil;
//                [username resignFirstResponder];
//                [password resignFirstResponder];
//            }
//        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//            NSLog(@"Error: %@", error);
//            [MBProgressHUD hideHUDForView:self.view animated:YES];
//            MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
//            hud.mode = MBProgressHUDModeText;
//            hud.labelText = @"网络错误！";
//            [hud hide:YES afterDelay:1];
//            
//        }];
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
