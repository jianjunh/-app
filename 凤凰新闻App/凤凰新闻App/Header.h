//
//  Header.h
//  凤凰新闻App
//
//  Created by lanou on 16/3/15.
//  Copyright © 2016年 jianjun. All rights reserved.
//

#ifndef Header_h
#define Header_h
#import <Foundation/Foundation.h>

#define W [UIScreen mainScreen].bounds.size.width
#define H [UIScreen mainScreen].bounds.size.height
#define RGBA(r, g, b, a) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]

#define HeadLindeURL @"http://api.iclient.ifeng.com/ClientNews?id=SYLB10,SYDT10,SYRECOMMEND&page=1"
#define EntertainmentURL @"http://api.iclient.ifeng.com/ClientNews?id=YL53,FOCUSYL53&page=1"
#define ZhiboURL @"http://api.iclient.ifeng.com/ClientNews?id=ZBPD&page=1"
#define CaijingURL  @"http://api.iclient.ifeng.com/ClientNews?id=CJ33,FOCUSCJ33,HNCJ33&page=1"
#define TechnologyURL @"http://api.iclient.ifeng.com/ClientNews?id=KJ123,FOCUSKJ123&page=1"
#define GirlURL @"http://api.3g.ifeng.com/clientShortNews?type=beauty&page=1"
#define FangchanURL @"http://api.iclient.ifeng.com/ClientNews?id=FC81,FOCUSFC81&page=1"
#define GuoxueURL @"http://api.iclient.ifeng.com/ClientNews?id=GXPD&page=1"
#define CommentURL @"http://api.iclient.ifeng.com/ClientNews?id=PL40,FOCUSPL40&page=1"
#define NuanXinwenURL @"http://api.iclient.ifeng.com/ClientNews?id=NXWPD,FOCUSNXWPD&page=1"
#define TravelURL @"http://api.iclient.ifeng.com/ClientNews?id=LY67,FOCUSLY67&page=1"
#define Welfare @"http://api.iclient.ifeng.com/ClientNews?id=GYPD&page=1"
#define Bobao @"http://api.iclient.ifeng.com/ClientNews?id=BB10,FOCUSBB10&page=1"

#endif /* Header_h */
