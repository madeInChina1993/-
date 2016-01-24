//
//  ImageDownload.m
//  UILesson17_3BisisBean
//
//  Created by lanou3g on 16/1/13.
//  Copyright © 2016年 lanou3g. All rights reserved.
//

#import "ImageDownload.h"

static ImageDownload *imageDownload = nil;
@implementation ImageDownload

+ (instancetype)shareImageDownload{
    @synchronized(self) {
        if (imageDownload == nil) {
            imageDownload = [[ImageDownload alloc]init];
        }
    }
    return imageDownload;
}

- (void)imageDownloadWithString:(NSString *)urlString
               returnImageBlock:(imageDownloadWithBlock)
                                    returnImageBlock
{
    NSURL *url = [NSURL URLWithString:urlString];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    NSURLSessionDataTask *dataTask =[[NSURLSession sharedSession ]dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            returnImageBlock(data);
        });
    }];
    [dataTask resume];
    
}




@end
