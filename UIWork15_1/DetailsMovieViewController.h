//
//  DetailsMovieViewController.h
//  UIWork15_1
//
//  Created by lanou3g on 16/1/18.
//  Copyright © 2016年 lanou3g. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailsMovieViewController : UIViewController

@property(nonatomic,assign)NSInteger section;
@property(nonatomic,strong)NSMutableArray *dataArray;
@property(nonatomic,strong)NSMutableArray *allDataArray;

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property (weak, nonatomic) IBOutlet UILabel *ratingLabel;
@property (weak, nonatomic) IBOutlet UILabel *ratingCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *runTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *genresLabel;
@property (weak, nonatomic) IBOutlet UILabel *countryLabel;
@property (weak, nonatomic) IBOutlet UILabel *actorsLabel;
@property (weak, nonatomic) IBOutlet UILabel *plotSimpleLabel;

@property (weak, nonatomic) IBOutlet UIImageView *aImageView;

@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *aIndicatorView;


@property(nonatomic,strong)NSString *movieid;

// 测试是否被收藏过用的数组
@property(nonatomic,strong)NSMutableArray *array;

@end
