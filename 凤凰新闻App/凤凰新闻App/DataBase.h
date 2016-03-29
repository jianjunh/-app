//
//  DataBase.h
//  FMDB
//
//  Created by lanou on 16/3/24.
//  Copyright © 2016年 jianjun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "loginModel.h"
@interface DataBase : NSObject

+(DataBase *)shareDataBase;
//创建一个表
-(BOOL)createTable:(NSString *)string;
//添加数据
-(BOOL)insertLoginModel:(loginModel *)login;
//查询
-(NSArray *)selectInfo;
//更新数据
-(BOOL)updateLoginStatus:(BOOL)status userName:(NSString *)userName;
-(BOOL)updateName:(NSString *)name userName:(NSString *)userName;
-(BOOL)updateGender:(NSString *)gender userName:(NSString *)userName;

@end
