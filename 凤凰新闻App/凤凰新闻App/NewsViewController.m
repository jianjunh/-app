//
//  NewsViewController.m
//  凤凰新闻App
//
//  Created by lanou on 16/3/15.
//  Copyright © 2016年 jianjun. All rights reserved.
//

#import "NewsViewController.h"
#import "AddTitleViewController.h"
#import "HeadView.h"
#import "Header.h"
@interface NewsViewController ()

@property (nonatomic,strong)HeadView *headView;

@property (nonatomic,strong)NSMutableArray *titleArray;

@end

@implementation NewsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.navigationController.navigationBarHidden = YES;
    NSArray *array = @[@"历史",@"头条",@"科技",@"美女",@"体育",@"军事",@"房产"];
    self.titleArray = [NSMutableArray arrayWithArray:array];
    
    [self initHeadView];
}


-(HeadView *)headView
{
    if (!_headView) {
        _headView = [[HeadView alloc]initWithFrame:CGRectMake(0, 20, W, 44)];
    }
    return _headView;
}

-(void)initHeadView
{
    [self.view addSubview:self.headView];
    
    [self.headView setTitleWithArray:self.titleArray];
    
    [self.headView.plusButton addTarget:self action:@selector(plusButton:) forControlEvents:UIControlEventTouchUpInside];
    
    
}

-(void)plusButton:(UIButton *)sender
{
    AddTitleViewController *addTitle = [[AddTitleViewController alloc]init];
    
    [self addChildViewController:addTitle];
    
    addTitle.view.hidden = NO;
    
    [self.view addSubview:addTitle.view];
    
    [UIView animateWithDuration:1. animations:^{
        
        addTitle.collectionView.frame = CGRectMake(0, 50, W, H - 164);
        
        addTitle.upButton.frame = CGRectMake(0, H - 114, W, 50);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

@end
