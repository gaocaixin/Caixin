//
//  DescVC.m
//  Caixin
//
//  Created by gaocaixin on 15/4/25.
//  Copyright (c) 2015年 CX. All rights reserved.
//

#import "DescVC.h"

@interface DescVC ()

@property (nonatomic ,weak) UIWebView *webView;

@property (nonatomic ,copy) NSString *url;

@end

@implementation DescVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createWebView];
}

- (void)createWebView
{
    UIWebView *webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:webView];
    self.webView = webView;
    
    NSURL *url = [NSURL URLWithString:self.url];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
    [webView loadRequest:request];
}

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
    
    self.title = subListModel.title;
}

@end
