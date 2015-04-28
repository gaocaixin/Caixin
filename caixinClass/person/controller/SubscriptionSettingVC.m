//
//  SubscriptionSettingVC.m
//  Caixin
//
//  Created by gaocaixin on 15/4/28.
//  Copyright (c) 2015年 CX. All rights reserved.
//

#import "SubscriptionSettingVC.h"
#import "RequestTool.h"
#import "SubListModel.h"
#import "MJExtension.h"
#import "SubButten.h"

#define BTN_WIDTH 145
#define BTN_HEIGHT 50
#define BTN_INTERVAL 10

@interface SubscriptionSettingVC ()
@property (weak, nonatomic) IBOutlet UILabel *recommendedLabel;
@property (weak, nonatomic) IBOutlet UIScrollView *myScrollerView;

@property (weak, nonatomic) IBOutlet UILabel *myLabel;


@property (nonatomic ,strong) NSMutableArray *myChannels;
@property (nonatomic ,strong) NSMutableArray *channels;

@property (nonatomic ,strong) NSMutableArray *myChannelsBtn;
@property (nonatomic ,strong) NSMutableArray *channelsBtn;

@end

@implementation SubscriptionSettingVC

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
- (NSMutableArray *)myChannels
{
    if (_myChannels == nil) {
        _myChannels = [[NSMutableArray alloc] init];
    }
    return _myChannels;
}
- (NSMutableArray *)channels
{
    if (_channels == nil) {
        _channels = [[NSMutableArray alloc] init];
    }
    return _channels;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.myScrollerView.bounces = NO;
    //请求数据
    [self requestData];

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
            X = BTN_INTERVAL;
            Y = i/2 * (H + BTN_INTERVAL) + 2*BTN_INTERVAL +  CGRectGetMaxY(self.myLabel.frame);
        } else {
            X = BTN_INTERVAL + BTN_INTERVAL + BTN_WIDTH;
            Y = i/2 * (H + BTN_INTERVAL) + CGRectGetMaxY(self.myLabel.frame) + BTN_INTERVAL * 2;
        }
        
        [self btnWithFrame:CGRectMake(X, Y, W, H) isMy:YES tag:i];
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
            Y = i/2 * (H + BTN_INTERVAL) + 2*BTN_INTERVAL +  CGRectGetMaxY(self.recommendedLabel.frame);
        } else {
            X = BTN_INTERVAL + BTN_INTERVAL + BTN_WIDTH;
            Y = i/2 * (H + BTN_INTERVAL) + CGRectGetMaxY(self.recommendedLabel.frame) + BTN_INTERVAL * 2;
        }
        
        [self btnWithFrame:CGRectMake(X, Y, W, H) isMy:NO tag:i];
    }
}
// 给上面的btn赋值
- (void)myChannelsTitle
{
    [self btnTitlewWitnBtnArr:self.myChannelsBtn modelArr:self.myChannels];
}
// 给下面Btn付title
- (void)channelsTitle
{
    [self btnTitlewWitnBtnArr:self.channelsBtn modelArr:self.channels];
}
// 给btn付titel
- (void)btnTitlewWitnBtnArr:(NSMutableArray *)btnArr modelArr:(NSMutableArray *)modelArr
{
    for (int  i = 0; i < btnArr.count; i++) {
        SubButten *btn = btnArr[i];
        if (i < modelArr.count) {
            btn.model = modelArr[i];
        } else {
            btn.model = nil;
        }
    }
}

// 创建btn
- (SubButten *)btnWithFrame:(CGRect)frame isMy:(BOOL)isMy tag:(int)tag
{
    SubButten *btn = [[SubButten alloc] initWithFrame:frame];
    btn.isMy = isMy;
    btn.tag = tag;
    [self.myScrollerView addSubview:btn];
    [btn addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
    //    btn.backgroundColor = [UIColor redColor];
    if (isMy) {
        [self.myChannelsBtn addObject:btn];
    } else {
        [self.channelsBtn addObject:btn];
    }
    
    return btn;
}

- (void)btnClicked:(SubButten *)btn
{
    if (btn.model == nil) {
        return;
    }
    
    if (btn.isMy) {
        [self.channels addObject:self.myChannels[btn.tag]];
        [self.myChannels removeObject:self.myChannels[btn.tag]];
    } else {
        [self.myChannels addObject:self.channels[btn.tag]];
        [self.channels removeObject:self.channels[btn.tag]];
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
        btn = [[UIButton alloc] initWithFrame:self.myLabel.frame];
    } else {
        btn = self.myChannelsBtn[self.myChannels.count-1];
    }
    
    
    CGRect rect = self.recommendedLabel.frame;
    rect.origin.y = CGRectGetMaxY(btn.frame)+2*BTN_INTERVAL;
    self.recommendedLabel.frame = rect;
    
    for (int i = 0; i < self.channelsBtn.count; i ++ ) {
        CGFloat W = BTN_WIDTH;
        CGFloat H = BTN_HEIGHT;
        CGFloat X;
        CGFloat Y;
        if (i % 2 == 0) {
            X = BTN_INTERVAL;
            Y = i/2 * (H + BTN_INTERVAL) + 2*BTN_INTERVAL +  CGRectGetMaxY(self.recommendedLabel.frame);
        } else {
            X = BTN_INTERVAL + BTN_INTERVAL + BTN_WIDTH;
            Y = i/2 * (H + BTN_INTERVAL) + CGRectGetMaxY(self.recommendedLabel.frame) + BTN_INTERVAL * 2;
        }
        
        SubButten *btn = self.channelsBtn[i];
        btn.frame = CGRectMake(X, Y, W, H);
    }
    
    if (self.channels.count == 0) {
        self.myScrollerView.contentSize = CGSizeMake(0, CGRectGetMaxY(self.recommendedLabel.frame));
    } else {
        SubButten *btn = self.channelsBtn[self.channels.count - 1];
        self.myScrollerView.contentSize  = CGSizeMake(0, CGRectGetMaxY(btn.frame));
    }
}


//请求数据
- (void)requestData
{
    [RequestTool requestSubListSuccess:^(id responseObject) {
        NSArray *arr = [SubListModel objectArrayWithKeyValuesArray:responseObject[@"data"]];
        self.myChannels =  [[NSMutableArray alloc] initWithArray:arr];
        
        // 创建frame
        [self createmyChannelsBtn];
//        [self channelsLabelFrame];
        [self createChannelsBtn];
        
        [self refreshFrame];
        
    } failure:^(NSError *error) {
        
    }];
}



@end
