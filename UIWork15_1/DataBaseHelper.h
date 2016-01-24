//
//  DataBaseHelper.h
//  UIWork15_1
//
//  Created by lanou3g on 16/1/18.
//  Copyright © 2016年 lanou3g. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ActivityList;
@interface DataBaseHelper : NSObject

// 声明单例
+ (instancetype)shareDataBase;

// 打开数据库
- (void)openDataBase;

// 关闭数据库
- (void)closeDataBase;

// 插入数据
- (void)insertData:(ActivityList *)activity;

// 删除数据
- (void)deleteData:(NSString *)title;

// 修改数据
- (void)updataT_id:(int)t_id
             title:(NSString *)title;

// 查询数据
- (NSArray *)selectAllActivity;


@end
