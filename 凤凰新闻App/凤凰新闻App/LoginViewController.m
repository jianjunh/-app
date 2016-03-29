//
//  LoginViewController.m
//  凤凰新闻App
//
//  Created by lanou on 16/3/23.
//  Copyright © 2016年 jianjun. All rights reserved.
//

#import "LoginViewController.h"
#import "RegisterViewController.h"
#import "DataBase.h"
@interface LoginViewController ()

@property (nonatomic,strong)UIView *nightView;
@property (weak, nonatomic) IBOutlet UITextField *userTextField;
@property (weak, nonatomic) IBOutlet UITextField *password;

@end

@implementation LoginViewController
-(void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBarHidden = NO;
    
    NSLog(@"%d",[[[NSUserDefaults standardUserDefaults]objectForKey:@"status"] boolValue]);
    if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"status"] boolValue] == YES) {
        self.nightView.backgroundColor = [UIColor blackColor];
        self.nightView.alpha = 0.5;
    }else{
        self.nightView.backgroundColor = [UIColor whiteColor];
        self.nightView.alpha = 0;
    }
    
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBarHidden = NO;
    self.navigationItem.title = @"登录";
    
    self.nightView = [[UIView alloc]initWithFrame:self.view.bounds];
    
    self.nightView.userInteractionEnabled = NO;
    
    [self.view addSubview:self.nightView];
}
- (IBAction)registerAction:(id)sender
{
    RegisterViewController *registerVC = [[RegisterViewController alloc]init];
    [self.navigationController pushViewController:registerVC animated:YES];
}
- (IBAction)loginAction:(id)sender
{
    [self.userTextField resignFirstResponder];
    [self.password resignFirstResponder];
    DataBase *dataBase = [DataBase shareDataBase];
    NSArray *loginArray = [dataBase selectInfo];
    NSLog(@"-------------%ld",[loginArray count]);
    for (loginModel *login in loginArray) {
        NSLog(@"%@",login.userName);
        if ([self.userTextField.text isEqualToString:login.userName]) {
            if (![self.password.text isEqualToString:login.password]) {
                 UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:@"密码错误" preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:nil];
                [alert addAction:action];
                [self.navigationController presentViewController:alert animated:YES completion:nil];
                return;
            }else{
                [dataBase updateLoginStatus:1 userName:login.userName];
                UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:@"登录成功" preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
                    [self.navigationController popViewControllerAnimated:YES];
                }];
                [alert addAction:action];
                [self.navigationController presentViewController:alert animated:YES completion:nil];
                return;
            }
        }
    }
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:@"账号不存在" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:nil];
        [alert addAction:action];
        [self.navigationController presentViewController:alert animated:YES completion:nil];
    
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
