//
//  MovieViewController.m
//  UIWork15_1
//
//  Created by lanou3g on 16/1/17.
//  Copyright © 2016年 lanou3g. All rights reserved.
//

#import "MovieViewController.h"
#import "MovieList.h"

@interface MovieViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)NSMutableArray *dataArray;
@end

@implementation MovieViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"我的电影";
    
    self.tableView = [[UITableView alloc]initWithFrame:self.view.frame style:(UITableViewStylePlain)];
    [self.view addSubview:self.tableView];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    // 设置导航栏右边按钮为垃圾桶
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:(UIBarButtonSystemItemTrash) target:self action:@selector(rightButton)];
    
    //反归档
    [self unArhiveMovie];
}

- (void)unArhiveMovie
{
#pragma mark ---反归档 ---
    // 1.准备路径
    NSString *path = NSHomeDirectory();
    path = [path stringByAppendingPathComponent:@"movieName.txt"];
    
    NSData *myData = [NSData dataWithContentsOfFile:path];
    
    // 创建反归档对象
    NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc]initForReadingWithData:myData];
    self.dataArray =  [unarchiver decodeObjectForKey:@"result"];
    
    // 完成反归档
    [unarchiver finishDecoding];
    
    NSLog(@"%@",self.dataArray);
}

- (void)rightButton{
    [self.tableView setEditing:!self.tableView.editing animated:YES];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"movieCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:(UITableViewCellStyleValue1) reuseIdentifier:identifier];
    }
    cell.textLabel.text = self.dataArray[indexPath.row];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

#pragma mark --- 侧滑删除功能 ---
// 是否可编辑
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}

// 编辑样式
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleDelete;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [self.dataArray removeObjectAtIndex:indexPath.row];
    
    [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:(UITableViewRowAnimationLeft)];

    
}








@end
