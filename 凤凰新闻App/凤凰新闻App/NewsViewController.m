//
//  NewsViewController.m
//  凤凰新闻App
//
//  Created by lanou on 16/3/15.
//  Copyright © 2016年 jianjun. All rights reserved.
//

#import "NewsViewController.h"
#import "AddTitleViewController.h"
#import "HeadlinesViewController.h"
#import "HeadView.h"
#import "Header.h"
@interface NewsViewController ()<changeArray,changeScrollViewOffset,UIScrollViewDelegate>

@property (nonatomic,strong)HeadView *headView;

@property (nonatomic,strong)NSMutableArray *titleArray;

@property (nonatomic,strong)AddTitleViewController *addTitle;

@end

@implementation NewsViewController



-(HeadView *)headView
{
    if (!_headView) {
        _headView = [[HeadView alloc]initWithFrame:CGRectMake(0, 20, W, 44)];
    }
    
    return _headView;
}

-(UIScrollView *)baseScrollView
{
    if (!_baseScrollView) {
        _baseScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 64, W, H - 108)];
    }
    return _baseScrollView;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.navigationController.navigationBarHidden = YES;
    
    
    
    
    [self initHeadView];
    
    
    
    self.baseScrollView.pagingEnabled = YES;
    
    [self.baseScrollView setBounces:NO];
    
    self.baseScrollView.delegate = self;
    
    [self.view insertSubview:self.baseScrollView belowSubview:self.addTitle.view];

    HeadlinesViewController *headlines = [[HeadlinesViewController alloc] init];
    
    headlines.headView = self.headView;
    
    [self addChildViewController:headlines];
    
    [self.baseScrollView addSubview:headlines.view];
    
}


-(void)initHeadView
{
    self.headView.delegate = self;
    
    [self.view addSubview:self.headView];
    
    self.addTitle = [[AddTitleViewController alloc]init];
    
    [self addChildViewController:self.addTitle];
    
    self.addTitle.view.hidden = YES;
    
    [self.view addSubview:self.addTitle.view];
    
    

    [self changeArray];
    
    [self.headView.plusButton addTarget:self action:@selector(plusButton:) forControlEvents:UIControlEventTouchUpInside];
    
    
}


//自定义代理方法
-(void)changeArray
{
    [self.headView setTitleWithArray:[[NSUserDefaults standardUserDefaults] valueForKey:@"selectedArray"]];
    
    self.baseScrollView.contentSize = CGSizeMake(W * [[[NSUserDefaults standardUserDefaults] valueForKey:@"selectedArray"] count], 0);
}

-(void)plusButton:(UIButton *)sender
{
    self.addTitle.delegate = self;
    self.addTitle.view.hidden = NO;
    
    [UIView animateWithDuration:1. animations:^{
        
        self.addTitle.collectionView.frame = CGRectMake(0, 44, W, H - 158);
        
        self.addTitle.upButton.frame = CGRectMake(0, H - 114, W, 50);
        
        self.addTitle.headerView.alpha = 1.;
    }];
}


-(void)setOffsetNumber:(NSInteger)page
{
    [self.baseScrollView setContentOffset:CGPointMake(W * page, 0)animated:NO];
}


-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    NSInteger page = scrollView.contentOffset.x / W;
    [self.headView setTitleScrollViewOffsetWithPage:page];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

@end
