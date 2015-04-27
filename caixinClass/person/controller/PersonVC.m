//
//  PersonVC.m
//  Caixin
//
//  Created by gaocaixin on 15/4/26.
//  Copyright (c) 2015年 CX. All rights reserved.
//

#import "PersonVC.h"
#import "MBProgressHUD+MJ.h"
#import "LoginVC.h"
#import "SettingVC.h"
#import "ChannelSettingVC.h"

@interface PersonVC ()

@property (weak, nonatomic) IBOutlet UIButton *userBtn;
@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;
@property (weak, nonatomic) IBOutlet UIButton *customBtn;

@property (weak, nonatomic) IBOutlet UIButton *subscribeBtn;
@property (weak, nonatomic) IBOutlet UIButton *settingBtn;
@property (weak, nonatomic) IBOutlet UIButton *collectionBtn;
@property (weak, nonatomic) IBOutlet UIButton *attentionBtn;
@property (weak, nonatomic) IBOutlet UIButton *commentBtn;
@property (weak, nonatomic) IBOutlet UIButton *loadingBtn;
@property (weak, nonatomic) IBOutlet UIButton *cleanBtn;
@property (weak, nonatomic) IBOutlet UIButton *searchBtn;
@property (weak, nonatomic) IBOutlet UILabel *filesizeLabel;
- (IBAction)userBtnClicked:(UIButton *)sender;
- (IBAction)loadBtnClicked:(UIButton *)sender;
- (IBAction)clearBtnClicked:(UIButton *)sender;
- (IBAction)searchBtnClicked:(UIButton *)sender;
- (IBAction)customBtnClicked:(UIButton *)sender;
- (IBAction)subscribeBtnClicked:(UIButton *)sender;
- (IBAction)settingBtnClicked:(UIButton *)sender;
- (IBAction)collectionBtnClicked:(UIButton *)sender;
- (IBAction)attentionBtnClicked:(UIButton *)sender;
- (IBAction)commentBtnClicked:(UIButton *)sender;

@end

@implementation PersonVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpNav];
    
    // 计算缓存
    [self filesize];
}
// 计算缓存大小
- (void)filesize
{
    NSFileManager *mgr = [NSFileManager defaultManager];
    NSString *cachePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
//    NSLog(@"%@", cachePath);
// 获得缓存文件总大小
// 获得所有的子路径
        NSArray *subArr = [mgr subpathsAtPath:cachePath];
        long long size = 0;
        for (NSString *subPath in subArr) {
            NSString *fullPath = [cachePath stringByAppendingPathComponent:subPath];
            BOOL dir = NO;
            [mgr fileExistsAtPath:fullPath isDirectory:&dir];
            if (dir == 0) {
                size += [[mgr attributesOfItemAtPath:fullPath error:nil][NSFileSize] longLongValue];
            }
        }
    CGFloat sizeMB = size/1000/1000.0;
    self.filesizeLabel.text = [NSString stringWithFormat:@"%.2lfMB", sizeMB];
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
    [self.navigationController.navigationBar.subviews[0] setHidden:NO];
}

- (void)isNeedLogin
{
    //没有登录
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    if ([user objectForKey:@"isLogin"] == nil) {
        LoginVC *vc = [[LoginVC alloc] init];
        [self presentViewController:vc animated:YES completion:nil];
    }
}

- (IBAction)userBtnClicked:(UIButton *)sender {
    [self isNeedLogin];
}

- (IBAction)loadBtnClicked:(UIButton *)sender {
}

- (IBAction)clearBtnClicked:(UIButton *)sender {
    // 清除缓存
    NSFileManager *mgr = [NSFileManager defaultManager];
    // 主cache路径
    NSString *cachePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
    
    NSArray *subArr = [mgr subpathsAtPath:cachePath];
    // 找到所有文件和文件夹
    for (NSString *subPath in subArr) {
        // 拼接全路径
        NSString *fullPath = [cachePath stringByAppendingPathComponent:subPath];
        [mgr removeItemAtPath:fullPath error:nil];
    }
    
    [MBProgressHUD showSuccess:[NSString stringWithFormat:@"所有缓冲清空啦"]];
    
    self.filesizeLabel.text = @"0MB";
}

- (IBAction)searchBtnClicked:(UIButton *)sender {
}

- (IBAction)customBtnClicked:(UIButton *)sender {
    [self.navigationController pushViewController:[[ChannelSettingVC alloc] init] animated:YES];
}

- (IBAction)subscribeBtnClicked:(UIButton *)sender {
}

- (IBAction)settingBtnClicked:(UIButton *)sender {
    SettingVC *vc = [[SettingVC alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)collectionBtnClicked:(UIButton *)sender {
}

- (IBAction)attentionBtnClicked:(UIButton *)sender {
    [self isNeedLogin];
}

- (IBAction)commentBtnClicked:(UIButton *)sender {
    [self isNeedLogin];
}
@end
