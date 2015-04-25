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

@end
