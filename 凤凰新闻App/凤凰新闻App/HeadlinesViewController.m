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
#import "MJRefreshGifHeader.h"

#import "MJRefreshAutoNormalFooter.h"
@interface HeadlinesViewController ()<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate,changeScrollViewOffset>
{
    NSMutableArray *_headlinesModelArray;
    NSString *_currentUrl;
    UIView *_threeImage;
    NSArray *_itemArray;
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
    
    MJRefreshGifHeader *header = [MJRefreshGifHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    // 设置普通状态的动画图片
    NSMutableArray *idleImages = [NSMutableArray array];
    for (int i = 1; i < 8; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"huoju_%d.tiff",i]];
        [idleImages addObject:image];
        NSLog(@"%ld",[idleImages count]);
    }

    // 设置正在刷新状态的动画图片
    [header setImages:idleImages forState:MJRefreshStateRefreshing];
    // 设置header
    self.tableView.mj_header = header;
    
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    
    self.imageScrollView.delegate = self;
    _threeImage = [[UIView alloc]initWithFrame:CGRectMake(0, 0, W, 180)];
    [_threeImage addSubview:self.imageScrollView];
}

-(void)requestWithUrl:(NSString *)url
{
    
    NSString *URL = [_titleDic objectForKey:url];
    
    [self UrlRequest:URL];
}
//因为需求问题,这个才是真正的网址,上面那个是名字而已
-(void)UrlRequest:(NSString *)URL
{
    _currentUrl = URL;

    __weak typeof (self)bSelf = self;
    AFHTTPSessionManager *sessionManager = [AFHTTPSessionManager manager];
    [sessionManager GET:URL parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        bSelf.responseObject = (NSArray *)responseObject;
        [bSelf setModelWithResponseObject];
        [bSelf.view addSubview:bSelf.tableView];
        if (self.responseObject.count != 1){
            NSDictionary *focusDic = [bSelf.responseObject objectAtIndex:1];
            NSArray *itemArray = [focusDic objectForKey:@"item"];
            _itemArray = itemArray;
            self.titleLabel.text = [[itemArray objectAtIndex:0]objectForKey:@"title"];
            self.currentPage.text = @"1";
        }
        
        
        [_threeImage addSubview:self.titleLabel];
        
        
        [_threeImage addSubview:self.currentPage];

        [_threeImage addSubview:self.totalPage];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
    
    
}

-(void)setModelWithResponseObject
{
    NSLog(@"%ld",[self.responseObject count]);
    if (self.responseObject.count != 1){
    
        NSDictionary *focusDic = [self.responseObject objectAtIndex:1];
        NSArray *itemArray = [focusDic objectForKey:@"item"];
        
        self.imageScrollView.contentSize = CGSizeMake(W * [itemArray count], 0);
        
        self.tableView.tableHeaderView = _threeImage;
        for (int i = 0; i < [itemArray count]; i++)                                                                                                                                                                                           {
            NSString *imageStr = [[itemArray objectAtIndex:i] objectForKey:@"thumbnail"];
            UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(i * W, 0, W, self.imageScrollView.bounds.size.height)];
            [imageView sd_setImageWithURL:[NSURL URLWithString:imageStr]];
            [self.imageScrollView addSubview:imageView];
            
            UIButton *imageButton = [UIButton buttonWithType:UIButtonTypeCustom];
            imageButton.frame = imageView.frame;
            imageButton.tag = 10000 + i;
            [imageButton addTarget:self action:@selector(imageButton:) forControlEvents:UIControlEventTouchUpInside];
            [self.imageScrollView addSubview:imageButton];
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
    NSLog(@"%ld",[_headlinesModelArray count]);
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

-(void)loadNewData
{
    
    NSInteger currentPage = [[_currentUrl substringFromIndex:([_currentUrl length] - 1)] integerValue];
    if (currentPage - 1 == 0) {
        currentPage = 2;
    }
   _currentUrl = [[_currentUrl substringToIndex:([_currentUrl length] - 1)] stringByAppendingString:[NSString stringWithFormat:@"%ld",(currentPage - 1)]];
    
    [self UrlRequest:_currentUrl];
    [self performSelector:@selector(endRefreshing) withObject:nil afterDelay:1.5];
    
    }
-(void)endRefreshing
{
    [self.tableView.mj_header endRefreshing];
    [self.tableView.mj_footer endRefreshing];

}

-(void)loadMoreData
{
    NSInteger currentPage = [[_currentUrl substringFromIndex:([_currentUrl length] - 1)] integerValue];
    NSLog(@"页数%ld",currentPage);
    _currentUrl = [[_currentUrl substringToIndex:([_currentUrl length] - 1)] stringByAppendingString:[NSString stringWithFormat:@"%ld",(currentPage + 1)]];
    
    [self UrlRequest:_currentUrl];
    [self.tableView reloadData];
    [self performSelector:@selector(endRefreshing) withObject:nil afterDelay:1.5];
    
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    int page = self.imageScrollView.contentOffset.x / W;
    if(scrollView == self.imageScrollView){
        
        self.titleLabel.text = [[_itemArray objectAtIndex:page]objectForKey:@"title"];
        self.currentPage.text = [NSString stringWithFormat:@"%d",(page + 1)];
        
    }
}

-(void)imageButton:(UIButton *)sender
{
    NSString *commentsUrl = [[_itemArray objectAtIndex:(sender.tag - 10000)] objectForKey:@"commentsUrl"];
    WebViewController *web = [[WebViewController alloc]initWithUrlstr:commentsUrl];
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

