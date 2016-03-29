//
//  loginModel.h
//  凤凰新闻App
//
//  Created by lanou on 16/3/24.
//  Copyright © 2016年 jianjun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface loginModel : NSObject

@property (nonatomic,strong)NSString *userName;
@property (nonatomic,strong)NSString *password;
@property (nonatomic,assign)BOOL isLogin;
@property (nonatomic,strong)NSString *name;
@property (nonatomic,strong)NSString *gender;

@end
