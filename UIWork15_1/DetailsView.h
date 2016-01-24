//
//  DetailsView.h
//  UIWork15_1
//
//  Created by lanou3g on 16/1/16.
//  Copyright © 2016年 lanou3g. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailsView : UIView

@property (nonatomic,strong)UIScrollView *scrollView;

@property (nonatomic,strong)UILabel *titleLabel;

@property (nonatomic,strong)UIImageView *pictureImageView;

@property (nonatomic,strong)UIImageView *dateImageView;
@property (nonatomic,strong)UIImageView *nameImageView;
@property (nonatomic,strong)UIImageView *typeImageView;
@property (nonatomic,strong)UIImageView *addressImageView;

@property (nonatomic,strong)UILabel *dateLabel;
@property (nonatomic,strong)UILabel *nameLabel;
@property (nonatomic,strong)UILabel *typeLabel;
@property (nonatomic,strong)UILabel *addressLabel;

@property (nonatomic,strong)UILabel *introduceLabel;
@property (nonatomic,strong)UILabel *contentLabel;




@end
