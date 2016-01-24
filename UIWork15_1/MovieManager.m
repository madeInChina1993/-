//
//  MovieManager.m
//  UIWork15_1
//
//  Created by 宋丹 on 16/1/24.
//  Copyright © 2016年 lanou3g. All rights reserved.
//

#import "MovieManager.h"

@implementation MovieManager

+ (NSArray *)dataForFile:(NSString *)fileName
{
    // 1.准备路径
    NSString *path = NSHomeDirectory();
    path = [path stringByAppendingPathComponent:fileName];
    
    NSData *myData = [NSData dataWithContentsOfFile:path];
    
    // 创建反归档对象
    NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc]initForReadingWithData:myData];
    
    NSArray *dataArray =  [unarchiver decodeObjectForKey:@"result"];
    
    // 完成反归档
    [unarchiver finishDecoding];
    return dataArray;
}

@end
