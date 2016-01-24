//
//  MovieList.h
//  UIWork15_1
//
//  Created by lanou3g on 16/1/13.
//  Copyright © 2016年 lanou3g. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface MovieList : NSObject

@property(nonatomic,copy)NSString *movieId;
@property(nonatomic,copy)NSString *movieName;
@property(nonatomic,copy)NSString *pic_url;


// 用来缓存图片
@property(nonatomic,strong)UIImage *loadImage;
// 判断是否正在下载
@property(nonatomic,assign)BOOL isLoading;

- (void)imageLoading;


@end
