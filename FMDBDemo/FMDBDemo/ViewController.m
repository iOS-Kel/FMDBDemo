//
//  ViewController./Users/gfk/Desktop/FMDBDemo/FMDBDemo/ViewController.mm
//  FMDBDemo
//
//  Created by GFK on 2017/5/13.
//  Copyright © 2017年 citotem. All rights reserved.
//

#import "ViewController.h"
#import <FMDB.h>

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextField *studentNumberTf;
@property (weak, nonatomic) IBOutlet UITextField *studentNameTf;
@property (weak, nonatomic) IBOutlet UITextField *studentGenderTf;
@property (weak, nonatomic) IBOutlet UITextField *studentAgeTf;
@property (weak, nonatomic) IBOutlet UITextField *studentHeightTf;
@property (weak, nonatomic) IBOutlet UILabel *tipLabel;

@end

@implementation ViewController
{
    FMDatabase *_database;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    NSString *cachesPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject];
    
    NSLog(@"cachesPath = %@", cachesPath);
    
    NSString *databaseName = @"dbTest.db";// 名字为dbTest、dbTest.db、dbTest.xx都可以成功创建数据库，如何写dbTest/abc，创建则失败，因为找不到dsTest这个文件夹。
    
    cachesPath = [cachesPath stringByAppendingPathComponent:databaseName];
    
    NSLog(@"cachesPath = %@", cachesPath);
    
    // 1.创建数据库
    _database = [FMDatabase databaseWithPath:cachesPath];
    
    // 2.打开数据库
    if ([_database open]) {
        self.tipLabel.text = @"数据库打开成功";
        
        // 3.创建表 autoincrement 自动增量  注意:句子不要写错了
        BOOL success = [_database executeUpdate:@"create table if not exists t_student (number integer primary key, name text not null, gender text not null, age integer, height real);"];
        if (success) {
            self.tipLabel.text = @"表创建成功";
        }else {
            self.tipLabel.text = @"表创建失败";
        }
        
    }else {
        self.tipLabel.text = @"数据库打开失败";
    }
    
    
    
}

- (IBAction)insertStudentData:(UIButton *)sender {
    
    BOOL success;
    // 更新方法1：executeUpdate : 不确定的参数用?来占位************
    // 插入成功 注意：参数必须全是对象
    success = [_database executeUpdate:@"insert into t_student (number, name, gender, age, height) values (?, ?, ?, ?, ?);", @([self.studentNumberTf.text integerValue]), self.studentNameTf.text, self.studentGenderTf.text, @([self.studentAgeTf.text integerValue]), @([self.studentHeightTf.text doubleValue])];
    
    // 插入成功 注意：参数必须全是对象
//    success = [_database executeUpdate:@"insert into t_student (number, name, gender, age, height) values (?, ?, ?, ?, ?);", @(2), @"刘四", @"男", @(18), @(1.65)];
    
    // 插入成功 注意：字符串用单引号引起来
//    success = [_database executeUpdate:@"insert into t_student (number, name, gender, age, height) values (1, '王五', '男', 20, 1.7);"];
    
    // 更新方法2：executeUpdateWithFormat : 不确定的参数用%@、%d等来占位************
    
    if (success) {
        self.tipLabel.text = @"插入成功";
    }else {
        self.tipLabel.text = @"插入失败";
        NSLog(@"%@", [_database lastErrorMessage]);
    }
}

- (IBAction)searchStudentData:(UIButton *)sender {
    
    /*
    // 1.执行查询
    FMResultSet *resultSet = [_database executeQuery:@"select * from t_student;"];
    
    // 2.遍历查询结果
    // 2.1遍历表中所有结果
    while ([resultSet next]) {
        NSInteger number = [resultSet intForColumn:@"number"];
        NSString *name = [resultSet stringForColumn:@"name"];
        NSString *gender = [resultSet stringForColumn:@"gender"];
        NSInteger age = [resultSet intForColumn:@"age"];
        double height = [resultSet doubleForColumn:@"height"];
        NSLog(@"%ld--%@--%@--%ld--%.2lf", number, name, gender, age, height);
    }
     */
    
    // 2.2指定条件查询
    FMResultSet *resultSet = [_database executeQuery:@"select * from t_student where number = ?", @([self.studentNumberTf.text integerValue])];
    
    while ([resultSet next]) {
        NSInteger number = [resultSet intForColumn:@"number"];
        NSString *name = [resultSet stringForColumn:@"name"];
        NSString *gender = [resultSet stringForColumn:@"gender"];
        NSInteger age = [resultSet intForColumn:@"age"];
        double height = [resultSet doubleForColumn:@"height"];
        
        self.studentNumberTf.text = [NSString stringWithFormat:@"%ld", number];
        self.studentNameTf.text = name;
        self.studentGenderTf.text = gender;
        self.studentAgeTf.text = [NSString stringWithFormat:@"%ld", age];
        self.studentHeightTf.text = [NSString stringWithFormat:@"%.2lf", height];
        NSLog(@"%ld--%@--%@--%ld--%.2lf", number, name, gender, age, height);
    }
    
    
}

- (IBAction)modifyStudentInfo:(UIButton *)sender {
    
    BOOL success;
    // 全部修改
//    success = [_database executeUpdate:@"update t_student set name = ? , gender = ?, age = ?, height = ?;", self.studentNameTf.text, self.studentGenderTf.text, @([self.studentAgeTf.text integerValue]), @([self.studentHeightTf.text doubleValue])];
    // 根据条件局部修改
    success = [_database executeUpdate:@"update t_student set name = ? , gender = ?, age = ?, height = ? where number = ?;", self.studentNameTf.text, self.studentGenderTf.text, @([self.studentAgeTf.text integerValue]), @([self.studentHeightTf.text doubleValue]), @([self.studentNumberTf.text integerValue])];
    
    if (success) {
        self.tipLabel.text = @"修改成功";
    }else {
        self.tipLabel.text = @"修改失败";
        NSLog(@"%@", [_database lastErrorMessage]);
    }
}

- (IBAction)deleteStudentInfo:(UIButton *)sender {
    
    BOOL success;
    success = [_database executeUpdate:@"delete from t_student where number = ?", @([self.studentNameTf.text integerValue])];
    if (success) {
        self.tipLabel.text = @"删除成功";
    }else {
        self.tipLabel.text = @"删除失败";
    }
}

- (IBAction)modifyStudentNumber:(UIButton *)sender {
    
    self.tipLabel.text = @"主键是唯一标识符，不可修改";
}

- (IBAction)modifyStudentName:(UIButton *)sender {
    
    BOOL success;
    
    success = [_database executeUpdate:@"update t_student set name = ? where number = ?", self.studentNameTf.text, @([self.studentNumberTf.text integerValue])];
    if (success) {
        self.tipLabel.text = @"姓名修改成功";
    }else {
        self.tipLabel.text = @"姓名修改失败";
        NSLog(@"%@", [_database lastErrorMessage]);
    }
}

- (IBAction)modifyStudentGender:(UIButton *)sender {
    
    BOOL success;
    
    success = [_database executeUpdate:@"update t_student set gender = ? where number = ?", self.studentGenderTf.text, @([self.studentNumberTf.text integerValue])];
    if (success) {
        self.tipLabel.text = @"性别修改成功";
    }else {
        self.tipLabel.text = @"性别修改失败";
        NSLog(@"%@", [_database lastErrorMessage]);
    }
}

- (IBAction)modifyStudentAge:(UIButton *)sender {
    
    BOOL success;
    
    success = [_database executeUpdate:@"update t_student set age = ? where number = ?", @([self.studentAgeTf.text integerValue]), @([self.studentNumberTf.text integerValue])];
    if (success) {
        self.tipLabel.text = @"年龄修改成功";
    }else {
        self.tipLabel.text = @"年龄修改失败";
        NSLog(@"%@", [_database lastErrorMessage]);
    }
}

- (IBAction)modifyStudentHeight:(UIButton *)sender {
    
    BOOL success;
    
    success = [_database executeUpdate:@"update t_student set height = ? where number = ?", self.studentHeightTf.text, @([self.studentNumberTf.text integerValue])];
    if (success) {
        self.tipLabel.text = @"身高修改成功";
    }else {
        self.tipLabel.text = @"身高修改失败";
        NSLog(@"%@", [_database lastErrorMessage]);
    }
}

- (IBAction)clearAllTextFieldContent:(UIButton *)sender {
    
    self.studentNumberTf.text = @"";
    self.studentNameTf.text = @"";
    self.studentGenderTf.text = @"";
    self.studentAgeTf.text = @"";
    self.studentHeightTf.text = @"";
}

- (IBAction)createTable:(UIButton *)sender {
    
    if ([_database open]) {
        
        self.tipLabel.text = @"数据库打开成功";
    
        // 随机生成一个表名
        NSArray *letters = @[@"a", @"b", @"c", @"d", @"e", @"f", @"g"];
        NSString *databaseName = @"";
        for (int i = 0; i < 5; i++) {
            int number = arc4random_uniform(5);
            databaseName = [databaseName stringByAppendingString:letters[number]];
        }
        NSLog(@"databaseName = %@", databaseName);
        
        BOOL success;

        // 1.测试创建表--成功 在navicat软件中中可看见创建的表
        NSString *sql = [NSString stringWithFormat:@"create table if not exists %@ (idCard text primary key, name text, age integer, height real);", databaseName];
        
        NSLog(@"create table sql = %@", sql);
        success = [_database executeUpdate:sql];
//
        // 2.测试创建表--成功 在navicat软件中中可看见创建的表
//        success = [_database executeUpdate:@"create table if not exists abc (number integer primary key, name text not null, gender text not null, age integer, height real);"];
        
        
        if (success) {
            NSLog(@"创建表成功，表名称是：%@", databaseName);
        }else {
            NSLog(@"创建表失败");
            NSLog(@"%@", [_database lastErrorMessage]);
        }
        
        
    }else {
        self.tipLabel.text = @"数据库打开失败";
    }
    
}

- (IBAction)deleteTable:(UIButton *)sender {
    
    BOOL success;
    
    // 语法格式：DROP TABLE IF EXISTS table_name;
    success = [_database executeUpdate:@"drop table if exists dcaec;"];
    
    if (success) {
        self.tipLabel.text = @"删除表成功";
    }else {
        self.tipLabel.text = @"删除表失败";
        NSLog(@"%@", [_database lastErrorMessage]);
    }
}

- (IBAction)addFieldForTable:(UIButton *)sender {
    
    BOOL success;
    
    // 1.如需在表中添加列，请使用下列语法:ALTER TABLE table_name ADD column_name datatype
    success = [_database executeUpdate:@"alter table badaa add field1 text;"];
    
    if (success) {
        self.tipLabel.text = @"添加列成功";
    }else {
        self.tipLabel.text = @"添加列失败";
        NSLog(@"%@", [_database lastErrorMessage]);
    }
}

- (IBAction)modifyField:(UIButton *)sender {
    
    
    // 1.修改字段类型 格式：ALTER TABLE Persons ALTER COLUMN Birthday year
    BOOL success;
    // 测试失败
    success = [_database executeUpdate:@"ALTER TABLE dabaa ALTER COLUMN field2 date"];
    
    if (success) {
        self.tipLabel.text = @"修改列数据类型成功";
    }else {
        self.tipLabel.text = @"修改列数据类型失败";
        NSLog(@"%@", [_database lastErrorMessage]);
    }
    
    /*
    // 2.修改字段名
    // 测试失败
    success = [_database executeUpdate:@"alter table badaa rename column field2 to fieldModify;"];
    
    if (success) {
        self.tipLabel.text = @"修改列名成功";
    }else {
        self.tipLabel.text = @"修改列名失败";
        NSLog(@"%@", [_database lastErrorMessage]);
    }
    */
    
    /**
     *总结：FMDB中，字段貌似修改不了？
     */
    
}

- (IBAction)deleteFieldForTable:(UIButton *)sender {
    
    
    BOOL success;
    
    // 1.如需在表中删除列，请使用下列语法:ALTER TABLE table_name DROP COLUMN column_name
    // 失败
    success = [_database executeUpdate:@"alter table badaa drop column field2;"];
    
    if (success) {
        self.tipLabel.text = @"删除列成功";
    }else {
        self.tipLabel.text = @"删除列失败";
        NSLog(@"%@", [_database lastErrorMessage]);
    }
    
    /**
     *总结：貌似删除不了字段？
     *注意：某些数据库系统不允许这种在数据库表中删除列的方式 (DROP COLUMN column_name)。
     */
}


@end
