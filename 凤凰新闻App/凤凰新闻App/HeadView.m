//
//  HeadView.m
//  凤凰新闻App
//
//  Created by lanou on 16/3/15.
//  Copyright © 2016年 jianjun. All rights reserved.
//

#import "HeadView.h"
#import "Header.h"
#import "CustomButton.h"
@implementation HeadView
{
    
    UIView *_underLine;
}
-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _button24 = [CustomButton buttonWithType:UIButtonTypeCustom];
        
        _plusButton = [CustomButton buttonWithType:UIButtonTypeCustom];
        
        _titleScrollView = [[UIScrollView alloc]initWithFrame:CGRectZero];
        
        [self setConfiguration];
        
        
    }
    return self;
}

//懒加载
-(NSMutableArray *)buttonArray
{
    if (!_buttonArray) {
        _buttonArray = [NSMutableArray array];
    }
    return _buttonArray;
}


-(void)setConfiguration
{
    _button24.frame = CGRectMake(0, 0, 44, 44);
    
    [_button24 setImage:[UIImage imageNamed:@"24.png"] forState:UIControlStateNormal];
    
    [_button24 addTarget:self action:@selector(button24Click:) forControlEvents:UIControlEventTouchUpInside];
    
    [self addSubview:_button24];
    
    
    
    _plusButton.frame = CGRectMake(W - 44, -1, 44, 44);
    
    [_plusButton setImage:[UIImage imageNamed:@"加号"] forState:UIControlStateNormal];
    
    [self addSubview:_plusButton];
    
    
    
}


-(void)setTitleWithArray:(NSArray *)titleArray
{
    _itemWidth = (W - 88) / 5;
    self.titleScrollView.frame = CGRectMake(44, 0, W - 88, 44);
    self.titleScrollView.showsHorizontalScrollIndicator = NO;
    
    self.titleScrollView.contentSize = CGSizeMake(_itemWidth * [titleArray count], 0);
    
    
    if ([[self.titleScrollView subviews] count] != 0) {
        for (id view in [self.titleScrollView subviews]) {
            [view removeFromSuperview];
        }
    }
        
    for (int i = 0; i < [titleArray count]; i++) {
            
        CustomButton *titleButton = [CustomButton buttonWithType:UIButtonTypeCustom];
        
        titleButton.frame = CGRectMake(i * _itemWidth, 0, _itemWidth, 44);
        
        [titleButton setTitle:[titleArray objectAtIndex:i] forState:UIControlStateNormal];
        [titleButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        
        [titleButton setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
        
        [titleButton addTarget:self action:@selector(titleButton:) forControlEvents:UIControlEventTouchUpInside];
        
        titleButton.tag = 1000 + i;
        
        if (titleButton.tag == 1000) {
            titleButton.selected = YES;
            
        }
        
        [self.buttonArray addObject:titleButton];
        
        [self.titleScrollView addSubview:titleButton];
            
    }
        _underLine = [[UIView alloc]initWithFrame:CGRectMake(0, 42, _itemWidth, 2)];
        
        _underLine.backgroundColor = [UIColor redColor];
        
        [self.titleScrollView addSubview:_underLine];
        
        [self addSubview:self.titleScrollView];
    
}


-(void)button24Click:(CustomButton *)sender
{
    
}


-(void)titleButton:(CustomButton *)sender
{
    for (CustomButton *btn in self.buttonArray) {
        if (sender.tag == btn.tag) {
            
            btn.selected = YES;
            
            _underLine.frame = CGRectMake((btn.tag - 1000) * _itemWidth, 42, _itemWidth, 2);
            
            [self.delegate setOffsetNumber:(btn.tag - 1000)];
            
            [self.OtherDelegate setButtonTitle:sender.titleLabel.text Tag:sender.tag buttonArray:self.buttonArray];
            
        }else{
            
            btn.selected = NO;
            
        }
    }
    if (sender.tag > 1002) {
        NSInteger k = (int)sender.tag - 1002;
        if(sender.tag + 3 >= 1000 + [_buttonArray count]){
            k = [_buttonArray count] - 5;
            [self.titleScrollView setContentOffset:CGPointMake(k * _itemWidth, 0) animated:YES];
        }else{
            
            [self.titleScrollView setContentOffset:CGPointMake(k * _itemWidth , 0) animated:YES];
        }
    }else{
        [self.titleScrollView setContentOffset:CGPointMake(0 , 0) animated:YES];
    }

}

-(void)setTitleScrollViewOffsetWithPage:(NSInteger)page
{
    
    for (CustomButton *btn in self.buttonArray) {
        if (btn.tag == page + 1000) {
            
            btn.selected = YES;
            
            _underLine.frame = CGRectMake((btn.tag - 1000) * _itemWidth, 42, _itemWidth, 2);
            
            
        }else{
            
            btn.selected = NO;
            
        }
    }

}

@end
