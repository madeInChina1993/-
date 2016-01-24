//
//  transformViewController.m
//  UIWork15_1
//
//  Created by lanou3g on 16/1/19.
//  Copyright © 2016年 lanou3g. All rights reserved.
//

#import "transformViewController.h"
#import "SecondViewController.h"
#import "CollectionViewController.h"
#import "MovieDetails.h"

@interface transformViewController ()

@property(nonatomic,strong)SecondViewController *secondVC;
@property(nonatomic,strong)CollectionViewController *collectVC;

@property(nonatomic,assign)BOOL isClick;

@end

@implementation transformViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"电影";
    
    self.secondVC = [[SecondViewController alloc]init];
    self.collectVC = [[CollectionViewController alloc]init];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"btn_nav_list"] style:(UIBarButtonItemStylePlain) target:self action:@selector(rightButton:)];
    
    [self addChildViewController:self.secondVC];
    [self addChildViewController:self.collectVC];
    
    [self.view addSubview:self.secondVC.view];
    
    self.isClick = NO;
}

- (void)rightButton:(UIBarButtonItem *)sender
{
    if (self.isClick == NO) {
        [self.navigationItem.rightBarButtonItem setImage:[UIImage imageNamed:@"btn_nav_collection"]];
        [UIView transitionFromView:self.secondVC.view toView:self.collectVC.view duration:0.5 options:(UIViewAnimationOptionTransitionFlipFromRight) completion:nil];

        
        self.isClick = YES;
        
    } else {
        [self.navigationItem.rightBarButtonItem setImage:[UIImage imageNamed:@"btn_nav_list"]];
        [UIView transitionFromView:self.collectVC.view toView:self.secondVC.view duration:0.5 options:(UIViewAnimationOptionTransitionFlipFromLeft) completion:nil];
        self.isClick = NO;
    }
    
}

@end
