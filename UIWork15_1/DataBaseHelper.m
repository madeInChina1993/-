//
//  DataBaseHelper.m
//  UIWork15_1
//
//  Created by lanou3g on 16/1/18.
//  Copyright © 2016年 lanou3g. All rights reserved.
//

#import "DataBaseHelper.h"
#import <sqlite3.h>
#import "ActivityList.h"

static DataBaseHelper *dataHelper = nil;
static sqlite3 *db = nil;
int result;
@implementation DataBaseHelper

#pragma mark --- 完整单例 ---
// 声明单例
+ (instancetype)shareDataBase{
    
    static dispatch_once_t onceTocken;
    dispatch_once(&onceTocken,^{
        dataHelper = [DataBaseHelper new];
    });
    return dataHelper;
}

// 打开数据库
- (void)openDataBase{
    // 创建保存数据库的路径
    NSString *documentPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)firstObject];
    // 拼接路径
    documentPath = [documentPath stringByAppendingPathComponent:@"message.sqlite"];
    // 打印地址
    NSLog(@"%@",documentPath);
    
    
    // 2.打开数据库
    result = sqlite3_open([documentPath UTF8String], &db);
    if (result == SQLITE_OK) {
        NSLog(@"数据库打开成功");
        // 打开数据库成功之后,就准备创建表格
        NSString *sql = @"create table if not exists activity (t_id integer primary key autoincrement not null unique,title text not null,begin_time text not null,end_time text not null,category_name text not null,name text not null,address text not null,content text not null,image_hlarge text not null)";
        
        // 执行sql语句
        result = sqlite3_exec(db, sql.UTF8String, NULL, NULL, NULL);
        if (result == SQLITE_OK) {
            NSLog(@"创建成功");
        } else {
            NSLog(@"创建失败%d",result);
        }
    }
}

// 关闭数据库
- (void)closeDataBase{
    result = sqlite3_close(db);
    if (result == SQLITE_OK) {
        NSLog(@"关闭数据库成功");
    } else {
        NSLog(@"关闭数据库失败");
    }
}

// 插入数据
- (void)insertData:(ActivityList *)activity{
    // 1.插入数据库之前确保数据库是打开的
    [self openDataBase];
    
    // 2.创建伴随指针,记录需要做的任务
    sqlite3_stmt *stmt = nil;
    
    // 3.准备插入sql语句
    NSString *sql = @"insert into activity(t_id,title,begin_time,end_time,category_name,name,address,content,image_hlarge) values(?,?,?,?,?,?,?,?,?)";
    // 验证sql语句
    result = sqlite3_prepare_v2(db, sql.UTF8String, -1, &stmt, NULL);
    
    if (result == SQLITE_OK) {
        NSLog(@"插入数据成功");
        
        sqlite3_bind_int(stmt, 1, activity.t_id);
        sqlite3_bind_text(stmt, 2, activity.title.UTF8String, -1, NULL);
        sqlite3_bind_text(stmt, 3, activity.begin_time.UTF8String, -1, NULL);
        sqlite3_bind_text(stmt, 4, activity.end_time.UTF8String, -1, NULL);
        sqlite3_bind_text(stmt, 5, activity.category_name.UTF8String, -1, NULL);
        sqlite3_bind_text(stmt, 6, activity.name.UTF8String, -1, NULL);
        sqlite3_bind_text(stmt, 7, activity.address.UTF8String, -1, NULL);
        sqlite3_bind_text(stmt, 8, activity.content.UTF8String, -1, NULL);
        sqlite3_bind_text(stmt, 9, activity.image_hlarge.UTF8String, -1, NULL);
        
        
        // 执行伴随指针
        sqlite3_step(stmt);
    } else {
        NSLog(@"数据插入失败:%d",result);
    }
    
    // 释放伴随指针
    sqlite3_finalize(stmt);
    
}

// 删除数据
- (void)deleteData:(NSString *)title{
    
    // 调用之前,确保打开数据库
    [self openDataBase];
    // 创建伴随指针
    sqlite3_stmt *stmt = nil;
    
    // 准备sql语句
    NSString *sql = @"delete from activity where title = ?";
    
    // 验证sql语句
    sqlite3_prepare_v2(db, sql.UTF8String, -1, &stmt, NULL);
    
    if (result == SQLITE_OK) {
        NSLog(@"删除数据成功");
        
        sqlite3_bind_text(stmt, 1, [title UTF8String], -1, NULL);
        // 执行伴随指针
        sqlite3_step(stmt);
    }else{
        NSLog(@"删除数据失败");
    }
    
    // 释放伴随指针
    sqlite3_finalize(stmt);
    
}

// 修改数据
- (void)updataT_id:(int)t_id
             title:(NSString *)title{
    
    [self openDataBase];
    // 创建伴随指针
    sqlite3_stmt *stmt = nil;
    
    // 准备sql语句
    NSString *sql = @"update activity set title = ? where t_id = ?";
    
    // 验证sql语句
    result = sqlite3_prepare_v2(db, sql.UTF8String, -1, &stmt, NULL);
    
    if (result == SQLITE_OK) {
        NSLog(@"修改成功");
        sqlite3_bind_text(stmt, 1, title.UTF8String, -1, NULL);
        sqlite3_bind_int(stmt, 2, t_id);
        
        // 执行伴随指针
        sqlite3_step(stmt);
    } else {
        NSLog(@"修改失败");
    }
    
    // 释放伴随指针
    sqlite3_finalize(stmt);
}

// 查询所有数据
- (NSMutableArray *)selectAllActivity{
    
    [self openDataBase];
    
    // 准备查询语句
    NSString *sql = @"select *from activity";
    // 创建伴随指针
    sqlite3_stmt *stmt = nil;
    
    result = sqlite3_prepare_v2(db, sql.UTF8String, -1, &stmt, NULL);
    NSMutableArray *array = [NSMutableArray array];
    
    if (result == SQLITE_OK) {
        NSLog(@"查血成功");
        while (sqlite3_step(stmt) == SQLITE_ROW) {
            
            int t_id = sqlite3_column_int(stmt, 0);
            NSString *title = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, 1)];
            NSString *begin_time = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, 2)];
            NSString *end_time = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, 3)];
            NSString *category_name = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, 4)];
            NSString *name = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, 5)];
            NSString *address = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, 6)];
            NSString *content = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, 7)];
            NSString *image_hlarge = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, 8)];
            
            // 创建ActivityList对象,使用对象中的属性进行储存
            ActivityList *activity = [ActivityList new];
            activity.t_id = t_id;
            activity.title = title;
            activity.begin_time = begin_time;
            activity.end_time = end_time;
            activity.category_name = category_name;
            activity.name = name;
            activity.address = address;
            activity.content = content;
            activity.image_hlarge = image_hlarge;
            
            // 将activity对象储存在数组中
            [array addObject:activity];
        }
        
    } else {
        NSLog(@"查询失败");
    }
    // 释放伴随指针
    sqlite3_finalize(stmt);
    return array;
}

- (NSMutableArray *)selectAllTitle
{
    [self openDataBase];
    NSMutableArray *array = [NSMutableArray array];
    // 准备查询语句
    NSString *sql = @"select from activity";
    // 创建伴随指针
    sqlite3_stmt *stmt = nil;
    
    result = sqlite3_prepare_v2(db, sql.UTF8String, -1, &stmt, NULL);
    
    if (result == SQLITE_OK) {
        NSLog(@"查询成功");
        while (SQLITE_ROW == sqlite3_step(stmt)) {
            NSString *title = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, 0)];
            
            [array addObject:title];
        }
        
    } else {
        NSLog(@"查询失败");
    }
    
    return array;
}














@end
