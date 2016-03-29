//
//  UpdateInfoViewController.h
//  凤凰新闻App
//
//  Created by lanou on 16/3/24.
//  Copyright © 2016年 jianjun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UpdateInfoViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *accountLabel;
@property (weak, nonatomic) IBOutlet UITextField *genderTextField;

@property (weak, nonatomic) IBOutlet UITextField *nameTextField;

@property (nonatomic,copy)NSString *acceptStr;
@property (nonatomic,copy)NSString *nameStr;
@property (nonatomic,copy)NSString *genderStr;

@end
