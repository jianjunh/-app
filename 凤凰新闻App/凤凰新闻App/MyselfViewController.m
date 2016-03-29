//
//  MyselfViewController.m
//  凤凰新闻App
//
//  Created by lanou on 16/3/23.
//  Copyright © 2016年 jianjun. All rights reserved.
//

#import "MyselfViewController.h"
#import "LoginViewController.h"
#import "DataBase.h"
#import "UpdateInfoViewController.h"
@interface MyselfViewController ()
{
    NSArray *_loginArray;
}
@property (weak, nonatomic) IBOutlet UIButton *headButton;
@property (weak, nonatomic) IBOutlet UIButton *commentButton;
@property (weak, nonatomic) IBOutlet UIButton *messageButton;
@property (weak, nonatomic) IBOutlet UIButton *collectButton;
@property (weak, nonatomic) IBOutlet UIButton *storeButton;
@property (weak, nonatomic) IBOutlet UIButton *settingButton;
@property (weak, nonatomic) IBOutlet UISwitch *Aswitch;

@property (weak, nonatomic) IBOutlet UIView *nightView;
@property (weak, nonatomic) IBOutlet UILabel *isLoginLabel;

@end

@implementation MyselfViewController

-(void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBarHidden = YES;

    NSLog(@"%d",[[[NSUserDefaults standardUserDefaults]objectForKey:@"status"] boolValue]);
    if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"status"] boolValue] == YES) {
        self.Aswitch.on = YES;
        self.nightView.backgroundColor = [UIColor blackColor];
        self.nightView.alpha = 0.5;
    }else{
        self.Aswitch.on = NO;
        self.nightView.backgroundColor = [UIColor whiteColor];
        self.nightView.alpha = 0;
    }
    
    DataBase *dataBase = [DataBase shareDataBase];
    _loginArray = [dataBase selectInfo];
    NSLog(@"%ld",[_loginArray count]);
    for (loginModel *login in _loginArray) {
        if (login.isLogin == 1) {
            self.isLoginLabel.text = @"已登录";
        }else{
            self.isLoginLabel.text = @"立即登录";
        }
    }

}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.Aswitch addTarget:self action:@selector(status:) forControlEvents:UIControlEventValueChanged];
    
    
    self.nightView.userInteractionEnabled = NO;
    

}

-(void)status:(UISwitch *)sender
{
    BOOL status = YES;
    if (sender.on == YES) {
        status = YES;
        self.nightView.backgroundColor = [UIColor blackColor];
        self.nightView.alpha = 0.5;
    }else{
        status = NO;
        self.nightView.backgroundColor = [UIColor whiteColor];
        self.nightView.alpha = 0;
    }
    [[NSUserDefaults standardUserDefaults]setObject:[NSNumber numberWithBool:status] forKey:@"status"];
    NSLog(@"%d",[[[NSUserDefaults standardUserDefaults]objectForKey:@"status"] boolValue]);
}
//选中头像
- (IBAction)headAction:(id)sender
{
    for (loginModel *login in _loginArray) {
        if (login.isLogin == 1) {
            UpdateInfoViewController *updateInfo = [[UpdateInfoViewController alloc]init];
            updateInfo.acceptStr = login.userName;
            updateInfo.nameStr = login.name;
            updateInfo.genderStr = login.gender;
            [self.navigationController pushViewController:updateInfo animated:YES];
            return;
        }
    }
    LoginViewController *login = [[LoginViewController alloc]init];
    [self.navigationController pushViewController:login animated:YES];
}
//选中评论
- (IBAction)commentAction:(id)sender
{
    
}
//选中消息
- (IBAction)messageAction:(id)sender
{
    
}
//选中收藏
- (IBAction)collectAction:(id)sender
{
    
}
//选中商城
- (IBAction)storeAction:(id)sender
{
    
}
//选中夜间开关
- (IBAction)settingAction:(id)sender
{
    
}
//选中设置
- (IBAction)switchAction:(id)sender
{
    
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
