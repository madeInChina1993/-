//
//  detailsViewController.m
//  UIWork15_1
//
//  Created by lanou3g on 16/1/14.
//  Copyright © 2016年 lanou3g. All rights reserved.
//

#import "detailsViewController.h"
#import "ActivityList.h"
#import "DetailsView.h"
#import "UIImageView+WebCache.h"
#import "DataBaseHelper.h"

@interface detailsViewController ()
@property(nonatomic,strong)DetailsView *detailsView;
@property(nonatomic,strong)NSMutableArray *array;

@end

@implementation detailsViewController

- (void)loadView
{
    self.detailsView = [[DetailsView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.view = self.detailsView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    self.dataArray = [NSMutableArray array];
    
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:0.357 green:0.529 blue:0.624 alpha:1.000];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"btn_nav_share"] style:(UIBarButtonItemStyleDone) target:self action:@selector(rightButton)];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"btn_nav_back"] style:(UIBarButtonItemStyleDone) target:self action:@selector(leftButton)];
    
    [self handleData];
    
    // 该数组用于判断是否是收藏过的活动,下面用到
    self.array = [NSMutableArray array];
    
}

- (void)handleData
{
    ActivityList *activity = [ActivityList new];
    activity = self.dataArray[self.section];
    
    // 模型对象的值传进Lebel里
    self.detailsView.titleLabel.text = activity.title;
    
    NSString *beginTime = [activity.begin_time substringWithRange:NSMakeRange(5, 11)];
    NSString *endTime = [activity.end_time substringWithRange:NSMakeRange(5, 11)];
    self.detailsView.dateLabel.text = [NSString stringWithFormat:@"%@ -- %@",beginTime,endTime];
    
    self.detailsView.typeLabel.text = [NSString stringWithFormat:@"类型: %@",activity.category_name];
    self.detailsView.nameLabel.text = activity.name;
    self.detailsView.addressLabel.text = activity.address;
    self.detailsView.contentLabel.text = activity.content;
    // 调用第三方,加载图片
    [self.detailsView.pictureImageView sd_setImageWithURL:[NSURL URLWithString:activity.image_hlarge]];
    
    
    // 自定义DetailsView类里的scrollView,Label和addressLabel的自适应高度
    // scrollView的自适应高度
    self.detailsView.scrollView.contentSize = CGSizeMake(self.detailsView.frame.size.width, [self scrollViewHeight:activity.content] + self.detailsView.frame.size.height / 2);
    
    // contentLabel的自适应高度
    CGFloat contentLabelX = CGRectGetMinX(self.detailsView.introduceLabel.frame);
    CGFloat contentLabelY = CGRectGetMaxY(self.detailsView.introduceLabel.frame) + 5;
    CGFloat contentLabelW = self.detailsView.frame.size.width - 50;
    CGFloat contentLabelH = [self scrollViewHeight:activity.content];
    self.detailsView.contentLabel.frame = CGRectMake(contentLabelX, contentLabelY, contentLabelW, contentLabelH);
    
    // addressLabel的自适应高度
    CGFloat addressLabelX = CGRectGetMaxX(self.detailsView.dateImageView.frame);
    CGFloat addressLabelY = CGRectGetMinY(self.detailsView.addressImageView.frame);
    CGFloat addressLabelW = CGRectGetWidth(self.detailsView.pictureImageView.frame) * 2 - 30;
    CGFloat addressLabelH = [self addressLabelHeight:activity.address];

    self.detailsView.addressLabel.frame = CGRectMake(addressLabelX, addressLabelY, addressLabelW, addressLabelH);
    
    
    
}

// contentLabel的自适应高度方法
- (CGFloat)scrollViewHeight:(NSString *)aString
{
    CGRect temp = [aString boundingRectWithSize:CGSizeMake(self.detailsView.scrollView.frame.size.width - 50, 200000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil];
    return temp.size.height;
}


// addressLabel的自适应高度
- (CGFloat)addressLabelHeight:(NSString *)aString
{
    CGRect temp = [aString boundingRectWithSize:CGSizeMake(CGRectGetWidth(self.detailsView.typeLabel.frame), 200000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil];
    return temp.size.height;
}


// 返回
- (void)leftButton
{
    [self.navigationController popViewControllerAnimated:YES];
}

// 点击收藏
- (void)rightButton
{
    ActivityList *activity = [ActivityList new];
    
    activity.title = self.navigationItem.title;
    
//    DataBaseHelper *db = [DataBaseHelper shareDataBase];
//    [db insertData:activity];
    
    // 1.准备路径
    NSString *path = NSHomeDirectory();
    path = [path stringByAppendingPathComponent:@"details.txt"];
    
    NSMutableData *data = [NSMutableData data];
    // 2.创建归档对象
    NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc]initForWritingWithMutableData:data];
    
    // 3.开始归档
    [archiver encodeObject:activity forKey:@"activity"];
    
    // 4.完成归档
    [archiver finishEncoding];
    
    // 5.写入文件
    BOOL result = [data writeToFile:path atomically:YES];
    if (result) {
        NSLog(@"归档成功%@",path);
    }else{
        NSLog(@"归档失败");
    }
    
    
    
    
#pragma mark --- Alert提示 ---
    // 如果没有收藏过
    if ([self.array count] == 0) {
        
        [self.array addObject:activity.title];
        
        UIAlertController *aLert = [UIAlertController alertControllerWithTitle:@"提示" message:@"收藏成功" preferredStyle:(UIAlertControllerStyleAlert)];
        
        [self presentViewController:aLert animated:YES completion:nil];
        
//        [NSTimer scheduledTimerWithTimeInterval:0.3 target:self selector:@selector(action1) userInfo:nil repeats:YES];
        
        [UIView animateWithDuration:0.3 animations:^{
            [self dismissViewControllerAnimated:YES completion:nil];
        }];
    
    // 如果收藏过
    } else if([self.array count] > 0){
        
        UIAlertController *bLert = [UIAlertController alertControllerWithTitle:@"提示" message:@"您已收藏过此活动" preferredStyle:(UIAlertControllerStyleAlert)];
        
        [self presentViewController:bLert animated:YES completion:nil];
        
        UIAlertAction *bAction = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleCancel) handler:nil];
        
        [bLert addAction:bAction];
    }
}



@end
