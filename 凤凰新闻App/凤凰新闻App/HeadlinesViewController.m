//
//  HeadlinesViewController.m
//  凤凰新闻App
//
//  Created by lanou on 16/3/17.
//  Copyright © 2016年 jianjun. All rights reserved.
//

#import "HeadlinesViewController.h"
#import <AFNetworking.h>
#import "Header.h"
#import "HeadlinesModel.h"
#import <UIImageView+WebCache.h>
#import "OneTableViewCell.h"
#import "WebViewController.h"
#import "HeadView.h"
@interface HeadlinesViewController ()<UITableViewDataSource,UITableViewDelegate,changeScrollViewOffset>
{
    NSMutableArray *_headlinesModelArray;
//    NSMutableArray *_threeImageArray;
}

@property (nonatomic,strong)NSArray *responseObject;

@end

@implementation HeadlinesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _headlinesModelArray = [NSMutableArray array];
    
    
    _titleDic  = [NSDictionary dictionaryWithObjectsAndKeys:HeadLindeURL,@"头条",EntertainmentURL,@"娱乐",ZhiboURL,@"直播",CaijingURL,@"财经",TechnologyURL,@"科技",GirlURL,@"美女",FangchanURL,@"房产",GuoxueURL,@"国学",CommentURL,@"评论",NuanXinwenURL,@"暖新闻",TravelURL,@"旅游",Welfare,@"公益",Bobao,@"博报",nil];
    
    self.tableView.dataSource = self;
    
    self.tableView.delegate = self;
    
    
}

-(void)requestWithUrl:(NSString *)url
{
    NSLog(@"%@",url);
    AFHTTPSessionManager *sessionManager = [AFHTTPSessionManager manager];
    
    NSString *URL = [_titleDic objectForKey:url];
    __weak typeof (self)bSelf = self;
    NSLog(@"%@",URL);
    [sessionManager GET:URL parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        bSelf.responseObject = (NSArray *)responseObject;
        [bSelf setModelWithResponseObject];
        [bSelf.view addSubview:bSelf.tableView];
        NSLog(@"1111111");
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
    
    
}

-(void)setModelWithResponseObject
{
    if (self.responseObject.count != 1){
    
        NSDictionary *focusDic = [self.responseObject objectAtIndex:1];
        NSArray *itemArray = [focusDic objectForKey:@"item"];
        
        self.imageScrollView.contentSize = CGSizeMake(W * [itemArray count], 0);
        
        self.tableView.tableHeaderView = self.imageScrollView;
    for (int i = 0; i < [itemArray count]; i++)                                                                                                                                                                                           {
        NSString *imageStr = [[itemArray objectAtIndex:i] objectForKey:@"thumbnail"];
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(i * W, 0, W, self.imageScrollView.bounds.size.height)];
        [imageView sd_setImageWithURL:[NSURL URLWithString:imageStr]];
        [self.imageScrollView addSubview:imageView];
        
      }
    }
    NSDictionary *commonDic = [self.responseObject objectAtIndex:0];
    NSArray *commonArray = [commonDic objectForKey:@"item"];
    for (NSDictionary *dic in commonArray) {
        if(![[dic objectForKey:@"thumbnail"] isEqualToString:@""]){
            
            HeadlinesModel *headlinesModel = [[HeadlinesModel alloc]initWithDictionary:dic];
            [_headlinesModelArray addObject:headlinesModel];
        }
    }

}
    



-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_headlinesModelArray count];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellid1 = @"cell1";
    OneTableViewCell *cell1 = [tableView dequeueReusableCellWithIdentifier:cellid1];
    if (!cell1) {
        cell1 = [[OneTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid1];
    }
    [cell1 getModel:[_headlinesModelArray objectAtIndex:indexPath.row]];
    return cell1;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
        HeadlinesModel *headlinesModel = [_headlinesModelArray objectAtIndex:indexPath.row];
        WebViewController *web = [[WebViewController alloc]initWithUrlstr:headlinesModel.commentsUrl];
        [self.navigationController pushViewController:web animated:YES];
    
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

