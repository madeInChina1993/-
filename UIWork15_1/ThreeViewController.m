//
//  ThreeViewController.m
//  UIWork15_1
//
//  Created by lanou3g on 16/1/11.
//  Copyright © 2016年 lanou3g. All rights reserved.
//

#import "ThreeViewController.h"
#import "CinemaList.h"
#import "ThreeCell.h"

@interface ThreeViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)NSMutableArray *movieArray;
@property(nonatomic,strong)UITableView *tableView;
@end

@implementation ThreeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"影院";
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:0.357 green:0.529 blue:0.624 alpha:1.000];
    
    [self initLayout];
    [self handleData];
}

- (void)initLayout
{
    self.tableView = [[UITableView alloc]initWithFrame:self.view.frame style:(UITableViewStyleGrouped)];
    [self.view addSubview:self.tableView];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    // 注册
    [self.tableView registerNib:[UINib nibWithNibName:@"ThreeCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"cell"];
    
    
}

- (void)handleData
{
    NSString *filePath = [[NSBundle mainBundle]pathForResource:@"cinemalist.txt" ofType:nil];
    NSData *fileData = [NSData dataWithContentsOfFile:filePath];
    
    NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:fileData options:NSJSONReadingAllowFragments error:nil];
    
    //    NSLog(@"%@",dictionary);
    self.movieArray = [NSMutableArray array];
    
    NSDictionary *dict = dictionary[@"result"];
    NSDictionary *dic = dict[@"data"];
    for (NSDictionary *d in dic) {
        CinemaList *cinemaList = [CinemaList new];
        [cinemaList setValuesForKeysWithDictionary:d];
        [self.movieArray addObject:cinemaList];
    }
    
//    NSLog(@"%@",self.movieArray);
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [self.movieArray count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 150;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ThreeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[ThreeCell alloc]initWithStyle:(UITableViewCellStyleValue1) reuseIdentifier:@"cell"];
    }
    
    CinemaList *cinemaList = [CinemaList new];
    cinemaList = self.movieArray[indexPath.section];
    
    cell.cinemaNameLabel.text = cinemaList.cinemaName;
    cell.addressLabel.text = cinemaList.address;
    cell.telephoneLabel.text = cinemaList.telephone;
    
    
    return cell;
}





@end
