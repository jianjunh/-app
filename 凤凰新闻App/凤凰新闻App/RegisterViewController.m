//
//  RegisterViewController.m
//  凤凰新闻App
//
//  Created by lanou on 16/3/24.
//  Copyright © 2016年 jianjun. All rights reserved.
//

#import "RegisterViewController.h"
#import "DataBase.h"
@interface RegisterViewController ()<UITextFieldDelegate>
{
    UIAlertController *_alert1;
}
@property (weak, nonatomic) IBOutlet UITextField *userTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UITextField *surePassWord;

@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.userTextField.delegate = self;
    self.passwordTextField.delegate = self;
    self.surePassWord.delegate = self;
}
- (IBAction)registerAction:(id)sender
{
    [self.userTextField resignFirstResponder];
    [self.passwordTextField resignFirstResponder];
    [self.surePassWord resignFirstResponder];
    [UIView animateWithDuration:0.1 animations:^{
        [self.view setFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
    }];
    DataBase *dataBase = [DataBase shareDataBase];
    NSArray *loginArray = [dataBase selectInfo];
    NSLog(@"----%ld",[loginArray count]);
    if ([loginArray count] == 0) {
        [dataBase createTable:@"loginInfomation"];
    }
    for (loginModel *model in loginArray) {
        if ([model.userName isEqualToString:self.userTextField.text]) {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"注意" message:@"此账号已被注册过" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:nil];
            [alert addAction:action];
            [self.navigationController presentViewController:alert animated:YES completion:nil];
            return;
        }
    }
    if (![self.passwordTextField.text isEqualToString:self.surePassWord.text]) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"你好" message:@"两次输入的密码不一样" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:nil];
        [alert addAction:action];

        [self.navigationController presentViewController:alert animated:YES completion:nil];
        return;
    }else{
        loginModel *login = [[loginModel alloc]init];
        login.userName = self.userTextField.text;
        login.password = self.passwordTextField.text;
        login.isLogin = NULL;
        [dataBase insertLoginModel:login];
        
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"你好" message:@"注册成功" preferredStyle:UIAlertControllerStyleAlert];
        __weak typeof(self)bSelf = self;
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
            _alert1 = [UIAlertController alertControllerWithTitle:@"你好" message:@"正在为您跳转" preferredStyle:UIAlertControllerStyleAlert];
            [bSelf.navigationController presentViewController:_alert1 animated:YES completion:nil];
            [bSelf performSelector:@selector(pop) withObject:nil afterDelay:3.];
        }];
        [alert addAction:action];

        [self.navigationController presentViewController:alert animated:YES completion:nil];
    }
                

    
            
}


-(void)pop
{
    [self.navigationController popViewControllerAnimated:YES];
    [_alert1 dismissViewControllerAnimated:YES completion:nil];
}

-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    [UIView animateWithDuration:0.3 animations:^{
        [self.view setFrame:CGRectMake(0, -200, self.view.bounds.size.width, self.view.bounds.size.height)];
    }];
    
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
