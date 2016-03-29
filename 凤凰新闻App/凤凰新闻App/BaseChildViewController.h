//
//  BaseChildViewController.h
//  凤凰新闻App
//
//  Created by lanou on 16/3/17.
//  Copyright © 2016年 jianjun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseChildViewController : UIViewController

@property (nonatomic,strong)UIScrollView *imageScrollView;

@property (nonatomic,strong)UILabel *titleLabel;

@property (nonatomic,strong)UITableView *tableView;

@property (nonatomic,strong)UILabel *currentPage;

@property (nonatomic,strong)UILabel *totalPage;

@end
