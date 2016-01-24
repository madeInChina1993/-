//
//  CollectionCell.m
//  UIWork15_1
//
//  Created by lanou3g on 16/1/19.
//  Copyright © 2016年 lanou3g. All rights reserved.
//

#import "CollectionCell.h"

@implementation CollectionCell

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self initLayout];
    }
    return self;
}

- (void)initLayout
{
    [self.contentView addSubview:self.pictureImageView];
    [self.contentView addSubview:self.nameLabel];
}

- (UIImageView *)pictureImageView
{
    if (_pictureImageView == nil) {
        _pictureImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.contentView.frame.size.width, 150)];
    }
    return _pictureImageView;
}

- (UILabel *)nameLabel
{
    if (_nameLabel == nil) {
        _nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMinX(self.pictureImageView.frame), CGRectGetMaxY(self.pictureImageView.frame), self.contentView.frame.size.width, 30)];
        _nameLabel.backgroundColor = [UIColor colorWithRed:0.2 green:0.76 blue:0.6 alpha:1];
        _nameLabel.font = [UIFont systemFontOfSize:15];
        _nameLabel.textAlignment = NSTextAlignmentCenter;
        
    }
    return _nameLabel;
}



@end
