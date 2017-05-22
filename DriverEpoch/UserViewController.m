//
//  UserViewController.m
//  DriverEpoch
//
//  Created by 刘毅 on 2017/5/20.
//  Copyright © 2017年 http://halohily.com. All rights reserved.
//

#import "UserViewController.h"
#import "AffairListCell.h"
#import "EditInfoController.h"
@interface UserViewController ()<UITableViewDelegate, UITableViewDataSource, UserViewDelegate>
@property (nonatomic, strong) UITableView *myTable;
@property (nonatomic, strong) NSArray *tableData;
@property (nonatomic, copy) NSString *nickname;
@property (nonatomic, copy) NSString *car;
@end

@implementation UserViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupData];
    [self setupView];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setupData
{
    NSArray *array = @[@{@"affair": @"用户昵称", @"icon": @"\U0000e634", @"holder": @""}, @{@"affair": @"车牌号", @"icon": @"\U0000e89e", @"holder": @""}];
    self.tableData = array;
    _nickname = [[NSUserDefaults standardUserDefaults] objectForKey:@"nickname"];
    _car = [[NSUserDefaults standardUserDefaults] objectForKey:@"car"];
    NSLog(@"nickname::: %@",_nickname);
    NSLog(@"car::: %@",_car);
}
- (void)setupView
{
    self.view.backgroundColor = DEColor(245, 245, 245);
    UIImageView *image = [[UIImageView alloc] initWithFrame:CGRectMake((DEAppWidth - 80)/2, 120, 80, 80)];
    image.layer.cornerRadius = 40;
    image.layer.masksToBounds = YES;
    [image setImage:[UIImage imageNamed:@"logo"]];
    [self.view addSubview:image];
    
    UITableView *list = [[UITableView alloc] initWithFrame:CGRectMake(0, 230, DEAppWidth, 80) style:UITableViewStylePlain];
    list.scrollEnabled = NO;
    list.separatorStyle = UITableViewCellSeparatorStyleNone;
    list.delegate = self;
    list.dataSource = self;
    [list registerClass:[AffairListCell class] forCellReuseIdentifier:@"MyCell"];
    [self.view addSubview:list];
    self.myTable = list;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.tableData.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    AffairListCell *cell = [self.myTable dequeueReusableCellWithIdentifier:@"MyCell"];
    cell.affair.text = self.tableData[indexPath.row][@"affair"];
    cell.affairIcon.text = self.tableData[indexPath.row][@"icon"];
    if(indexPath.row == 0){
        if ([_nickname isEqualToString:@""]){
            cell.holderLabel.text = @"暂无";
        }
        else{
            cell.holderLabel.text = _nickname;
        }
    }
    if (indexPath.row == 1){
        if ([_car isEqualToString:@""]){
            cell.holderLabel.text = @"暂无";
        }
        else{
            cell.holderLabel.text = _car;
        }
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    EditInfoController *editVC = [[EditInfoController alloc] init];
    editVC.delegate = self;
    NSMutableDictionary *tempDic = [[NSMutableDictionary alloc] init];
    [tempDic setObject:[self.tableData objectAtIndex:indexPath.row][@"affair"] forKey:@"title"];
    if (indexPath.row == 0){
        [tempDic setObject:_nickname forKey:@"holder"];
        [tempDic setObject:@"EditNickName" forKey:@"if"];
        [tempDic setObject:@"nickname" forKey:@"post_key"];
    }
    else{
        [tempDic setObject:_car forKey:@"holder"];
        [tempDic setObject:@"EditCar" forKey:@"if"];
        [tempDic setObject:@"car" forKey:@"post_key"];
    }
    editVC.vcData = tempDic;
    [self.navigationController pushViewController:editVC animated:YES];
}
- (void)viewWillAppear:(BOOL)animated
{
    self.title = @"个人信息";
}

- (void)reloadTableWithNickName:(NSString *)nickname andCar:(NSString *)car
{
    if (nickname){
        self.nickname = nickname;
    }
    if (car){
        self.car = car;
    }
    [self.myTable reloadData];
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
