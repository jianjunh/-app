//
//  OneTableViewCell.m
//  凤凰新闻App
//
//  Created by lanou on 16/3/18.
//  Copyright © 2016年 jianjun. All rights reserved.
//

#import "OneTableViewCell.h"
#import "Header.h"
#import <UIImageView+WebCache.h>
@implementation OneTableViewCell


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _ImageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 90, 80)];
        
        [self.contentView addSubview:_ImageView];
        
        _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(110, 0, W - 130, 60)];
        
        _titleLabel.numberOfLines = 2;
        
        [self.contentView addSubview:_titleLabel];
        
        _timeLabel = [[UILabel alloc]initWithFrame:CGRectMake(110, 70, 50, 20)];
        
        [self.contentView addSubview:_timeLabel];
        
        _commentLabel = [[UILabel alloc]initWithFrame:CGRectMake(W - 80, 70, 50, 20)];
        
        _commentLabel.textAlignment = NSTextAlignmentRight;
        
        [self.contentView addSubview:_commentLabel];
        
        _commentImageView = [[UIImageView alloc]initWithFrame:CGRectMake(W - 30, 70, 20, 20)];
        [_commentImageView setImage:[UIImage imageNamed:@"新评论.png"]];
        
        [self.contentView addSubview:_commentImageView];
    }
    return self;
}

-(void)getModel:(HeadlinesModel *)headlinesModel
{
    [self.ImageView sd_setImageWithURL:[NSURL URLWithString:headlinesModel.thumbnail]];
    
    self.titleLabel.text = headlinesModel.title;
    
    self.timeLabel.text = [headlinesModel.updateTime substringWithRange:NSMakeRange(11, 5)];
    
    self.commentLabel.text = headlinesModel.commentsall;
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
