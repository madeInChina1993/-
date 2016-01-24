//
//  MovieList.m
//  UIWork15_1
//
//  Created by lanou3g on 16/1/13.
//  Copyright © 2016年 lanou3g. All rights reserved.
//

#import "MovieList.h"
#import "ImageDownload.h"
@implementation MovieList

- (void)imageLoading
{
    [[ImageDownload shareImageDownload]imageDownloadWithString:self.pic_url returnImageBlock:^(NSData *data) {
        self.loadImage = [UIImage imageWithData:data];
        self.isLoading = NO;
    }];
    
    self.isLoading = YES;
    
}

// 归档 编码 序列化
- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.movieId forKey:@"movieId"];
    [aCoder encodeObject:self.movieName forKey:@"movieName"];
    [aCoder encodeObject:self.pic_url forKey:@"pic_url"];
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init]) {
        self.movieId = [aDecoder decodeObjectForKey:@"movieId"];
        self.movieName = [aDecoder decodeObjectForKey:@"movieName"];
        self.pic_url = [aDecoder decodeObjectForKey:@"pic_url"];
    }
    return self;
}


- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    NSLog(@"找不到%@",key);
}






@end
