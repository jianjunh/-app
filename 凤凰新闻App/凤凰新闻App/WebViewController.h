//
//  WebViewController.h
//  凤凰新闻App
//
//  Created by lanou on 16/3/18.
//  Copyright © 2016年 jianjun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WebViewController : UIViewController

@property (nonatomic,strong)UIWebView *webView;

@property (nonatomic,strong)NSString *urlStr;

-(instancetype)initWithUrlstr:(NSString *)url;
@end
