//
//  SettingVC.m
//  Caixin
//
//  Created by gaocaixin on 15/4/27.
//  Copyright (c) 2015年 CX. All rights reserved.
//

#import "SettingVC.h"

@interface SettingVC ()
@property (weak, nonatomic) IBOutlet UIImageView *userImageView;
- (IBAction)sizeBtnClicked:(UIButton *)sender;

- (IBAction)loadImageSwitch:(UISwitch *)sender;
- (IBAction)pushSwitch:(UISwitch *)sender;
- (IBAction)huodongBtnClicked:(UIButton *)sender;
- (IBAction)tuijianBtnClicked:(UIButton *)sender;
- (IBAction)pinjiaBtnClicked:(UIButton *)sender;
- (IBAction)yijianBtnClicked:(UIButton *)sender;
- (IBAction)guanyuBtnClicked:(UIButton *)sender;

@property (nonatomic ,weak) UIButton *tempBtn;

@end

@implementation SettingVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpNav];
}

// 设置导航栏
- (void)setUpNav
{
    UIButton *backBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
    [backBtn setImage:[UIImage imageNamed:@"left_arrow"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(popViewC) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
    self.navigationItem.leftBarButtonItem = item;
}
// 返回按钮触发事件
- (void)popViewC
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)sizeBtnClicked:(UIButton *)sender {
    self.tempBtn.selected = NO;
    sender.selected = YES;
    self.tempBtn = sender;
}

- (IBAction)loadImageSwitch:(UISwitch *)sender {
}

- (IBAction)pushSwitch:(UISwitch *)sender {
}

- (IBAction)huodongBtnClicked:(UIButton *)sender {
}

- (IBAction)tuijianBtnClicked:(UIButton *)sender {
}

- (IBAction)pinjiaBtnClicked:(UIButton *)sender {
}

- (IBAction)yijianBtnClicked:(UIButton *)sender {
}

- (IBAction)guanyuBtnClicked:(UIButton *)sender {
}
@end
