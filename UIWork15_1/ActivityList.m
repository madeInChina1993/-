//
//  ActivityList.m
//  UIWork15_1
//
//  Created by lanou3g on 16/1/11.
//  Copyright © 2016年 lanou3g. All rights reserved.
//

#import "ActivityList.h"
#import "ImageDownload.h"

@implementation ActivityList

- (void)imageLoading
{
    [[ImageDownload shareImageDownload] imageDownloadWithString:self.image_hlarge returnImageBlock:^(NSData *data) {
        self.loadImage = [UIImage imageWithData:data];
        self.isLoading = NO;
    }];
    self.isLoading = YES;
}

// 归档 编码 序列化
- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.title forKey:@"title"];
}


- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init]) {
        self.title = [aDecoder decodeObjectForKey:@"title"];
    }
    return self;
}




- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    NSLog(@"找不到%@",key);
}





@end
