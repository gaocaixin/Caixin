//
//  MainNavC.m
//  Caixin
//
//  Created by gaocaixin on 15/4/24.
//  Copyright (c) 2015年 CX. All rights reserved.
//

#import "MainNavC.h"

@interface MainNavC ()

@end

@implementation MainNavC

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    [super pushViewController:viewController animated:animated];
    
    // 设置下一个viewc的返回按钮
    if (viewController.navigationItem.leftBarButtonItem == nil && self.viewControllers.count > 1) {
        UIButton *backBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
        [backBtn setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
        [backBtn addTarget:self action:@selector(popViewC) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
        viewController.navigationItem.leftBarButtonItem = item;
    }
    
}

// 返回按钮触发事件
- (void)popViewC
{
    [self popViewControllerAnimated:YES];
}

@end
