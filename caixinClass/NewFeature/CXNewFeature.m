//
//  CXNewFeature.m
//  CXWeibo
//
//  Created by mac on 15-2-28.
//  Copyright (c) 2015年 mac. All rights reserved.
//

#import "CXNewFeature.h"
#import "HomeViewC.h"
#import "Tool.h"
#import "MainNavC.h"

#define ImageCount 4

@interface CXNewFeature () <UIScrollViewDelegate>

@property (nonatomic, weak) UIPageControl *page;

@end

@implementation CXNewFeature

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    [self setupScroll];
    
    [self setupPage];
    
}

- (void)setupPage
{
    CGFloat W = 0;
    CGFloat H = 0;
    CGFloat X = self.view.bounds.size.width/2 - W/2;
    CGFloat Y = self.view.bounds.size.height - 20;

    UIPageControl *page = [[UIPageControl alloc] initWithFrame:CGRectMake(X, Y, W, H)];
    page.numberOfPages = ImageCount;
    page.userInteractionEnabled = NO;
    [self.view addSubview:page];
    self.page = page;
}

- (void)setupScroll
{
    
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    
    CGFloat imageW = self.view.bounds.size.width;
    CGFloat imageH = self.view.bounds.size.height;
    
    for (int i = 0; i < ImageCount; i++) {
        NSString *imageName;
        
        if ([[Tool deviceString] isEqualToString:@"iPhone 4"]) {
            imageName = [NSString stringWithFormat:@"ip4-%d", i+1];
        } else if ([[Tool deviceString] isEqualToString:@"iPhone4,1"]) {
            imageName = [NSString stringWithFormat:@"iphone4s-%d", i+1];
        } else if ([[Tool deviceString] isEqualToString:@"iPhone5,2"]) {
             imageName = [NSString stringWithFormat:@"5S开机引导-%d", i+1];
        } else{
            imageName = [NSString stringWithFormat:@"5S开机引导-%d", i+1];
        }
//        // 设置4英寸的图片 -568h图片只在lunch里匹配 再其他文件中需要手写匹配 并且把图片拽出images
//        if ([UIScreen mainScreen].bounds.size.height == 568) {
//            imageName = [imageName stringByAppendingString:@"-568h@2x.png"];
//        }
        
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.image = [UIImage imageNamed:imageName];
        
        
        imageView.frame = CGRectMake(i * imageW, 0, imageW, imageH);
        
        [scrollView addSubview:imageView];
        
        if (i == ImageCount - 1) {
            imageView.userInteractionEnabled = YES;
            [self setupLastImageView:imageView];
        }
    }
    
    scrollView.contentSize = CGSizeMake(imageW * ImageCount, imageH);
    scrollView.pagingEnabled = YES;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.delegate = self;
    [self.view addSubview:scrollView];
    
}

- (void)setupLastImageView:(UIImageView *)imageView
{

    UIButton *btn = [[UIButton alloc] init];
    btn.frame = self.view.bounds;
    [btn addTarget:self action:@selector(btn) forControlEvents:UIControlEventTouchUpInside];
    [imageView addSubview:btn];
    
}
/**
 *  开始微博
 */
- (void)btn
{
//    CXTabbarController *tb = [[CXTabbarController alloc] init];
    // 切换根控制器
    
    [UIApplication sharedApplication].statusBarHidden = NO;
    self.view.window.rootViewController = [[MainNavC alloc] initWithRootViewController:[[HomeViewC alloc] init]];;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    self.page.currentPage = (scrollView.contentOffset.x +self.view.bounds.size.width / 2) / self.view.bounds.size.width;
}

@end
