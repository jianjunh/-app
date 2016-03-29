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
@interface NewsViewController ()<changeArray,setButtonTitle,changeScrollViewOffset,UIScrollViewDelegate>

@property (nonatomic,strong)HeadView *headView;

@property (nonatomic,strong)NSMutableArray *titleArray;

@property (nonatomic,strong)AddTitleViewController *addTitle;

@property (nonatomic,strong)UIView *nightView;

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
-(void)viewWillAppear:(BOOL)animated
{
    if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"status"] boolValue] == YES) {
        self.nightView.backgroundColor = [UIColor blackColor];
        self.nightView.alpha = 0.5;
    }else{
        self.nightView.backgroundColor = [UIColor whiteColor];
        self.nightView.alpha = 0;
    }
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
    
    
    [self addChildViewController:headlines];
    
    [self.baseScrollView addSubview:headlines.view];
    
    [headlines requestWithUrl:@"头条"];
    
    self.nightView = [[UIView alloc]initWithFrame:self.view.bounds];
    
    self.nightView.userInteractionEnabled = NO;
    
    [self.view addSubview:self.nightView];
}


-(void)initHeadView
{
    self.headView.delegate = self;
    
    self.headView.OtherDelegate = self;
    
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


-(void)setButtonTitle:(NSString *)buttonTitle Tag:(NSInteger)tag buttonArray:(NSMutableArray *)buttonArray
{
    if (tag == 1000) {
        return;
    }else{
        self.titleArray = buttonArray;
        CustomButton *btn = [buttonArray objectAtIndex:tag - 1000];
        if (btn.isClick == 0) {
            HeadlinesViewController *headlines = [[HeadlinesViewController alloc]init];
            
            [self addChildViewController:headlines];
            
            
            for (int i = 0; i < self.baseScrollView.contentSize.width; i++) {
                if (i == tag - 1000) {
                    headlines.view.frame = CGRectMake(i * W, 0, W, self.baseScrollView.bounds.size.height);
                    [self.baseScrollView addSubview:headlines.view];
                }
            }
            [headlines requestWithUrl:buttonTitle];
            btn.isClick = 1;
        }else{
            return;
        }

    }
    
    
}

-(void)plusButton:(CustomButton *)sender
{
    self.addTitle.delegate = self;
    self.addTitle.view.hidden = NO;
    
    [UIView animateWithDuration:1. animations:^{
        
        self.addTitle.underView.frame = CGRectMake(0, 44, W, H - 158);
        
        self.addTitle.upButton.frame = CGRectMake(0, H - 114, W, 50);
        
        self.addTitle.headerView.alpha = 1.;
    }];
}


-(void)setOffsetNumber:(NSInteger)page
{
    [self.baseScrollView setContentOffset:CGPointMake(W * page, 0)animated:NO];
}




-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSInteger page = scrollView.contentOffset.x / W;
    [self.headView setTitleScrollViewOffsetWithPage:page];
    
    [self setButtonTitle:[[[NSUserDefaults standardUserDefaults]objectForKey:@"selectedArray"] objectAtIndex:page]  Tag:page + 1000 buttonArray:self.titleArray];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

@end
