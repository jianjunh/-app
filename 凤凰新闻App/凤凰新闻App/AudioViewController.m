//
//  AudioViewController.m
//  凤凰新闻App
//
//  Created by lanou on 16/3/15.
//  Copyright © 2016年 jianjun. All rights reserved.
//

#import "AudioViewController.h"
#import "CustomButton.h"
@interface AudioViewController ()

@property (nonatomic,strong)UIView *underLine;

@end

@implementation AudioViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    
    
    
    
}

-(void)initWithHeaderView
{
    self.headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 160, 44)];
    self.headerView.backgroundColor = [UIColor grayColor];
    self.navigationItem.titleView = self.headerView;
    CGFloat _itemWidth = self.headerView.bounds.size.width / 2;
    
    NSArray *titleArray = @[@"视频",@"音频"];
    for (int i = 0; i < 2; i++) {
        
        CustomButton *titleButton = [CustomButton buttonWithType:UIButtonTypeCustom];
        
        titleButton.frame = CGRectMake(i * _itemWidth, 0, _itemWidth, 44);
        
        [titleButton setTitle:[titleArray objectAtIndex:i] forState:UIControlStateNormal];
        [titleButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        
        [titleButton setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
        
        [titleButton addTarget:self action:@selector(titleButton:) forControlEvents:UIControlEventTouchUpInside];
        
        titleButton.tag = 10000 + i;
        
        if (titleButton.tag == 10000) {
            titleButton.selected = YES;
            
        }
        
        [self.headerView addSubview:titleButton];
    }
    _underLine = [[UIView alloc]initWithFrame:CGRectMake(0, 42, _itemWidth, 2)];
    
    _underLine.backgroundColor = [UIColor redColor];
    
    

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
