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
    
    
    self.imageScrollView.backgroundColor = [UIColor greenColor];
    
    [self.imageScrollView setBounces:NO];
    
    [self.imageScrollView setPagingEnabled:YES];
    
    [self.imageScrollView setShowsHorizontalScrollIndicator:NO];
    
    self.tableView.tableHeaderView = self.imageScrollView;
    
//    [self.view addSubview:self.tableView];
    
    self.tableView.backgroundColor = [UIColor grayColor];
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
