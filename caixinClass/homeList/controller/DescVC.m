//
//  DescVC.m
//  Caixin
//
//  Created by gaocaixin on 15/4/25.
//  Copyright (c) 2015年 CX. All rights reserved.
//

#import "DescVC.h"

@interface DescVC () <UIWebViewDelegate>

@property (nonatomic ,weak) UIWebView *webView;

@property (nonatomic ,copy) NSString *url;

@end

@implementation DescVC

- (void)viewDidLoad {
    self.view.backgroundColor = [UIColor whiteColor];
    [super viewDidLoad];
    
    [self createWebView];
}
// 创建webview
- (void)createWebView
{
    UIWebView *webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:webView];
    webView.delegate = self;
    
    self.webView = webView;
   
    NSURL *url = [NSURL URLWithString:self.url];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
    [webView loadRequest:request];
}

#pragma mark - 代理
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    // 取设置
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    if ([user objectForKey:TEXT_SIZE] == nil) {
        [user setObject:@100 forKey:TEXT_SIZE];
        [user synchronize];
    }
    CGFloat textSize = [[user objectForKey:TEXT_SIZE] doubleValue];
    // 设置文字大小
    NSString *str = [NSString stringWithFormat:@"document.getElementsByTagName('body')[0].style.webkitTextSizeAdjust= '%f%%'", textSize];
    [self.webView stringByEvaluatingJavaScriptFromString:str];

}


// 数据源
- (void)setListModel:(EditListModel *)listModel
{
    _listModel = listModel;
    
    if ([_listModel.article_type intValue] == 3) {
        self.url = listModel.web_url;
    } else {
        self.url = [NSString stringWithFormat:@"http://mappv4.caixin.com/article/%@.html?fontsize=1", listModel.ID];
    }
    self.title = listModel.title;
}
- (void)setSubListModel:(SubscribeListModel *)subListModel
{
    _subListModel = subListModel;
    self.url = subListModel.web_article_url;
    if (subListModel.web_article_url.length < 1) {
        self.url = [NSString stringWithFormat:@"http://mappv4.caixin.com/article/%@.html?fontsize=1", subListModel.ID];
    }
    self.title = subListModel.title;
}

@end
