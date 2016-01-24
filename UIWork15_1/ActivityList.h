//
//  ActivityList.h
//  UIWork15_1
//
//  Created by lanou3g on 16/1/11.
//  Copyright © 2016年 lanou3g. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface ActivityList : NSObject<NSCoding>



@property(nonatomic,copy)NSString *owner;
@property(nonatomic,copy)NSString *name;
@property(nonatomic,copy)NSString *title;
@property(nonatomic,copy)NSString *wisher_count;
@property(nonatomic,copy)NSString *participant_count;
@property(nonatomic,copy)NSString *content;
@property(nonatomic,copy)NSString *image_hlarge;
@property(nonatomic,copy)NSString *begin_time;
@property(nonatomic,copy)NSString *category_name;
@property(nonatomic,copy)NSString *end_time;
@property(nonatomic,copy)NSString *address;

@property(nonatomic,assign)int t_id;

// 用来缓存图片
@property(nonatomic,strong)UIImage *loadImage;
// 判断是否正在下载
@property(nonatomic,assign)BOOL isLoading;

- (void)imageLoading;










@end
