//
//  ChannelSettingVC.m
//  Caixin
//
//  Created by gaocaixin on 15/4/27.
//  Copyright (c) 2015年 CX. All rights reserved.
//

#import "ChannelSettingVC.h"
#import "ChannelBtn.h"


#define BTN_INTERVAL 10
#define BTN_WIDTH (SCREEN_WIDTH - BTN_INTERVAL * 3)/2
#define BTN_HEIGHT 30

@interface ChannelSettingVC ()
@property (weak, nonatomic) IBOutlet UILabel *channelsLabel;
@property (weak, nonatomic) IBOutlet UIButton *lastBtn;

@property (nonatomic ,strong) NSMutableArray *myChannels;
@property (nonatomic ,strong) NSMutableArray *channels;

@property (nonatomic ,strong) NSMutableArray *myChannelsBtn;
@property (nonatomic ,strong) NSMutableArray *channelsBtn;

@end

@implementation ChannelSettingVC

- (NSMutableArray *)channelsBtn
{
    if (_channelsBtn == nil) {
        _channelsBtn = [[NSMutableArray  alloc] init];
    }
    return _channelsBtn;
}
- (NSMutableArray *)myChannelsBtn
{
    if (_myChannelsBtn == nil) {
        _myChannelsBtn = [[NSMutableArray alloc] init];
    }
    return _myChannelsBtn;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // 获取数据
    [self channelsData];
    // 创建frame
    [self createmyChannelsBtn];
    [self createChannelsBtn];
    
    [self refreshFrame];
}
// 获取数据
- (void)channelsData
{
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    // 是否已存进数据
    NSString * myChannels = [user objectForKey:@"myChannels"];
     NSString * channels = [user objectForKey:@"channels"];
    // 获得数据
    if (myChannels) {
        NSArray *arr = [myChannels componentsSeparatedByString:@" "];
        self.myChannels = [[NSMutableArray alloc] initWithArray:arr];
    } else {
        self.myChannels = [[NSMutableArray alloc] initWithObjects:@"金融",@"公司",@"世界",@"视频",@"图片",@"博客",@"观点",@"文化",@"政经",@"经济", nil];
    }
    
    if (channels) {
        NSArray *arr = [myChannels componentsSeparatedByString:@" "];
        self.channels = [[NSMutableArray alloc] initWithArray:arr];
    } else {
        self.channels = [[NSMutableArray alloc] init];
    }
}
// 创建上面的btn
- (void)createmyChannelsBtn
{
    for (int i = 0; i < self.myChannels.count + self.channels.count; i ++ ) {
        CGFloat W = BTN_WIDTH;
        CGFloat H = BTN_HEIGHT;
        CGFloat X;
        CGFloat Y;
        if (i % 2 == 0) {
            X = BTN_WIDTH + 2*BTN_INTERVAL;
            Y = i/2 * (H + BTN_INTERVAL) + CGRectGetMinY(self.lastBtn.frame);
        } else {
            X = BTN_INTERVAL;
            Y = i/2 * (H + BTN_INTERVAL) + CGRectGetMaxY(self.lastBtn.frame) + BTN_INTERVAL;
        }
        
        [self btnWithFrame:CGRectMake(X, Y, W, H) isMy:YES];
    }
}
// 创建下面的btn
- (void)createChannelsBtn
{
    for (int i = 0; i < self.myChannels.count + self.channels.count; i ++ ) {
        CGFloat W = BTN_WIDTH;
        CGFloat H = BTN_HEIGHT;
        CGFloat X;
        CGFloat Y;
        if (i % 2 == 0) {
            X = BTN_INTERVAL;
            Y = i/2 * (H + BTN_INTERVAL) + CGRectGetMaxY(self.channelsLabel.frame) + 2 *BTN_INTERVAL;
        } else {
            X = CGRectGetMaxX(self.lastBtn.frame) + BTN_INTERVAL;
            Y = i/2 * (H + BTN_INTERVAL) + CGRectGetMaxY(self.channelsLabel.frame) + 2 *BTN_INTERVAL;
        }
        
        [self btnWithFrame:CGRectMake(X, Y, W, H) isMy:NO];
    }
}
// 给上面的btn赋值
- (void)myChannelsTitle
{
    [self btnTitlewWitnBtnArr:self.myChannelsBtn titleArr:self.myChannels];
}
// 给下面Btn付title
- (void)channelsTitle
{
    [self btnTitlewWitnBtnArr:self.channelsBtn titleArr:self.channels];
}
// 给btn付titel
- (void)btnTitlewWitnBtnArr:(NSMutableArray *)btnArr titleArr:(NSMutableArray *)titleArr
{
    for (int  i = 0; i < btnArr.count; i++) {
        ChannelBtn *btn = btnArr[i];
        if (i < titleArr.count) {
            [btn setTitle:titleArr[i] forState:UIControlStateNormal];
        } else {
            [btn setTitle:@"" forState:UIControlStateNormal];
        }
    }
}

// 创建btn
- (ChannelBtn *)btnWithFrame:(CGRect)frame isMy:(BOOL)isMy
{
    ChannelBtn *btn = [[ChannelBtn alloc] initWithFrame:frame];
    btn.isMy = isMy;
    [self.view addSubview:btn];
    [btn addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
//    btn.backgroundColor = [UIColor redColor];
    if (isMy) {
        [self.myChannelsBtn addObject:btn];
    } else {
        [self.channelsBtn addObject:btn];
    }
    
    return btn;
}

- (void)btnClicked:(ChannelBtn *)btn
{
    if ([btn.titleLabel.text isEqualToString:@""]) {
        return;
    }
    
    if (btn.isMy) {
        [self.myChannels removeObject:btn.titleLabel.text];
        [self.channels addObject:btn.titleLabel.text];
    } else {
        [self.channels removeObject:btn.titleLabel.text];
        [self.myChannels addObject:btn.titleLabel.text];
    }
    
    [self refreshFrame];
    
    
}

// 刷新
- (void)refreshFrame
{
    // 未订阅栏的frame
    [self channelsLabelFrame];
    
    [self myChannelsTitle];
    [self channelsTitle];
}
// 未订阅栏的frame
- (void)channelsLabelFrame
{
    UIButton *btn;
    if (self.myChannels.count == 0) {
       btn = self.lastBtn;
    } else {
        btn = self.myChannelsBtn[self.myChannels.count-1];
    }
    
    
    CGRect rect = self.channelsLabel.frame;
    CGFloat interval = CGRectGetMaxY(btn.frame)+2*BTN_INTERVAL - rect.origin.y;
    rect.origin.y = CGRectGetMaxY(btn.frame)+2*BTN_INTERVAL;
    self.channelsLabel.frame = rect;
    
    for (ChannelBtn *btn in self.channelsBtn) {
        CGRect btnRect = btn.frame;
        btnRect.origin.y += interval;
        btn.frame = btnRect;
    }
}



@end
