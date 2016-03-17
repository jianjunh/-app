//
//  TitleCollectionViewCell.m
//  凤凰新闻App
//
//  Created by lanou on 16/3/16.
//  Copyright © 2016年 jianjun. All rights reserved.
//

#import "TitleCollectionViewCell.h"

@implementation TitleCollectionViewCell

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _titleLabel = [[UILabel alloc]initWithFrame:self.contentView.bounds];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:_titleLabel];
        self.layer.borderWidth = 1;
        self.layer.cornerRadius = 15.;
        self.layer.borderColor = [[UIColor colorWithRed:240 / 255. green:240 / 255. blue:240 / 255. alpha:1] CGColor];
        self.contentView.backgroundColor = [UIColor whiteColor];
        self.clipsToBounds = YES;
    }
    return self;
}

@end
