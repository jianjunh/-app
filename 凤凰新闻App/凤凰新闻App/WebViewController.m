//
//  WebViewController.m
//  凤凰新闻App
//
//  Created by lanou on 16/3/18.
//  Copyright © 2016年 jianjun. All rights reserved.
//

#import "WebViewController.h"
#import "Header.h"
#import "UMSocialDataService.h"
#import "UMSocial.h"
@interface WebViewController ()<UMSocialUIDelegate>

@end

@implementation WebViewController

-(instancetype)initWithUrlstr:(NSString *)url
{
    if (self) {
        _urlStr = url;
    }
    return self;
}

-(UIWebView *)webView
{
    if (!_webView) {
        
        _webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 20, W, H - 88)];
    }
    return _webView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    NSURL *url = [NSURL URLWithString:self.urlStr];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    [self.webView loadRequest:request];
    
  

    [self.view addSubview:self.webView];
    
    
    UIView *downView = [[UIView alloc]initWithFrame:CGRectMake(0, H - 88, W, 44)];
    downView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:downView];
    
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    backButton.frame = CGRectMake(0, downView.bounds.size.height - 44, 40, 44);
    [backButton setImage:[UIImage imageNamed:@"新向左.png"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
    [downView addSubview:backButton];
    
    UIButton *shareButton = [UIButton buttonWithType:UIButtonTypeCustom];
    shareButton.frame = CGRectMake(W - 60, 0, 60, 44);
    [shareButton setImage:[UIImage imageNamed:@"新分享.png"] forState:UIControlStateNormal];
    [shareButton addTarget:self action:@selector(share:) forControlEvents:UIControlEventTouchUpInside];
    [downView addSubview:shareButton];
    
}

-(void)back:(UIButton *)sender
{
    [self.webView goBack];
    if (![self.webView canGoBack]) {
        
        [self.navigationController popViewControllerAnimated:YES];
    }
    
}

-(void)share:(UIButton *)sender
{
    [UMSocialSnsService presentSnsIconSheetView:self appKey:@"56d80bbb67e58ededb001b7c"                                      shareText:@"凤凰新闻的分享测试，www.umeng.com/social" shareImage:nil shareToSnsNames:@[UMShareToWechatSession,UMShareToWechatTimeline,UMShareToWechatFavorite] delegate:self];
    
    [UMSocialData defaultData].extConfig.wechatSessionData.url = @"http://baidu.com";
    
    [UMSocialData defaultData].extConfig.wechatTimelineData.url = @"http://baidu.com";
    [UMSocialData defaultData].extConfig.wxMessageType = UMSocialWXMessageTypeImage;
    
    
    
    
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
