//
//  OneTableViewCell.h
//  凤凰新闻App
//
//  Created by lanou on 16/3/18.
//  Copyright © 2016年 jianjun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HeadlinesModel.h"
@interface OneTableViewCell : UITableViewCell

@property (nonatomic,strong)UIImageView *ImageView;

@property (nonatomic,strong)UILabel *titleLabel;

@property (nonatomic,strong)UILabel *timeLabel;

@property (nonatomic,strong)UILabel *commentLabel;

@property (nonatomic,strong)UIImageView *commentImageView;


-(void)getModel:(HeadlinesModel *)headlinesModel;
@end
