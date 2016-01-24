//
//  FourthViewController.m
//  UIWork15_1
//
//  Created by lanou3g on 16/1/11.
//  Copyright © 2016年 lanou3g. All rights reserved.
//

#import "FourthViewController.h"
#import "CollectListViewController.h"
#import "MovieViewController.h"
#import "LoginViewController.h"

@interface FourthViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView *tableView;
@end

@implementation FourthViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"我的";
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:0.357 green:0.529 blue:0.624 alpha:1.000];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"登陆" style:(UIBarButtonItemStyleDone) target:self action:@selector(LoginButton)];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"注销" style:(UIBarButtonItemStyleDone) target:self action:@selector(clearButton)];
    
    self.tableView = [[UITableView alloc]initWithFrame:self.view.frame style:(UITableViewStylePlain)];
    
    [self.view addSubview:self.tableView];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
}

- (void)LoginButton
{
    LoginViewController *login = [[LoginViewController alloc]init];
    login.modalTransitionStyle = UIModalTransitionStylePartialCurl;
    
    UINavigationController *navigation = [[UINavigationController alloc]initWithRootViewController:login];
    
    
    [self presentViewController:navigation animated:YES completion:nil];
    
}




- (void)clearButton
{
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:(UITableViewCellStyleValue1) reuseIdentifier:@"cell"];
    }
    if (indexPath.section == 0 && indexPath.row == 0) {
        cell.textLabel.text = @"我的收藏";
    }else if(indexPath.section == 0 && indexPath.row == 1){
        cell.textLabel.text = @"我的电影";
    }else if(indexPath.section == 0 && indexPath.row == 2){
        cell.textLabel.text = @"清除缓存";
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0 && indexPath.row == 0) {
        CollectListViewController *collectList = [[CollectListViewController alloc]init];
        [self.navigationController pushViewController:collectList animated:YES];
        
    }else if(indexPath.section == 0 && indexPath.row == 1){
        MovieViewController *movie = [[MovieViewController alloc]init];
        [self.navigationController pushViewController:movie animated:YES];
        
    }else if(indexPath.section == 0 && indexPath.row == 2){
        
        UIAlertController *aAlert = [UIAlertController alertControllerWithTitle:@"提示" message:@"清除缓存成功" preferredStyle:UIAlertControllerStyleAlert];
        [self presentViewController:aAlert animated:YES completion:nil];
        
        UIAlertAction *aAction = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:nil];
        UIAlertAction *bAction = [UIAlertAction actionWithTitle:@"取消" style:(UIAlertActionStyleCancel) handler:nil];
        [aAlert addAction:aAction];
        [aAlert addAction:bAction];
    }
}






@end
