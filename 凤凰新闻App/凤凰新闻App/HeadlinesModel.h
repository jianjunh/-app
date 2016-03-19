//
//  headlinesModel.h
//  凤凰新闻App
//
//  Created by lanou on 16/3/18.
//  Copyright © 2016年 jianjun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HeadlinesModel : NSObject

@property (nonatomic,strong)NSString *thumbnail;

@property (nonatomic,strong)NSString *title;

@property (nonatomic,strong)NSString *updateTime;

@property (nonatomic,strong)NSString *commentsall;

@property (nonatomic,strong)NSString *type;

@property (nonatomic,strong)NSString *commentsUrl;

-(instancetype)initWithDictionary:(NSDictionary *)dic;
@end
