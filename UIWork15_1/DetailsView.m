//
//  DetailsView.m
//  UIWork15_1
//
//  Created by lanou3g on 16/1/16.
//  Copyright © 2016年 lanou3g. All rights reserved.
//

#import "DetailsView.h"

@implementation DetailsView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self initLayout];
    }
    return self;
}

- (void)initLayout
{
    self.backgroundColor = [UIColor whiteColor];
    
    self.scrollView = [[UIScrollView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.scrollView.contentSize = CGSizeMake(self.frame.size.width, self.frame.size.height * 2.2);
    [self addSubview:self.scrollView];
    
    
    self.titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(25, 20, self.frame.size.width - 50, 35)];
//        self.titleLabel.backgroundColor = [UIColor redColor];
    [self.scrollView addSubview:self.titleLabel];
    
    
    self.pictureImageView = [[UIImageView alloc]initWithFrame:CGRectMake(30, CGRectGetMaxY(self.titleLabel.frame) + 20, self.frame.size.width / 3.5, self.frame.size.height / 4)];
//        self.pictureImageView.backgroundColor = [UIColor redColor];
    [self.scrollView addSubview:self.pictureImageView];
    
    
    self.dateImageView = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.pictureImageView.frame) + 10, CGRectGetMinY(self.pictureImageView.frame), 20, 20)];
    self.dateImageView.image = [UIImage imageNamed:@"icon_date_blue"];
    [self.scrollView addSubview:self.dateImageView];
    
    
    self.dateLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.dateImageView.frame), CGRectGetMinY(self.dateImageView.frame), CGRectGetWidth(self.pictureImageView.frame) * 2 - 30, 20)];
//        self.dateLabel.backgroundColor = [UIColor redColor];
    self.dateLabel.font = [UIFont systemFontOfSize:14];
    [self.scrollView addSubview:self.dateLabel];
    
    
    self.nameImageView = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.pictureImageView.frame) + 10, CGRectGetMaxY(self.dateImageView.frame) + 8, 20, 20)];
    self.nameImageView.image = [UIImage imageNamed:@"icon_sponsor_blue"];
    [self.scrollView addSubview:self.nameImageView];
    
    
    self.nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.dateImageView.frame), CGRectGetMinY(self.nameImageView.frame), CGRectGetWidth(self.pictureImageView.frame) * 2 - 30, 20)];
//        self.nameLabel.backgroundColor = [UIColor redColor];
    self.nameLabel.font = [UIFont systemFontOfSize:14];
    [self.scrollView addSubview:self.nameLabel];
    
    
    self.typeImageView = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.pictureImageView.frame) + 10, CGRectGetMaxY(self.nameImageView.frame) + 8, 20, 20)];
    self.typeImageView.image = [UIImage imageNamed:@"icon_catalog_blue"];
    [self.scrollView addSubview:self.typeImageView];
    
    
    self.typeLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.dateImageView.frame), CGRectGetMinY(self.typeImageView.frame), CGRectGetWidth(self.pictureImageView.frame) * 2 - 30, 20)];
//        self.typeLabel.backgroundColor = [UIColor redColor];
    self.typeLabel.font = [UIFont systemFontOfSize:14];
    [self.scrollView addSubview:self.typeLabel];
    
    
    self.addressImageView = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.pictureImageView.frame) + 10, CGRectGetMaxY(self.typeImageView.frame) + 8, 20, 20)];
    self.addressImageView.image = [UIImage imageNamed:@"icon_spot_blue"];
    [self.scrollView addSubview:self.addressImageView];
    
    
    self.addressLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.dateImageView.frame), CGRectGetMinY(self.addressImageView.frame), CGRectGetWidth(self.pictureImageView.frame) * 2 - 30, 60)];
//        self.addressLabel.backgroundColor = [UIColor redColor];
    self.addressLabel.font = [UIFont systemFontOfSize:14];
    self.addressLabel.numberOfLines = 0;
    [self.scrollView addSubview:self.addressLabel];
    
    
    self.introduceLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMinX(self.pictureImageView.frame), CGRectGetMaxY(self.pictureImageView.frame) + 10, CGRectGetWidth(self.pictureImageView.frame), 35)];
//        self.activityIntroLabel.backgroundColor = [UIColor redColor];
    self.introduceLabel.text = @"活动介绍";
    self.introduceLabel.font = [UIFont systemFontOfSize:22];
    [self.scrollView addSubview:self.introduceLabel];
    
    
    self.contentLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMinX(self.introduceLabel.frame), CGRectGetMaxY(self.introduceLabel.frame) + 5, self.frame.size.width - 50, self.frame.size.height * 1.7)];
//        self.activityInfoLabel.backgroundColor = [UIColor redColor];
    self.contentLabel.font = [UIFont systemFontOfSize:14];
    self.contentLabel.numberOfLines = 0;
    [self.scrollView addSubview:self.contentLabel];
    
}






@end
