//
//  HeadlinesViewController.h
//  凤凰新闻App
//
//  Created by lanou on 16/3/17.
//  Copyright © 2016年 jianjun. All rights reserved.
//

#import "BaseChildViewController.h"
#import "HeadView.h"
@interface HeadlinesViewController : BaseChildViewController

@property (nonatomic,strong)NSDictionary *titleDic;

-(void)requestWithUrl:(NSString *)url;

@end
