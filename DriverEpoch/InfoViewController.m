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
#import <SDWebImage/UIImageView+WebCache.h>

@interface InfoViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *infoTableview;
@property (nonatomic, strong) NSArray *infoArr;

@end

@implementation InfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupView];
    // Do any additional setup after loading the view.
}

- (void)setupData
{
    NSArray *newsData = @[@{@"picture":@"http://cms-bucket.nosdn.127.net/c82d24c70e764143a9fa57c139a46b7e20170518102727.png?imageView&thumbnail=550x0",@"title":@"售7.98-9.68万元 福美来7座超值版上市",@"time":@"\U0000e6fd 1小时前",@"source":@"\U0000e63b 网易新闻",@"url":@"http://auto.163.com/17/0518/10/CKNBGD4M0008856R.html"}, @{@"picture":@"http://cms-bucket.nosdn.127.net/840b8d72cd654e69bcdf05d82c2ad3e120170517153958.jpeg?imageView&thumbnail=550x0",@"title":@"不入华说啥都白搭 改款308 GTi官图曝光",@"time":@"\U0000e6fd 1小时前",@"source":@"\U0000e63b 网易新闻",@"url":@"http://auto.163.com/17/0518/00/CKM79LAS0008856R.html"}, @{@"picture":@"http://cms-bucket.nosdn.127.net/91ddb296e7814e16a4ef8902ff8411ea20170517204633.jpeg?imageView&thumbnail=550x0",@"title":@"600匹马力/3.5秒破百 宝马全新M5更多消息",@"time":@"\U0000e6fd 2小时前",@"source":@"\U0000e63b 网易新闻",@"url":@"http://auto.163.com/17/0518/00/CKM8A62L0008856R.html"}, @{@"picture":@"http://cms-bucket.nosdn.127.net/3ed8685d12404eeea40d031d1d20477920170502220217.jpeg?imageView&thumbnail=550x0",@"title":@"嫁鸡随鸡 欧宝全新Corsa将采用PSA技术",@"time":@"\U0000e6fd 3小时前",@"source":@"\U0000e63b 网易新闻",@"url":@"http://auto.163.com/17/0518/00/CKM8D70F0008856R.html"}, @{@"picture":@"http://cms-bucket.nosdn.127.net/644f131bade9475d9bba40454396713a20170515185319.jpeg?imageView&thumbnail=550x0",@"title":@"看看就好 菲亚特124 Spider特别版官图",@"time":@"\U0000e6fd 4小时前",@"source":@"\U0000e63b 网易新闻",@"url":@"http://auto.163.com/17/0518/00/CKM8ISGS0008856R.html"}, @{@"picture":@"http://cms-bucket.nosdn.127.net/4552e1d2a8f645c4970474edce5cb3ac20170516140703.jpeg?imageView&thumbnail=550x0",@"title":@"真的要说再见了 劳斯莱斯幻影特别版官图",@"time":@"\U0000e6fd 5小时前",@"source":@"\U0000e63b 网易新闻",@"url":@"http://auto.163.com/17/0518/00/CKM8JIP30008856R.html"}, @{@"picture":@"http://cms-bucket.nosdn.127.net/026b33c924ad4954a8bb27e2bfeedc5220170517143132.jpeg?imageView&thumbnail=550x0",@"title":@"JK系列最后的疯狂 牧马人特别版限量66台",@"time":@"\U0000e6fd 6小时前",@"source":@"\U0000e63b 网易新闻",@"url":@"http://auto.163.com/17/0517/14/CKL67QV60008856R.html"}, @{@"picture":@"http://cms-bucket.nosdn.127.net/a73abd61f7a9469a949ebae958aba56720170517224319.jpeg?imageView&thumbnail=550x0",@"title":@"逐渐联盟化 德尔福加入宝马自动驾驶团队",@"time":@"\U0000e6fd 7小时前",@"source":@"\U0000e63b 网易新闻",@"url":@"http://auto.163.com/17/0518/09/CKN7V88T000884ML.html"}, @{@"picture":@"http://cms-bucket.nosdn.127.net/26df69a44f714f95a05074f1cda7d5ad20170517225730.jpeg?imageView&thumbnail=550x0",@"title":@"特斯拉扩张中国业务 持续开店/建充电桩",@"time":@"\U0000e6fd 8小时前",@"source":@"\U0000e63b 网易新闻",@"url":@"http://auto.163.com/17/0518/09/CKN7UG5Q000884ML.html"}, @{@"picture":@"http://autodealer.nosdn.127.net/cafa7a9b0b88f4b1692d430820a88d53",@"title":@"三指开车忙围观 手机拍照吃罚单",@"time":@"\U0000e6fd 9小时前",@"source":@"\U0000e63b 网易新闻",@"url":@"http://auto.163.com/17/0518/09/CKN6HL83000884ML.html"}, @{@"picture":@"http://cms-bucket.nosdn.127.net/f213cd52207844a78d44ab3cc8888e8a20170518091609.png?imageView&thumbnail=550x0",@"title":@"政策驱动增长背后 中国电动车产量占全球50%份额",@"time":@"\U0000e6fd 11小时前",@"source":@"\U0000e63b 网易新闻",@"url":@"http://auto.163.com/17/0518/09/CKN6FFPL000884MM.html"}, @{@"picture":@"http://cms-bucket.nosdn.127.net/catchpic/9/95/95756764f428b4aade329d96bebe6b4e.jpg?imageView&thumbnail=550x0",@"title":@"五个路段夜间免费临停 叹！八卦司机拍执法吃罚单",@"time":@"\U0000e6fd 12小时前",@"source":@"\U0000e63b 网易新闻",@"url":@"http://auto.163.com/17/0518/09/CKN6FA5V000884ML.html"}, @{@"picture":@"http://nbot-pub.nosdn.127.net/b8be1c056990e4a0028356e243029215.jpeg",@"title":@"抢剧情风头的DS和林肯，加盟《欢乐颂 2》却同路不同谋",@"time":@"\U0000e6fd 15小时前",@"source":@"\U0000e63b 网易新闻",@"url":@"http://dy.163.com/v2/article/detail/CKJPTB7D05258151.html"}, @{@"picture":@"http://dingyue.nosdn.127.net/Stk2rM3eG0tQw0hQ0xaTsTiSTKtKVwFRKXsJkiX6VyMo81494987454135.jpg",@"title":@"万万没想到 “一带一路”里还藏着这么多研发中心",@"time":@"\U0000e6fd 16小时前",@"source":@"\U0000e63b 网易新闻",@"url":@"http://dy.163.com/v2/article/detail/CKKNMID00527840B.html"}, @{@"picture":@"http://spider.nosdn.127.net/652d0b5e52aa7b1cb0c73ce9d6362e31.jpeg",@"title":@"熟悉的陌生人？三星借自动驾驶杀回汽车行业！",@"time":@"\U0000e6fd 21小时前",@"source":@"\U0000e63b 网易新闻",@"url":@"http://dy.163.com/v2/article/detail/CKLLT6KR052786B9.html"}, @{@"picture":@"http://dingyue.nosdn.127.net/y09LpmpxZuGhcHioXnJx5oAg5tnSGbDD0z0nrJkp=KjN81495032526194compressflag.png",@"title":@"从煤油灯到激光大灯，车灯已不再满足于单纯照明",@"time":@"\U0000e6fd 21小时前",@"source":@"\U0000e63b 网易新闻",@"url":@"http://dy.163.com/v2/article/detail/CKM380ML0527830D.html"}];
    self.infoArr = newsData;
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
        
        [cell.backImg sd_setImageWithURL:[NSURL URLWithString:[tempdic objectForKey:@"picture"]]
                        placeholderImage:[UIImage imageNamed:@"placeholder.png"]];
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
        
        [cell.backImg sd_setImageWithURL:[NSURL URLWithString:[tempdic objectForKey:@"picture"]]
                     placeholderImage:[UIImage imageNamed:@"placeholder.png"]];
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
    nextpage.url = [sindic objectForKey:@"url"];
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
