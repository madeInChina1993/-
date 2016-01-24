//
//  ImageDownload.h
//  UILesson17_3BisisBean
//
//  Created by lanou3g on 16/1/13.
//  Copyright © 2016年 lanou3g. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^imageDownloadWithBlock)(NSData *data);
@interface ImageDownload : NSObject


+ (instancetype)shareImageDownload;

- (void)imageDownloadWithString:(NSString *)urlString
               returnImageBlock:(imageDownloadWithBlock)
                    returnImageBlock;


@end
