//
//  RegisterViewController.m
//  UIWork15_1
//
//  Created by lanou3g on 16/1/20.
//  Copyright © 2016年 lanou3g. All rights reserved.
//

#import "RegisterViewController.h"

@interface RegisterViewController ()

@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"用户注册";
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"取消" style:(UIBarButtonItemStyleDone) target:self action:@selector(cancelClick)];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"注册" style:(UIBarButtonItemStyleDone) target:self action:@selector(registerClick)];
}

- (void)cancelClick
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)registerClick
{
    
}


@end
