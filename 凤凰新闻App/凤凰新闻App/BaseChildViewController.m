//
//  BaseChildViewController.m
//  凤凰新闻App
//
//  Created by lanou on 16/3/17.
//  Copyright © 2016年 jianjun. All rights reserved.
//

#import "BaseChildViewController.h"
#import "Header.h"
@interface BaseChildViewController ()

@end

@implementation BaseChildViewController

-(UIScrollView *)imageScrollView
{
    if (!_imageScrollView) {
        _imageScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0,0, W, 180)];
        
        
    }
    return _imageScrollView;
}

-(UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, W, H - 114)];
    }
    return _tableView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
 
    [self.imageScrollView setBounces:NO];
    
    [self.imageScrollView setPagingEnabled:YES];
    
    [self.imageScrollView setShowsHorizontalScrollIndicator:NO];
    
    _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 150, 300, 20)];
    
    _titleLabel.textColor = [UIColor whiteColor];
    
    _currentPage = [[UILabel alloc]initWithFrame:CGRectMake(W - 40, 150, 10, 20)];
    
    _currentPage.textColor = [UIColor redColor];
    
    _totalPage = [[UILabel alloc]initWithFrame:CGRectMake(W - 30, 150, 20, 20)];
    _totalPage.text = @"/3";
    _totalPage.textColor = [UIColor whiteColor];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
