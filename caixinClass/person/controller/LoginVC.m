//
//  LoginVC.m
//  Caixin
//
//  Created by gaocaixin on 15/4/27.
//  Copyright (c) 2015年 CX. All rights reserved.
//

#import "LoginVC.h"
#import "MBProgressHUD+MJ.h"

@interface LoginVC ()

- (IBAction)loginBtnClicked:(UIButton *)sender;

- (IBAction)exitLoginBtnClicked:(UIButton *)sender;
- (IBAction)sinaLogoBtnClick:(UIButton *)sender;
- (IBAction)tencentLogoBtnClicked:(UIButton *)sender;
- (IBAction)qqLogoBtnClicked:(UIButton *)sender;

@property (weak, nonatomic) IBOutlet UITextField *countTF;
@property (weak, nonatomic) IBOutlet UITextField *passwordTF;
- (IBAction)weiXinLogoBtnClicked:(UIButton *)sender;

@end

@implementation LoginVC

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (IBAction)loginBtnClicked:(UIButton *)sender {
    
    [MBProgressHUD showError:@"账号密码错误"];
    
    [self loginError];
}

- (void)loginError
{
    CAKeyframeAnimation *key = [CAKeyframeAnimation animation];
    key.keyPath = @"transform.translation.x";
    key.values = @[@0, @-5, @5, @0];
    key.repeatCount = 2;
    key.duration = 0.1;
    [self.countTF.layer addAnimation:key forKey:nil];
    [self.passwordTF.layer addAnimation:key forKey:nil];
}

- (IBAction)exitLoginBtnClicked:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)sinaLogoBtnClick:(UIButton *)sender {
}

- (IBAction)tencentLogoBtnClicked:(UIButton *)sender {
}

- (IBAction)qqLogoBtnClicked:(UIButton *)sender {
}
- (IBAction)weiXinLogoBtnClicked:(UIButton *)sender {
}
@end
