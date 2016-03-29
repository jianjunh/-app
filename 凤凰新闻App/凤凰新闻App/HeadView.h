//
//  HeadView.h
//  凤凰新闻App
//
//  Created by lanou on 16/3/15.
//  Copyright © 2016年 jianjun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomButton.h"
@protocol changeScrollViewOffset <NSObject>

@optional

-(void)setOffsetNumber:(NSInteger)page;

@end

@protocol setButtonTitle <NSObject>

@optional

-(void)setButtonTitle:(NSString *)buttonTitle Tag:(NSInteger)tag buttonArray:(NSMutableArray *)buttonArray;

@end

@interface HeadView : UIView

@property (nonatomic,strong)CustomButton *button24;

@property (nonatomic,strong)UIScrollView *titleScrollView;

@property (nonatomic,strong)CustomButton *plusButton;

@property (nonatomic,strong)NSMutableArray *buttonArray;

@property (nonatomic,assign)id<changeScrollViewOffset>delegate;

@property (nonatomic,assign)id<setButtonTitle>OtherDelegate;

@property (nonatomic,assign)CGFloat itemWidth;


-(void)setTitleWithArray:(NSArray *)titleArray;

-(void)setTitleScrollViewOffsetWithPage:(NSInteger)page;

@end
