//
//  FirstViewController.m
//  UIWork15_1
//
//  Created by lanou3g on 16/1/11.
//  Copyright © 2016年 lanou3g. All rights reserved.
//

#import "FirstViewController.h"
#import "ActivityList.h"
#import "FirstCell.h"
#import "ImageDownload.h"
#import "UrlString.pch"
#import "detailsViewController.h"
#import "CollectListViewController.h"

@interface FirstViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)NSMutableArray *dataArray;

@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"活动";
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:0.357 green:0.529 blue:0.624 alpha:1.000];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"我的收藏" style:(UIBarButtonItemStyleDone) target:self action:@selector(rightButton)];
    
    
    [self initLayout];
    [self handleData];
}
// 收藏列表
- (void)rightButton
{
    CollectListViewController *collect = [[CollectListViewController alloc]init];
    
    [self.navigationController pushViewController:collect animated:YES];
}

// 布局
- (void)initLayout
{
    self.tableView = [[UITableView alloc]initWithFrame:self.view.frame style:(UITableViewStyleGrouped)];
    
    [self.view addSubview:self.tableView];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    [self.tableView registerNib:[UINib nibWithNibName:@"FirstCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"cell"];
}

// 解析数据
- (void)handleData
{
    self.dataArray = [NSMutableArray array];
    // 请求数据
    NSURL *url = [NSURL URLWithString:kActivity];
    
    NSLog(@"%@",url);
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    
    NSURLSession *session = [NSURLSession sharedSession];
    
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        // 解析数据
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        // 遍历字典
        for (NSDictionary *dict in dic[@"events"]) {
            ActivityList *activity = [ActivityList new];
            [activity setValuesForKeysWithDictionary:dict];
            activity.name = [activity.owner valueForKey:@"name"];
            [self.dataArray addObject:activity];
        }
        
        
//#warning 如果数据不显示,要把数据刷新放到主线程中
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
    }];
    
    [dataTask resume];
}


- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context
{
    // 1.拿到新值
    UIImage *newImage = change[NSKeyValueChangeNewKey];
    // 2.将取出的新值添加到cell上对应的下标
    NSArray *indexArray = [self.tableView indexPathsForVisibleRows];
    // 3.获取当前cell上的下标
    NSIndexPath *indexPath = (__bridge NSIndexPath *)(context);
    // 4.判断是否包含在当前的数组中
    if ([indexArray containsObject:indexPath]) {
        FirstCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
        // 如果包含,那么就将新的图片给image
        cell.activityImageView.image = newImage;
        
    }
    // 观察者观察完毕,需要将观察者移除
    [object removeObserver:self forKeyPath:@"loadImage" context:(__bridge void * _Nullable)(indexPath)];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [self.dataArray count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 230;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    FirstCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[FirstCell alloc]initWithStyle:(UITableViewCellStyleValue1) reuseIdentifier:@"cell"];
    }
    
    ActivityList *activityList = [ActivityList new];
    activityList = self.dataArray[indexPath.section];
    
    cell.titleLabel.text = activityList.title;
    
    NSString *beginString = [activityList.begin_time substringWithRange:NSMakeRange(5, 10)];
    NSString *endString = [activityList.end_time substringWithRange:NSMakeRange(5, 10)];
    cell.timeLabel.text = [NSString stringWithFormat:@"%@ -- %@",beginString,endString];
    
    cell.addressLabel.text = activityList.address;
    
    cell.categoryNameLabel.text = [NSString stringWithFormat:@"类型: %@",activityList.category_name];
    
    cell.wisherCountLabel.text = [NSString stringWithFormat:@"%@",activityList.wisher_count];
    
    cell.participantCountLabel.text = [NSString stringWithFormat:@"%@",activityList.participant_count];
    
    [cell.activityIndicatorView startAnimating];
    
    
#pragma mark --- 加载图片 ---
    // 异步加载图片
    if (activityList.loadImage == nil && activityList.isLoading == NO) { // 如果没有图片可以显示
        [cell.activityIndicatorView startAnimating];
        // 加载图片
        [activityList imageLoading];
        // 添加观察者
        [activityList addObserver:self forKeyPath:@"loadImage" options:NSKeyValueObservingOptionNew context:(__bridge void *_Nullable)(indexPath)];
        
    }else if(activityList.loadImage == nil){
        // 如果光是没有图片,表明正在加载,就让菊花一直转
        [cell.activityIndicatorView startAnimating];
    }else{
        // 最后一种情况是加载完成,将loadImage中的数据给cell
        cell.activityImageView.image = activityList.loadImage;
    }
    
    [[ImageDownload shareImageDownload] imageDownloadWithString:activityList.image_hlarge returnImageBlock:^(NSData *data) {
        cell.activityImageView.image = [UIImage imageWithData:data];
        [cell.activityIndicatorView stopAnimating];
        cell.activityIndicatorView.hidden = YES;
    }];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 5;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 5;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    detailsViewController *details = [[detailsViewController alloc]init];
    ActivityList *activity = [ActivityList new];
    
    // 此 dataArray 传到 details 的 dataArray
    details.dataArray = [NSMutableArray array];
    activity = self.dataArray[indexPath.section];
    [details.dataArray addObjectsFromArray:self.dataArray];
    
    // 把每行内容传到detailsViewController
    details.section = indexPath.section;
    
    details.navigationItem.title = activity.title;
    
    [self.navigationController pushViewController:details animated:YES];
}








@end
