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
@property (weak, nonatomic) IBOutlet UIButton *smallSizeBtn;
@property (weak, nonatomic) IBOutlet UIButton *middleSizeBtn;
@property (weak, nonatomic) IBOutlet UIButton *bigSizeBtn;
@property (weak, nonatomic) IBOutlet UISwitch *loadImage;
@property (weak, nonatomic) IBOutlet UISwitch *pushSwitch;

@end

@implementation SettingVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpNav];
    
    [self setUp];
}
// 加载时初始化数据
- (void)setUp
{
    // 设置正文大小btn
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    // 没有 默认点击中
    if ([user objectForKey:TEXT_SIZE] == nil) {
        [self sizeBtnClicked:self.middleSizeBtn];
    }
    // 点击btn
    if ([[user objectForKey:TEXT_SIZE] doubleValue] == 80) {
        [self sizeBtnClicked:self.smallSizeBtn];
    } else if ([[user objectForKey:TEXT_SIZE] doubleValue] == 120) {
        [self sizeBtnClicked:self.bigSizeBtn];
    } else {
        [self sizeBtnClicked:self.middleSizeBtn];
    }
    
    [self.loadImage setOn:[user boolForKey:LOADIMAGE] animated:NO];
    [self.pushSwitch setOn:[user boolForKey:PUSH_SWITCH] animated:NO];
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
    
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    
    if ([sender.titleLabel.text isEqualToString:@"小"]) {
        [user setObject:@80 forKey:TEXT_SIZE];
    } else if ([sender.titleLabel.text isEqualToString:@"中"]) {
        [user setObject:@100 forKey:TEXT_SIZE];
    } else if ([sender.titleLabel.text isEqualToString:@"大"]) {
        [user setObject:@120 forKey:TEXT_SIZE];
    }
    
    [user synchronize];
}

- (IBAction)loadImageSwitch:(UISwitch *)sender {
    
    [[NSUserDefaults standardUserDefaults] setBool:sender.on forKey:LOADIMAGE];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (IBAction)pushSwitch:(UISwitch *)sender {
    [[NSUserDefaults standardUserDefaults] setBool:sender.on forKey:PUSH_SWITCH];
    [[NSUserDefaults standardUserDefaults] synchronize];
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
