//
//  FirstCell.h
//  UIWork15_1
//
//  Created by lanou3g on 16/1/11.
//  Copyright © 2016年 lanou3g. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FirstCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@property (weak, nonatomic) IBOutlet UILabel *addressLabel;

@property (weak, nonatomic) IBOutlet UILabel *categoryNameLabel;

@property (weak, nonatomic) IBOutlet UILabel *wisherCountLabel;

@property (weak, nonatomic) IBOutlet UILabel *participantCountLabel;

@property (weak, nonatomic) IBOutlet UIImageView *activityImageView;

@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicatorView;

@property (weak, nonatomic) IBOutlet UIImageView *timeImageView;

@property (weak, nonatomic) IBOutlet UIImageView *addressImageView;
@property (weak, nonatomic) IBOutlet UIImageView *categoryImageView;




@end
