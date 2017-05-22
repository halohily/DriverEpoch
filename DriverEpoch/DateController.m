//
//  DateController.m
//  DriverEpoch
//
//  Created by 刘毅 on 2017/5/18.
//  Copyright © 2017年 http://halohily.com. All rights reserved.
//

#import "DateController.h"
#import "AFNetworking.h"
#import "MBProgressHUD.h"

@interface DateController ()<UIPickerViewDelegate, UIPickerViewDataSource>
@property (nonatomic, strong) NSDictionary *iconData;
@property (nonatomic, strong) NSArray *proTimeList;
@property (nonatomic, strong) UILabel *dateLabel;
@property (nonatomic, strong) UILabel *dateIcon;
@property (nonatomic, strong) UIView *postView;
@end

@implementation DateController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupData];
    [self setupView];
    // Do any additional setup after loading the view.
}

- (void)setupData
{
    NSDictionary *dic = @{@"加油站":@"\U0000e64b", @"汽车养护":@"\U0000e875"};
    self.iconData = dic;
}
- (void)setupView
{
    self.view.backgroundColor = [UIColor whiteColor];
    CGFloat width = self.view.frame.size.width;
    UILabel *image = [[UILabel alloc] initWithFrame:CGRectMake(width/2 - 75, 100, 150, 150)];
    image.font = [UIFont fontWithName:@"iconfont" size:100.0];
    image.layer.cornerRadius = 75;
    image.layer.masksToBounds = YES;
    image.textAlignment = NSTextAlignmentCenter;
    image.backgroundColor = DEColor(151, 225, 138);
    image.textColor = [UIColor redColor];
    image.text = [self.iconData objectForKey:[self.vcData objectForKey:@"headStr"]];
    [self.view addSubview:image];
    
    UILabel *name = [[UILabel alloc] initWithFrame:CGRectMake(0, 280, DEAppWidth, 18)];
    name.textAlignment = NSTextAlignmentCenter;
    name.font = [UIFont boldSystemFontOfSize:18.0];
    name.textColor = [UIColor blackColor];
    name.text = [self.vcData objectForKey:@"name"];
    [self.view addSubview:name];
    
    UILabel *address = [[UILabel alloc] initWithFrame:CGRectMake(0, 310, DEAppWidth, 16)];
    address.textAlignment = NSTextAlignmentCenter;
    address.font = [UIFont systemFontOfSize:16.0];
    address.textColor = [UIColor grayColor];
    address.text = [self.vcData objectForKey:@"address"];
    [self.view addSubview:address];
    
    // 选择框
    UIPickerView *pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(width/2 - 90, 326, 180, 130)];
    // 显示选中框
    pickerView.showsSelectionIndicator=YES;
    pickerView.dataSource = self;
    pickerView.delegate = self;
    _proTimeList = [[NSArray alloc]initWithObjects:@"1小时后",@"2小时后",@"3小时后",nil];
    [self.view addSubview:pickerView];
    
    UIView *postDate = [[UIView alloc] initWithFrame:CGRectMake(width/2 - 100, 500, 200, 40)];
    postDate.backgroundColor = DENavBarColorBlue;
    postDate.layer.cornerRadius = 5.0;
    postDate.layer.masksToBounds = YES;
    [self.view addSubview:postDate];
    self.postView = postDate;
    
    UILabel *beforePost = [[UILabel alloc] initWithFrame:CGRectMake(60, 7, 80, 26)];
    beforePost.textColor = [UIColor whiteColor];
    beforePost.textAlignment = NSTextAlignmentCenter;
    beforePost.font = [UIFont systemFontOfSize:26.0];
    beforePost.text = @"预约";
    [postDate addSubview:beforePost];
    self.dateLabel = beforePost;
    
    UILabel *postIcon = [[UILabel alloc] initWithFrame:CGRectMake(150, 2.5, 35, 35)];
    postIcon.textColor = [UIColor whiteColor];
    postIcon.textAlignment = NSTextAlignmentCenter;
    postIcon.font = [UIFont fontWithName:@"iconfont" size:35.0];
    postIcon.text = @"\U0000e609";
    [postDate addSubview:postIcon];
    self.dateIcon = postIcon;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(postDate)];
    [postDate addGestureRecognizer:tap];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated
{
    self.title = [NSString stringWithFormat:@"预约%@", [self.vcData objectForKey:@"headStr"]];
    self.navigationController.navigationBar.hidden = NO;
}

- (void)postDate
{
    NSString *user_id = [[NSUserDefaults standardUserDefaults] objectForKey:@"id"];
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.label.text = @"请稍候";
    [hud hideAnimated:YES afterDelay:5.0];
    
    NSDictionary *parameters = @{@"if": @"DateOrder", @"uid": [self.vcData objectForKey:@"uid"], @"poi_name": [self.vcData objectForKey:@"name"], @"poi_address": [self.vcData objectForKey:@"address"], @"id":user_id};
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
                  hud.label.text = @"预约发送成功！";
                  [hud hideAnimated:YES afterDelay:2.0];
                  NSMutableDictionary *data = [responseObject objectForKey:@"data"];
                  NSString *orderID = [data objectForKey:@"id"];
                  [self performSelector:@selector(checkStateWithID:) withObject:orderID/*可传任意类型参数*/ afterDelay:5.0];
                  dispatch_async(dispatch_get_main_queue(), ^{
                      [[self.postView.gestureRecognizers objectAtIndex:0] removeTarget:self action:@selector(postDate)];
                      self.dateLabel.text = @"预约中";
                      
                      CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
                      //默认是顺时针效果，若将fromValue和toValue的值互换，则为逆时针效果
                      animation.fromValue = [NSNumber numberWithFloat:0.f];
                      animation.toValue =  [NSNumber numberWithFloat: M_PI *2];
                      animation.duration  = 1.0f;
                      animation.autoreverses = NO;
                      animation.fillMode =kCAFillModeForwards;
                      animation.repeatCount = MAXFLOAT; //如果这里想设置成一直自旋转，可以设置为MAXFLOAT，否则设置具体的数值则代表执行多少次
                      [self.dateIcon.layer addAnimation:animation forKey:nil];
                  });
              }
              else{
                  
                  [MBProgressHUD hideHUDForView:self.view animated:YES];
                  MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
                  hud.mode = MBProgressHUDModeText;
                  hud.label.text = @"预约发送失败";
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
#pragma Mark -- UIPickerViewDataSource
// pickerView 列数
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

// pickerView 每列个数
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return [_proTimeList count];
}

#pragma Mark -- UIPickerViewDelegate
// 每列宽度
- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
    
    return 180;
}
// 返回选中的行
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    
    NSString  *_proTimeStr = [_proTimeList objectAtIndex:row];
    NSLog(@"_proTimeStr=%@",_proTimeStr);
}

//返回当前行的内容,此处是将数组中数值添加到滚动的那个显示栏上
-(NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return [_proTimeList objectAtIndex:row];
}
- (void)checkStateWithID:(NSString *)orderID{
    NSLog(@"ayayayayayay！！！");
    NSDictionary *parameters = @{@"if": @"CheckOrderState",@"id":orderID};
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager POST:SERVER_ADDRESS parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
        
    }
          success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
              NSLog(@"订单状态检查成功");
              NSLog(@"%@", responseObject);
              NSDictionary *tempDic = @{@"name": [self.vcData objectForKey:@"name"], @"address": [self.vcData objectForKey:@"address"], @"state": [responseObject objectForKey:@"data"][@"state"]};
              
              NSArray *commonArr = [[NSUserDefaults standardUserDefaults] objectForKey:@"orderStates"];
              if (commonArr){
                  NSMutableArray *tempArr = [[NSMutableArray alloc] initWithArray:commonArr];
                  [tempArr addObject:tempDic];
                  [[NSUserDefaults standardUserDefaults] setObject:tempArr forKey:@"orderStates"];
              }
              else{
                  NSMutableArray *arr = [[NSMutableArray alloc] init];
                  [arr addObject:tempDic];
                  [[NSUserDefaults standardUserDefaults] setObject:arr forKey:@"orderStates"];
              }
              [[NSUserDefaults standardUserDefaults] synchronize];
              [[NSNotificationCenter defaultCenter] postNotificationName:@"addOrderStates" object:nil];
          }
          failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull   error) {
              
              NSLog(@"订单状态检查失败失败");  //这里打印错误信息
          }];

}
@end
