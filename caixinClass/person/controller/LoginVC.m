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
@property (weak, nonatomic) IBOutlet UIButton *weiXinLogoBtnClicked;
@property (weak, nonatomic) IBOutlet UITextField *countTF;
@property (weak, nonatomic) IBOutlet UITextField *passwordTF;

@end

@implementation LoginVC

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (IBAction)loginBtnClicked:(UIButton *)sender {
    [MBProgressHUD showError:@"服务器尚未开放"];
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
@end
