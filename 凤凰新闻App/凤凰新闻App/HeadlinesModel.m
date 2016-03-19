//
//  headlinesModel.m
//  凤凰新闻App
//
//  Created by lanou on 16/3/18.
//  Copyright © 2016年 jianjun. All rights reserved.
//

#import "headlinesModel.h"

@implementation HeadlinesModel

-(instancetype)initWithDictionary:(NSDictionary *)dic
{
    self = [super init];
    if (self) {
        [self setValuesForKeysWithDictionary:dic];
    }
    return self;
}

-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}
@end
