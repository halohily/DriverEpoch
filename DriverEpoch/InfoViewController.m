//
//  InfoViewController.m
//  DriverEpoch
//
//  Created by halohily on 2017/3/9.
//  Copyright © 2017年 http://halohily.com. All rights reserved.
//

#import "InfoViewController.h"
#import "InfoCell.h"
#import "InfoDetailController.h"
#import "InfoHeadCell.h"

@interface InfoViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *infoTableview;
@property (nonatomic, strong) NSMutableArray *infoArr;

@end

@implementation InfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupView];
    // Do any additional setup after loading the view.
}

- (void)setupData
{
    NSMutableArray *array = [[NSMutableArray alloc] init];
    NSDictionary *dic = @{@"picture":@"img04",@"title":@"谈一谈安全驾驶的重要性",@"time":@"1小时前",@"source":@"中国汽车网"};
    [array addObject:dic];
    NSDictionary *dic2 = @{@"picture":@"img01",@"title":@"你知道什么是汽车道路的重点吗？",@"time":@"1小时前",@"source":@"中国汽车网"};
    [array addObject:dic2];
    NSDictionary *dic3 = @{@"picture":@"img02",@"title":@"做一个合法守序的驾驶员",@"time":@"2小时前",@"source":@"中国汽车网"};
    [array addObject:dic3];
    NSDictionary *dic4 = @{@"picture":@"img03",@"title":@"我们一起去快乐旅行",@"time":@"3小时前",@"source":@"中国汽车网"};
    [array addObject:dic4];
    NSDictionary *dic5 = @{@"picture":@"img05",@"title":@"你知道什么是汽车道路的重点吗？",@"time":@"3小时前",@"source":@"中国汽车网"};
    [array addObject:dic5];
    self.infoArr = array;
}
- (void)setupView
{
    [self setupData];
    self.view.backgroundColor = [UIColor whiteColor];
    UITableView *tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, DEAppWidth, DEAppHeight) style:UITableViewStylePlain];
    tableview.backgroundColor = [UIColor whiteColor];
    tableview.backgroundColor = [UIColor whiteColor];
    tableview.delegate = self;
    tableview.dataSource = self;
    [tableview registerClass:[InfoCell class] forCellReuseIdentifier:@"InfoCell"];
    [tableview setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.view addSubview:tableview];
    
    self.infoTableview = tableview;
    
}

#pragma mark tableview delegate

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_infoArr count];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0)
    {
        InfoHeadCell *cell = [[InfoHeadCell alloc] init];
        NSMutableDictionary *tempdic = [self.infoArr objectAtIndex:indexPath.row];
        
        NSLog(@"test: %@",tempdic);
        
        [cell.backImg setImage:[UIImage imageNamed:[tempdic objectForKey:@"picture"]]];
        
        cell.titleLabel.text = [tempdic objectForKey:@"title"];
        cell.timeLabel.text = [tempdic objectForKey:@"time"];
        cell.sourceLabel.text = [tempdic objectForKey:@"source"];
        
        return cell;
    }
    else
    {
        InfoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"InfoCell" forIndexPath:indexPath];
        
        NSMutableDictionary *tempdic = [self.infoArr objectAtIndex:indexPath.row];
        NSLog(@"test: %@",tempdic);
        
        [cell.backImg setImage:[UIImage imageNamed:[tempdic objectForKey:@"picture"]]];
        
        cell.titleLabel.text = [tempdic objectForKey:@"title"];
        cell.timeLabel.text = [tempdic objectForKey:@"time"];
        cell.sourceLabel.text = [tempdic objectForKey:@"source"];
        
        return cell;
    }
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.row == 0){
        return 180;
    }
    else{
        return 90;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    InfoDetailController *nextpage = [[InfoDetailController alloc] init];
    
    NSMutableDictionary *sindic = [_infoArr objectAtIndex:indexPath.row];
    
    nextpage.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:nextpage animated:YES];
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, DEAppWidth, 30)];
    headview.backgroundColor = [UIColor whiteColor];
    
    UIImageView *logo = [[UIImageView alloc] initWithFrame:CGRectMake(10, 13, 12, 12)];
    [logo setImage:[UIImage imageNamed:@"logo_head"]];
    [headview addSubview:logo];
    
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(28, 14, 50, 10)];
    title.textAlignment = NSTextAlignmentLeft;
    title.font = [UIFont systemFontOfSize:10.0];
    title.text = @"新闻";
    [headview addSubview:title];
    
    return headview;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
