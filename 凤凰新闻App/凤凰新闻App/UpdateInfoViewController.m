//
//  UpdateInfoViewController.m
//  凤凰新闻App
//
//  Created by lanou on 16/3/24.
//  Copyright © 2016年 jianjun. All rights reserved.
//

#import "UpdateInfoViewController.h"
#import "DataBase.h"
#import "loginModel.h"
@interface UpdateInfoViewController ()<UITextFieldDelegate>

@property (nonatomic,strong)DataBase *dataBase;

@end

@implementation UpdateInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.accountLabel.text = [NSString stringWithFormat:@"账号:    %@",self.acceptStr];
    NSLog(@"%@",self.nameStr);
    if (![self.nameStr isEqualToString:@"(null)"]) {
        self.nameTextField.text = self.nameStr;
    }else{
        self.nameTextField.text = @"";
    }
    if (![self.genderStr isEqualToString:@"(null)"]) {
        self.genderTextField.text = self.genderStr;
    }else{
        self.genderTextField.text = @"";
    }
    self.dataBase = [DataBase shareDataBase];
    
    self.nameTextField.delegate = self;
    self.genderTextField.delegate = self;
}
- (IBAction)saveAction:(id)sender
{
    [self.nameTextField resignFirstResponder];
    [self.genderTextField resignFirstResponder];
    [UIView animateWithDuration:0.1 animations:^{
        [self.view setFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
    }];
    NSArray *array = [self.dataBase selectInfo];
    for (loginModel *model in array) {
        if (model.isLogin == 1) {
            [self.dataBase updateName:self.nameTextField.text userName:model.userName];
            [self.dataBase updateGender:self.genderTextField.text userName:model.userName];
            [self.navigationController popViewControllerAnimated:YES];
        }
    }
}

- (IBAction)quitLogin:(id)sender
{
    [self.nameTextField resignFirstResponder];
    [self.genderTextField resignFirstResponder];
    [UIView animateWithDuration:0.1 animations:^{
        [self.view setFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
    }];
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Attention(注意)" message:@"是否要退出当前账户" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        NSArray *array = [self.dataBase selectInfo];
        NSLog(@"%@",array);
        for (loginModel *model in array) {
            if (model.isLogin == 1) {
                [self.dataBase updateLoginStatus:0 userName:model.userName];
                [self.navigationController popViewControllerAnimated:YES];
            }
        }
    }];
    [alert addAction:action1];
    [alert addAction:action2];
    
    [self.navigationController presentViewController:alert animated:YES completion:nil];
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
