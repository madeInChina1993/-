//
//  LoginViewController.m
//  UIWork15_1
//
//  Created by lanou3g on 16/1/20.
//  Copyright © 2016年 lanou3g. All rights reserved.
//

#import "LoginViewController.h"
#import "RegisterViewController.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"用户登录";
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"取消" style:(UIBarButtonItemStyleDone) target:self action:@selector(cancelClick)];
    
    self.navigationItem .rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"注册" style:(UIBarButtonItemStyleDone) target:self action:@selector(registerClick)];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)cancelClick
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)registerClick
{
    RegisterViewController *registerVC = [[RegisterViewController alloc]init];
    UINavigationController *navigation = [[UINavigationController alloc]initWithRootViewController:registerVC];
    
    [self presentViewController:navigation animated:YES completion:nil];
}

@end
