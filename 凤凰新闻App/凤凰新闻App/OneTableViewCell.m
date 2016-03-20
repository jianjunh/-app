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
        
        _timeLabel = [[UILabel alloc]initWithFrame:CGRectMake(110, 70, 90, 20)];
        _timeLabel.textAlignment = NSTextAlignmentLeft;
        
        [self.contentView addSubview:_timeLabel];
        
        _commentLabel = [[UILabel alloc]initWithFrame:CGRectMake(W - 100, 70, 70, 20)];
        
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
    if ([headlinesModel.type isEqualToString:@"text_live"]) {
        self.commentImageView.hidden = YES;
        if ([[headlinesModel.liveExt objectForKey:@"status"] isEqualToString:@"2"]) {
            self.timeLabel.text = @"直播中";
            self.timeLabel.textColor = [UIColor redColor];
        }else{
            self.timeLabel.textColor = [UIColor grayColor];
            self.timeLabel.text = @"直播已结束";
        }
    }else if([headlinesModel.type isEqualToString:@"topic2"]){
        self.timeLabel.text = @"专题";
        self.timeLabel.frame = CGRectMake(110, 70, 35, 20);
        self.timeLabel.textColor = [UIColor whiteColor];
        self.timeLabel.backgroundColor = [UIColor redColor];
    }else {
        self.commentImageView.hidden = NO;
        self.timeLabel.text = [headlinesModel.updateTime substringWithRange:NSMakeRange(11, 5)];
        self.timeLabel.textColor = [UIColor blackColor];
        self.timeLabel.backgroundColor = [UIColor whiteColor];
        self.timeLabel.frame = CGRectMake(110, 70, 90, 20);
    }
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
