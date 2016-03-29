//
//  DataBase.m
//  FMDB
//
//  Created by lanou on 16/3/24.
//  Copyright © 2016年 jianjun. All rights reserved.
//

#import "DataBase.h"
#import <FMDatabase.h>
@interface DataBase()
@property (strong, nonatomic)FMDatabase *FMdatabase;
@property (strong, nonatomic)NSString *tableName;
@end
@implementation DataBase

+(DataBase *)shareDataBase
{
    //第一种
    static DataBase *dataBase = nil;
//    @synchronized(self) {
//        if (dataBase == nil) {
//            dataBase = [[DataBase alloc]init];
//        }
//    }
    //第二种
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        dataBase = [[DataBase alloc]init];
    });

    return dataBase;
}
-(id)init
{
    if (self = [super init]) {
        NSString *docPath = [NSSearchPathForDirectoriesInDomains(NSApplicationSupportDirectory, NSUserDomainMask, YES)lastObject];
        NSString *dbPath = [docPath stringByAppendingString:@"aaa.sqlite"];
        NSLog(@"%@",dbPath);
        self.FMdatabase = [FMDatabase databaseWithPath:dbPath];
        [self.FMdatabase close];
    }
    return self;
}

-(BOOL)createTable:(NSString *)string
{
    [[NSUserDefaults standardUserDefaults] setObject:string forKey:@"tableName"];
    if ([self.FMdatabase open]) {
        NSString *str = [NSString stringWithFormat:@"create table if not exists %@ (id integer primary key autoincrement,userName text,password text,isLogin int,name text,gender text)",string];
        BOOL result = [self.FMdatabase executeUpdate:str];
        return result;
    }
    return NO;
}

-(BOOL)insertLoginModel:(loginModel *)login
{
    if ([self.FMdatabase open]) {
        NSString *str = [NSString stringWithFormat:@"insert into %@ (userName,password,isLogin,name,gender) values('%@','%@','%d','%@','%@')",[[NSUserDefaults standardUserDefaults]objectForKey:@"tableName"] ,login.userName,login.password,login.isLogin,login.name,login.gender];
        BOOL result = [self.FMdatabase executeUpdate:str];
        NSLog(@"%d",result);
        NSLog(@"aaaaaa%ld",[[self selectInfo]count]);
        [self.FMdatabase close];
        return result;
    }
    return NO;
}


-(NSArray *)selectInfo
{
    NSMutableArray *selectArray = [NSMutableArray array];
    if ([self.FMdatabase open]) {
        NSString *str = [NSString stringWithFormat:@"select *from '%@'",[[NSUserDefaults standardUserDefaults]objectForKey:@"tableName"]];
        FMResultSet *set = [self.FMdatabase executeQuery:str];
        while ([set next]) {
            loginModel *login = [[loginModel alloc]init];
            login.userName = [set stringForColumn:@"userName"];
            login.password = [set stringForColumn:@"password"];
            login.isLogin = [set boolForColumn:@"isLogin"];
            login.name = [set stringForColumn:@"name"];
            login.gender = [set stringForColumn:@"gender"];
            [selectArray addObject:login];
        }
        [self.FMdatabase close];
    }
    return selectArray;
}
-(BOOL)updateLoginStatus:(BOOL)status userName:(NSString *)userName
{
    if ([self.FMdatabase open]) {
        NSString *str = [NSString stringWithFormat:@"update '%@' set isLogin = '%d' where userName = '%@'",[[NSUserDefaults standardUserDefaults]objectForKey:@"tableName"],status,userName];
        NSLog(@"%@",str);
        BOOL result = [self.FMdatabase executeUpdate:str];
        NSLog(@"%d",result);
        [self.FMdatabase close];
        return result;
    }
    return NO;
}
-(BOOL)updateName:(NSString *)name userName:(NSString *)userName
{
    if ([self.FMdatabase open]) {
        NSString *str = [NSString stringWithFormat:@"update '%@' set name = '%@' where userName = '%@'",[[NSUserDefaults standardUserDefaults]objectForKey:@"tableName"],name,userName];
        NSLog(@"%@",str);
        BOOL result = [self.FMdatabase executeUpdate:str];
        NSLog(@"%d",result);
        [self.FMdatabase close];
        return result;
    }
    return NO;

}

-(BOOL)updateGender:(NSString *)gender userName:(NSString *)userName
{
    if ([self.FMdatabase open]) {
        NSString *str = [NSString stringWithFormat:@"update '%@' set gender = '%@' where userName = '%@'",[[NSUserDefaults standardUserDefaults]objectForKey:@"tableName"],gender,userName];
        NSLog(@"%@",str);
        BOOL result = [self.FMdatabase executeUpdate:str];
        NSLog(@"%d",result);
        [self.FMdatabase close];
        return result;
    }
    return NO;

}
@end
