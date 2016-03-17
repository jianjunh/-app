//
//  HeadView.h
//  凤凰新闻App
//
//  Created by lanou on 16/3/15.
//  Copyright © 2016年 jianjun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HeadView : UIView

@property (nonatomic,strong)UIButton *button24;

@property (nonatomic,strong)UIScrollView *titleScrollView;

@property (nonatomic,strong)UIButton *plusButton;

@property (nonatomic,strong)NSMutableArray *buttonArray;

-(instancetype)initWithFrame:(CGRect)frame;

-(void)setTitleWithArray:(NSArray *)titleArray;

@end
