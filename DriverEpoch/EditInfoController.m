//
//  EditInfoController.m
//  DriverEpoch
//
//  Created by 刘毅 on 2017/5/21.
//  Copyright © 2017年 http://halohily.com. All rights reserved.
//

#import "EditInfoController.h"
#import "AFNetworking.h"
#import "MBProgressHUD.h"

@interface EditInfoController ()<UITextFieldDelegate>
@property (nonatomic, strong) UITextField *textInput;
@end

@implementation EditInfoController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupView];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setupView
{
    self.view.backgroundColor = DEColor(245, 245, 245);
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    UIBarButtonItem *back = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(back)];
    self.navigationItem.leftBarButtonItem = back;
    
    UIBarButtonItem *save = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStylePlain target:self action:@selector(saveInfo)];
    
    self.navigationItem.rightBarButtonItem = save;
    self.title = [self.vcData objectForKey:@"title"];
    
    UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(0, 84, DEAppWidth, 40)];
    textField.backgroundColor = [UIColor whiteColor];
    textField.layer.borderWidth = 0.5f;
    textField.layer.borderColor = DEBGColorGray.CGColor;
    textField.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 20, 0)];
    textField.leftViewMode = UITextFieldViewModeAlways;
    textField.clearButtonMode = UITextFieldViewModeAlways;
    if (![[self.vcData objectForKey:@"holder"] isEqualToString:@"暂无"]){
        textField.text = [self.vcData objectForKey:@"holder"];
    }
    textField.delegate = self;
    [self.view addSubview:textField];
    self.textInput = textField;
}

- (void)saveInfo
{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.label.text = @"正在加载";
    [hud hideAnimated:YES afterDelay:5.0];
    
    NSString *user_id = [[NSUserDefaults standardUserDefaults] objectForKey:@"id"];
    NSDictionary *parameters = @{@"if": [self.vcData objectForKey:@"if"], [self.vcData objectForKey:@"post_key"]: self.textInput.text,@"id":user_id};
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager POST:SERVER_ADDRESS parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
        
    }
          success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
              NSLog(@"%@", responseObject);
              NSNumber *code = [responseObject objectForKey:@"code"];
              if (code.intValue == 1)
              {
                  [self.delegate respondsToSelector:@selector(reloadTableWithNickName:andCar:)];
                  if([[self.vcData objectForKey:@"post_key"] isEqualToString:@"nickname"]){
                      NSString *nickname = self.textInput.text;
                      [self.delegate reloadTableWithNickName:nickname andCar:nil];
                  }
                  else{
                      NSString *car = self.textInput.text;
                      [self.delegate reloadTableWithNickName:nil andCar:car];
                  }

                  [MBProgressHUD hideHUDForView:self.view animated:YES];
                  [[NSUserDefaults standardUserDefaults] setObject:self.textInput.text forKey:[self.vcData objectForKey:@"post_key"]];
                  [[NSUserDefaults standardUserDefaults] synchronize];
                  [self.navigationController popViewControllerAnimated:YES];
              }
              else{
                  [MBProgressHUD hideHUDForView:self.view animated:YES];
                  MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
                  hud.mode = MBProgressHUDModeText;
                  hud.label.text = @"更改失败";
                  [hud hideAnimated:YES afterDelay:1];
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

}
- (void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}

//当用户按下return键或者按回车键，keyboard消失
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

//  简单实现 点击空白 收回键盘
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event

{
    
    [self.textInput resignFirstResponder];
    
}
- (BOOL)becomeFirstResponder
{
    [super becomeFirstResponder];
    return [self.textInput becomeFirstResponder];
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
