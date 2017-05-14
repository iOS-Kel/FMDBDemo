//
//  AppDelegate.m
//  FMDBDemo
//
//  Created by GFK on 2017/5/13.
//  Copyright © 2017年 citotem. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

/**
 * 数据库基本知识学习
 
 1、数据类型
 null 值是空值
 integer 值是整型
 real 值是浮点数
 text 值是文本字符串
 blob 值是一个二进制类型
 date 日期类型
 year 年类型（可以存放 2 位或 4 位格式的年份）
 
 2、SQL DML 和 DDL
 可以把 SQL 分为两个部分：数据操作语言 (DML) 和 数据定义语言 (DDL)。
 
 2.1、SQL (结构化查询语言)是用于执行查询的语法。但是 SQL 语言也包含用于更新、插入和删除记录的语法。
 
 查询和更新指令构成了 SQL 的 DML 部分：
 
 SELECT - 从数据库表中获取数据
 UPDATE - 更新数据库表中的数据
 DELETE - 从数据库表中删除数据
 INSERT INTO - 向数据库表中插入数据
 
 2.2、SQL 的数据定义语言 (DDL) 部分使我们有能力创建或删除表格。我们也可以定义索引（键），规定表之间的链接，以及施加表间的约束。
 
 SQL 中最重要的 DDL 语句:
 
 CREATE DATABASE - 创建新数据库
 ALTER DATABASE - 修改数据库
 CREATE TABLE - 创建新表
 ALTER TABLE - 变更（改变）数据库表（即用于在已有的表中添加、修改或删除列。）
 DROP TABLE - 删除表
 CREATE INDEX - 创建索引（搜索键）
 DROP INDEX - 删除索引
 

 */


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
