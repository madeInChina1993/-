//
//  CollectListViewController.m
//  UIWork15_1
//
//  Created by lanou3g on 16/1/14.
//  Copyright © 2016年 lanou3g. All rights reserved.
//

#import "CollectListViewController.h"
#import "detailsViewController.h"
#import "ActivityList.h"

@interface CollectListViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView *tableView;
@end

@implementation CollectListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"活动收藏列表";
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:0.357 green:0.529 blue:0.624 alpha:1.000];
    
    self.tableView = [[UITableView alloc]initWithFrame:self.view.frame style:(UITableViewStyleGrouped)];
    
    [self.view addSubview:self.tableView];
    
    self.tableView.delegate = self;
    self.tableView.dataSource =self;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{;
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:(UITableViewCellStyleValue1) reuseIdentifier:@"cell"];
    }
    
    NSString *path = NSHomeDirectory();
    path = [path stringByAppendingPathComponent:@"details.txt"];
    
    NSData *myData = [NSData dataWithContentsOfFile:path];
    
    // 创建反归档对象
    NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc]initForReadingWithData:myData];
    
    // 反归档
    ActivityList *activity = [ActivityList new];
    activity = [unarchiver decodeObjectForKey:@"activity"];
    
    // 完成反归档
    [unarchiver finishDecoding];
    
    
    cell.textLabel.text = activity.title;
    
    
    
    
    return cell;
}







@end
