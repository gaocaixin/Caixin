//
//  HomeViewC.m
//  Caixin
//
//  Created by gaocaixin on 15/4/24.
//  Copyright (c) 2015年 CX. All rights reserved.
//

#import "HomeViewC.h"
#import "RequestTool.h"
#import "TitleModel.h"
#import "TitleButten.h"
#import "EditListModel.h"
#import "EditModel.h"
#import "EditTableVCellType1.h"
#import "EditTableVCellType2.h"
#import "EditTableVCellType3.h"
#import "EditTableVCellType4.h"
#import "EditTableVCellType5.h"
#import "EditTableVCellType6.h"
#import "EditTableVCellType7.h"
#import "EditTableVCellType8.h"
#import "DescVC.h"
#import "SubscribeModel.h"
#import "SubscribeListModel.h"
#import "SubHeaderSectionView.h"
#import "Animation.h"
#import "PersonVC.h"
#import "MJRefresh.h"
#import "SubscribeListHeaderVC.h"
#import "SearchVC.h"
#import "MBProgressHUD+MJ.h"

#define CHANNLE_BTN_INTERVAL 10
#define TITLEVIEW_HEIGHT 30

#define TITLE_EDIT @"编辑精选"

#define TITLE_SUBSCRIBE @"我的订阅"
#define TITLE_LAEST @"最新文章"

@interface HomeViewC () <UIScrollViewDelegate, UITableViewDelegate, UITableViewDataSource, MJRefreshBaseViewDelegate, SubHeaderSectionViewDelegate, UIAlertViewDelegate, EditTableVCellType5Delegate>

// 频道滚动视图
@property (nonatomic ,strong) UIScrollView *titleScrollView;
// 频道列表BTN
@property (nonatomic ,strong) NSMutableArray *titleBtnArray;
// 临时btn
@property (nonatomic ,weak) TitleButten *tempBtn;

// list滚动视图
@property (nonatomic ,weak) UIScrollView *listScrollView;
// 存放tableview
@property (nonatomic ,strong) NSMutableArray *tabelViewArray;

// tableView数据源
@property (nonatomic ,strong) NSMutableArray *tableViewDataArray;

@property (nonatomic ,weak) UIView *categoryView;
@end

@implementation HomeViewC

#pragma mark - 初始化
// 初始化
- (instancetype)init
{
    if (self = [super init]) {
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // 初始化nav
    [self setUpNav];
    // 创建频道
    [self createTitleScrollView];
    // 创建list滚动视图
    [self createListScrollView];
    // 创建tableview
    [self createPreTableView];
    
    // 请求频道标题
    [self requestTitleView];
    // 点击首页
    [self titleBtnClicked:self.titleBtnArray[0]];
}

- (void)setUpNav
{
    // 左边网图片
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
    imageView.image = [UIImage imageNamed:@"resize_png_new.php"];
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    imageView.layer.cornerRadius = CGW(imageView)/2 + 5;
    imageView.layer.masksToBounds =YES;
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:imageView];
    // 右边个人信息
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
    [btn setImage:[UIImage imageNamed:@"webArticle_share"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(userBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 60, 30)];
    label.text = @"全球新闻";
    label.font = [UIFont boldSystemFontOfSize:16];
    label.textColor = [UIColor blackColor];
    self.navigationItem.titleView = label;
}

// 跳到个人页面
- (void)userBtnClicked:(UIButton *)btn
{
    if (self.categoryView) {
        [self.categoryView removeFromSuperview];
        return;
    }

    NSArray *arr = @[@"清除缓存", @"缓存下载", @"搜索", @"取消"];
    
    CGFloat Wpianyi = 30;
    CGFloat Ypianyi = 10;
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetMinX(btn.frame)-Wpianyi/2, CGRectGetMaxY(btn.frame)+Ypianyi*2, CGW(btn)+Wpianyi, CGH(btn) * arr.count)];
    view.backgroundColor = [UIColor colorWithWhite:200/255.0 alpha:0.2];
    view.layer.cornerRadius = 5;
    view.layer.masksToBounds = YES;
    self.categoryView = view;
    [self.view addSubview:view];
    
    
    CGFloat W = CGW(btn)+Wpianyi;
    CGFloat H = CGH(btn);
    CGFloat X = 0;
    for (int i = 0; i < arr.count; i++) {
        UIButton *btn = [self createCategoryBtnWithFrame:CGRectMake(X, H*i, W, H) title:arr[i]];
        btn.tag = i;
        [view addSubview:btn];
        [btn addTarget:self action:@selector(categoryViewBtn:) forControlEvents:UIControlEventTouchUpInside];
    }
}

// 分类view的btn点击
- (void)categoryViewBtn:(UIButton *)btn
{
    switch (btn.tag) {
        case 0:
            [self claearTash];
            break;
        case 1:
            [self loadAllData];
            break;
        case 2:
            [self searchBtn];
            break;
        default:
            break;
    }
    [self.categoryView removeFromSuperview];
}

- (void)searchBtn
{
// 添加动画
    [self.navigationController.view.layer addAnimation:[Animation kCATransitionPushFromTop] forKey:nil];
    SearchVC *view = [[SearchVC alloc] init];
    [self.navigationController pushViewController:view animated:YES];
    [view.navigationController.navigationBar.subviews[0] setHidden:YES];
}

- (void)loadAllData
{
    
    UIAlertView *view = [[UIAlertView alloc] initWithTitle:@"缓存下载" message:@"即将下载最新的115篇缓存数据" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    view.tag = 1;
    [view show];
}
// alertView代理
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == 1) {
        if (buttonIndex == 1) {
            CGFloat H = 10;
            CGFloat W = CGW(self.view);
            UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, CGH(self.view) - H, W, H)];
            bgView.backgroundColor = [UIColor grayColor];
            [self.view.window addSubview:bgView];
            
            UIView *pressView = [[UIView alloc] initWithFrame:CGRectMake(0, CGH(self.view) - H, 0, H)];
            pressView.backgroundColor = [UIColor redColor];
            [self.view.window addSubview:pressView];
            
            NSArray * arr = @[@"http://mappv4.caixin.com/index_page_v4/index_page_1.json",
                              @"http://mappv4.caixin.com/subscribe_article_list/index.json",
                              @"http://mappv4.caixin.com/channel/list_lastnew_20_1.json",
                              @"http://mappv4.caixin.com/channel/list_8_20_1.json",
                              @"http://mappv4.caixin.com/channel/list_11_20_1.json",
                              @"http://mappv4.caixin.com/channel/list_7_20_1.json",
                              @"http://mappv4.caixin.com/channel/list_6_20_1.json",
                              @"http://mappv4.caixin.com/channel/list_5_20_1.json",
                              @"http://mappv4.caixin.com/channel/list_2_20_1.json",
                              @"http://mappv4.caixin.com/channel/list_1_20_1.json",
                              @"http://mappv4.caixin.com/channel/list_150_20_1.json",
                              @"http://mappv4.caixin.com/channel/list_10_20_1.json",
                              @"http://mappv4.caixin.com/channel/list_3_20_1.json"];
            __block int i = 1;
            for (NSString *url in arr) {
                
                [RequestTool requestWithURL:url isUpData:YES Success:^(id responseObject) {
                    
                    CGRect rect = pressView.frame;
                    rect.size.width = i * W / arr.count;
                    pressView.frame = rect;
                    i++;
                    if (i == arr.count) {
                        [pressView removeFromSuperview];
                        [bgView removeFromSuperview];
                        [MBProgressHUD showSuccess:@"缓存完成"];
                    }
                    
                } failure:^(NSError *error) {
                    CGRect rect = pressView.frame;
                    rect.size.width = i * W / arr.count;
                    pressView.frame = rect;
                }];
            }
        }

    } else if (alertView.tag == 0) {
        if (buttonIndex == 1) {
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
        }

    }
    
}


- (void)claearTash
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
    NSString *message = [NSString stringWithFormat:@"共有%.2fMB", sizeMB];
    UIAlertView *view = [[UIAlertView alloc] initWithTitle:@"清除缓存" message:message delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    view.tag = 0;
    [view show];
    
}



- (UIButton *)createCategoryBtnWithFrame:(CGRect)frame title:(NSString *)title
{
    UIButton *categoryBtn = [[UIButton alloc] initWithFrame:frame];
    [categoryBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [categoryBtn setTitle:title forState:UIControlStateNormal];
    [categoryBtn setBackgroundColor:CXColorP(0, 0, 0, 0.5)];
    categoryBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    return categoryBtn;
}


#pragma mark - 频道下方list滚动栏

// 创建list滚动视图
- (void)createListScrollView
{
    // list
    UIScrollView * scrollView = [[UIScrollView alloc] init];
    scrollView.frame = CGRectMake(0, CGRectGetMaxY(self.titleScrollView.frame), CGW(self.view), CGH(self.view) - CGRectGetMaxY(self.titleScrollView.frame));
    [self.view addSubview:scrollView];
    scrollView.backgroundColor = [UIColor redColor];
    scrollView.bounces = NO;
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.contentSize = CGSizeMake(0, -1000);
    scrollView.autoresizingMask = 0;
    scrollView.delegate = self;
    scrollView.pagingEnabled = YES;
    
    self.listScrollView = scrollView;
}

#pragma mark - tableview
- (NSMutableArray *)tableViewDataArray
{
    if (_tableViewDataArray == nil) {
        _tableViewDataArray = [[NSMutableArray alloc] init];
    }
    return _tableViewDataArray;
}
- (NSMutableArray *)tabelViewArray
{
    if (_tabelViewArray == nil) {
        _tabelViewArray = [[NSMutableArray alloc] init];
    }
    return _tabelViewArray;
}
// 创建前面三个tableview
- (void)createPreTableView
{
    for (int i = 0; i < 3; i++) {
        [self createTableViewWithFrame:CGRectMake(i * CGW(self.listScrollView), 0, CGW(self.listScrollView), CGH(self.listScrollView)) tag:i];
    }
}
// 创建加载频道里地tableview
- (void)createLastTableView
{
    for (int i = 3; i < self.titleBtnArray.count; i++) {
        [self createTableViewWithFrame:CGRectMake(i * CGW(self.listScrollView), 0, CGW(self.listScrollView), CGH(self.listScrollView)) tag:i];
    }
}
// 创建tableview
- (void)createTableViewWithFrame:(CGRect)frame tag:(int)tag
{
    // 给tableview增加一个数据源
    NSMutableArray *array  = [[NSMutableArray alloc] init];
    [self.tableViewDataArray addObject:array];
    
    // 创建tableview
    UITableView *tableView = [[UITableView alloc] initWithFrame:frame style:UITableViewStyleGrouped];
    tableView.tag = tag;
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.sectionHeaderHeight = 0;
    tableView.sectionFooterHeight = 0;
    if (tag != 1) {
        tableView.contentInset = UIEdgeInsetsMake(-35, 0, -19, 0);
    } else {
        tableView.contentInset = UIEdgeInsetsMake(1, 0, -10, 0);
    }
//    tableView.bounces = NO;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.listScrollView addSubview:tableView];
    [self.tabelViewArray addObject:tableView];
    
    // 添加上下拉刷新
    if (tag != 1) {
        MJRefreshFooterView *footer = [MJRefreshFooterView footer];
        footer.scrollView = tableView;
        footer.delegate = self;
        footer.tag = tag;
    }
    MJRefreshHeaderView *header = [MJRefreshHeaderView header];
    header.scrollView = tableView;
    header.delegate = self;
    header.tag = tag;
    // 设置滚动范围
    self.listScrollView.contentSize = CGSizeMake(self.tabelViewArray.count * CGW(self.listScrollView), -1000);
    
    
}


#pragma mark - tableview数据源方法

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [self.tableViewDataArray[tableView.tag] count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == self.tabelViewArray[1]) {
        return 2;
    }
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 编辑精选
    if (tableView == self.tabelViewArray[0]) {
        EditModel *model = self.tableViewDataArray[0][indexPath.section];
        switch ([model.type intValue]) {
            case 1:
            {
                EditTableVCellType1 *cell = [EditTableVCellType1 editTableVCell:tableView];
                cell.model = model;
                return cell;
            }
                break;
            case 2:
            {
                EditTableVCellType2 *cell = [EditTableVCellType2 editTableVCell:tableView];
                cell.model = model;
                return cell;
            }
                break;
            case 3:
            {
                EditTableVCellType3 *cell = [EditTableVCellType3 editTableVCell:tableView];
                cell.model = model;
                return cell;
            }
                break;
            case 4:
            {
                EditTableVCellType4 *cell = [EditTableVCellType4 editTableVCell:tableView];
                cell.model = model;
                return cell;
            }
                break;
            case 5:
            {
                EditTableVCellType5 *cell = [EditTableVCellType5 editTableVCell:tableView];
                cell.delegate = self;
                cell.model = model;
                return cell;
            }
                break;
            case 6:
            {
                EditTableVCellType6 *cell = [EditTableVCellType6 editTableVCell:tableView];
                cell.model = model;
                return cell;
            }
                break;
            case 7:
            {
                EditTableVCellType7 *cell = [EditTableVCellType7 editTableVCell:tableView];
                cell.model = model;
                return cell;
            }
                break;
            default:
                break;
        }
    }
    // 我的订阅
    else if (tableView == self.tabelViewArray[1]) {
        SubscribeModel *model = self.tableViewDataArray[1][indexPath.section];
        SubscribeListModel *listModel = model.listArr[indexPath.row];
        // 根据数据返回模型
        if (listModel.author_img_url.length > 0) {
            EditTableVCellType8 *cell = [EditTableVCellType8 editTableVCell:tableView];
            cell.subscribeListModel = listModel;
            return cell;
        } else if (listModel.picture_url.length > 0) {
            EditTableVCellType6 *cell = [EditTableVCellType6 editTableVCell:tableView];
            cell.subscribeListModel = listModel;
            return cell;
        } else {
            EditTableVCellType4 *cell = [EditTableVCellType4 editTableVCell:tableView];
            cell.subscribeListModel = listModel;
            return cell;
        }
    }
    else  {
        SubscribeListModel *listModel = self.tableViewDataArray[tableView.tag][indexPath.section];
        // 根据数据返回模型
        if (listModel.author_img_url.length > 0) {
            EditTableVCellType8 *cell = [EditTableVCellType8 editTableVCell:tableView];
            cell.subscribeListModel = listModel;
            return cell;
        } else if (listModel.picture_url.length > 0) {
            EditTableVCellType6 *cell = [EditTableVCellType6 editTableVCell:tableView];
            cell.subscribeListModel = listModel;
            return cell;
        } else {
            EditTableVCellType4 *cell = [EditTableVCellType4 editTableVCell:tableView];
            cell.subscribeListModel = listModel;
            return cell;
        }
    }
    static NSString *ID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    return cell;
}

#pragma mark - tableView代理方法
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 编辑精选
    if (tableView == self.tabelViewArray[0]) {
        EditModel *model = self.tableViewDataArray[0][indexPath.section];
        switch ([model.type intValue]) {
            case 1:
                return 180;
                break;
            default:
                return 80;
                break;
        }
    }
    return 80;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (tableView == self.tabelViewArray[1]) {
        return 30;
    }
    return 0.0;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (tableView == self.tabelViewArray[1]) {
        return 8;
    }
    return 0.0;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (tableView == self.tabelViewArray[1]) {
        SubHeaderSectionView *view = [SubHeaderSectionView subHeaderSectionView];
        view.delegate = self;
        view.model = self.tableViewDataArray[1][section];
        return view;
    }
    return nil;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.tabelViewArray[0]) {
        EditModel *model = self.tableViewDataArray[0][indexPath.section];
         EditListModel *listModel = [model.listArr lastObject];
        
        if (model.listArr.count > 1) {
            listModel = [model.listArr firstObject];
        }
        DescVC *desc =  [[DescVC alloc] init];
        desc.listModel = listModel;
        [self.navigationController pushViewController:desc animated:YES];
    }
    else if (tableView == self.tabelViewArray[1]) {
        SubscribeModel *model = self.tableViewDataArray[1][indexPath.section];
        SubscribeListModel *listModel = model.listArr[indexPath.row];
        
        DescVC *desc =  [[DescVC alloc] init];
        desc.subListModel = listModel;
        [self.navigationController pushViewController:desc animated:YES];
        
    }
    else  {
        SubscribeListModel *listModel = self.tableViewDataArray[tableView.tag][indexPath.section];
        if (listModel.web_article_url.length > 0) {
            DescVC *desc =  [[DescVC alloc] init];
            desc.subListModel = listModel;
            [self.navigationController pushViewController:desc animated:YES];
        }
    }
}



#pragma mark - 频道栏

// 定制频道滚动视图
- (void)createTitleScrollView
{
    // 定制titleview
    UIScrollView * scrollView = [[UIScrollView alloc] init];
    scrollView.frame = CGRectMake(0, HEIGHT_NAV + HEIGHT_STA, CGW(self.view), TITLEVIEW_HEIGHT);
    [self.view addSubview:scrollView];
    scrollView.backgroundColor = [UIColor blackColor];
    scrollView.bounces = NO;
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.contentSize = CGSizeMake(0, -64);
    scrollView.autoresizingMask = 0;
    scrollView.delegate = self;

    self.titleScrollView = scrollView;
    
    // 添加模块
    NSArray *array = @[TITLE_EDIT ,TITLE_SUBSCRIBE, TITLE_LAEST];
    // 前三个btn的url
    NSArray *urlStrArr = @[@"http://mappv4.caixin.com/index_page_v4/index_page_1.json", @"http://mappv4.caixin.com/subscribe_article_list/index.json", @"http://mappv4.caixin.com/channel/list_lastnew_20_1.json"];
    for (int i = 0; i < array.count; i++) {
        [self createTitleBtnWithTitle:array[i] tag:i urlStr:urlStrArr[i]];
    }
}

// 频道Btn数组
- (NSMutableArray *)titleBtnArray
{
    if (!_titleBtnArray) {
        _titleBtnArray = [[NSMutableArray alloc] init];
    }
    return _titleBtnArray;
}
// 请求频道列表数据
- (void)requestTitleView
{
    
    NSMutableArray *titleArrM = [NSMutableArray array];
    
    [RequestTool requestTitleListSuccess:^(id responseObject) {
            NSArray *titleArr = responseObject[@"data"];
            for (NSDictionary *dict in titleArr) {
                TitleModel *model = [TitleModel modelWithDict:dict];
                [titleArrM addObject:model];
            }
        
        // 创建频道Btn
        for (int i = 0; i < titleArrM.count; i++) {
            TitleModel *model = titleArrM[i];
            NSString *chinaName = [model.title substringToIndex:2];
            // 给btn附上url
            NSString *url = [NSString stringWithFormat:@"http://mappv4.caixin.com/channel/list_%@_20_1.json" , model.ID];
            [self createTitleBtnWithTitle:chinaName tag:self.titleBtnArray.count urlStr:url];
        }
        
        [self createLastTableView];
        
    } failure:^(NSError *error) {
        CXLog(@"%@", error);
    }];


}
// 创建频道Btn
- (void)createTitleBtnWithTitle:(NSString *)title tag:(long)tag urlStr:(NSString *)urlStr
{
    TitleButten *btn = [[TitleButten alloc] init];
    // 计算btn的宽度
    btn.titleLabel.font = [UIFont systemFontOfSize:14];
    CGSize btnSize = [title sizeWithAttributes:@{NSFontAttributeName:btn.titleLabel.font}];
    // btn的frame
    CGFloat W = btnSize.width;
    CGFloat H = btnSize.height;
    CGFloat X = self.titleScrollView.contentSize.width + CHANNLE_BTN_INTERVAL/2 + (self.titleBtnArray.count > 0 ? CHANNLE_BTN_INTERVAL/2 : 0);
    CGFloat Y = -HEIGHT_NAV-HEIGHT_STA + (CGH(self.titleScrollView)-btnSize.height)/2.0;
    btn.frame = CGRectMake(X, Y, W, H);
    // 设置文字
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor greenColor] forState:UIControlStateSelected];
    [btn addTarget:self action:@selector(titleBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    btn.titleLabel.textAlignment = NSTextAlignmentCenter;
    
    btn.tag = tag;
    btn.requestUrl = urlStr;
    btn.lastRequestUrl = urlStr;
    
    [self.titleScrollView addSubview:btn];
    [self.titleBtnArray addObject:btn];
    
    CGSize size = self.titleScrollView.contentSize;
    size.width = X + W + 10;
    self.titleScrollView.contentSize = size;
    
    
}
// 频道点击事件
- (void)titleBtnClicked:(TitleButten *)btn
{
    if (btn == self.tempBtn) {
        return;
    }
    self.tempBtn.selected = NO;
    btn.selected = YES;
    self.tempBtn = btn;
    CGPoint point = self.listScrollView.contentOffset;
    point.x = btn.tag * CGW(self.listScrollView);
    [self.listScrollView setContentOffset:point animated:NO];
    
    // 滑动控制title右边显示btn
    CGFloat right = CGRectGetMaxX(btn.frame) - CGW(self.titleScrollView) +CHANNLE_BTN_INTERVAL/2;
    CGFloat rightOffset = right - self.titleScrollView.contentOffset.x;
    if (rightOffset >= 0) {
        CGPoint titlePoint = self.titleScrollView.contentOffset;
        titlePoint.x = right;
        [self.titleScrollView setContentOffset:titlePoint animated:YES];
    }
    
    // 滑动控制title左边显示btn
    CGFloat left = CGRectGetMinX(btn.frame) - CHANNLE_BTN_INTERVAL/2;
    CGFloat leftOffset = left - self.titleScrollView.contentOffset.x;
    if (leftOffset < 0) {
        CGPoint titlePoint = self.titleScrollView.contentOffset;
        titlePoint.x = left;
        [self.titleScrollView setContentOffset:titlePoint animated:YES];
    }
    
    // 请求当前btn前后的数据
    [self requestTableViewDataWithTag:btn.tag];
}

- (void)requestTableViewDataWithTag:(long)tag
{
    // 请求btn数据
    TitleButten *curBtn = self.titleBtnArray[tag];
    [self requesttTableViewData:curBtn ];
    if (tag > 0) {
        TitleButten *preBtn = self.titleBtnArray[tag - 1];
        [self requesttTableViewData:preBtn];
    }
    if (tag < self.titleBtnArray.count - 1) {
        TitleButten *nextBtn = self.titleBtnArray[tag + 1];
        [self requesttTableViewData:nextBtn];
    }
    
}

// 请求tableview数据
- (void)requesttTableViewData:(TitleButten *)btn
{
    if (btn == nil) {
        return;
    }
    
    if ([self.tableViewDataArray[btn.tag] count]>0) {
        return;
    }
//    NSLog(@"%@", btn.requestUrl);
    
    [self requesttTableViewDataWithStr:btn.requestUrl tag:btn.tag isUpData:NO success:nil failure:nil];

}

// 请求数据
- (void)requesttTableViewDataWithStr:(NSString *)url tag:(long)tag isUpData:(int)is success:(void (^)())success failure:(void (^)())failure
{
    // 解析数据
    [RequestTool requestWithURL:url isUpData:is Success:^(id responseObject) {
        // 数据转模型
        NSArray *array = responseObject[@"data"];
        NSMutableArray *arrM = [NSMutableArray array];
        
        // 数据转模型
        for (NSDictionary *dict in array) {
            
            if (tag == 0) {
                EditModel *model = [EditModel modelWithDict:dict];
                [arrM addObject:model];
                
            } else if (tag == 1) {
                SubscribeModel *model = [SubscribeModel modelWithDict:dict];
                [arrM addObject:model];
            } else  {
                SubscribeListModel *model = [SubscribeListModel modelWithDict:dict];
                [arrM addObject:model];
            }
        }
        // 插入下标
        int index = arrM.count-1;
        if (is) {
            // 精选
            if (tag == 0) {
                // 当前最新的model
                EditModel *model1 = self.tableViewDataArray[0][0];
                EditListModel *listModel1 = [model1.listArr lastObject];
                // 遍历
                for (int i = arrM.count-1; i >= 0; i--) {
                EditModel *model = arrM[i];
                EditListModel *listModel = [model.listArr lastObject];
                // 找到相等的下标
                if ([listModel.ID isEqualToString:listModel1.ID]) {
                    index = i;
                    }
                }
               
                // 插入新数据
                for (int i = index-1; i >= 0; i--) {
                    EditModel *newModel = arrM[i];
                    [self.tableViewDataArray[0] insertObject:newModel atIndex:0];
                }
            // 订阅
            } else if (tag == 1) {
                // 最新model
                SubscribeModel *model1 = self.tableViewDataArray[1][0];
                SubscribeListModel *listModel1 = [model1.listArr lastObject];
                // 遍历
                for (int i = arrM.count-1; i >= 0; i--) {
                    SubscribeModel *model = arrM[i];
                    SubscribeListModel *listModel = [model.listArr lastObject];
                    // 找到相等的下标
                    if ([listModel.ID isEqualToString:listModel1.ID]) {
                        index = i;
                    }
                }
                // 插入新数据
                for (int i = index-1; i >= 0; i--) {
                    SubscribeModel *newModel = arrM[i];
                    [self.tableViewDataArray[1] insertObject:newModel atIndex:0];
                }
            // 其他数据
            } else {
                // 最新model
                SubscribeListModel *model1 = self.tableViewDataArray[tag][0];
                // 遍历
                for (int i = arrM.count-1; i >= 0; i--) {
                    SubscribeListModel *model = arrM[i];
                    // 找到相等的下标
                    if ([model.ID isEqualToString:model1.ID]) {
                        index = i;
                    }
                }
                // 插入新数据
                for (int i = index-1; i >= 0; i--) {
                    SubscribeListModel *newModel = arrM[i];
                    [self.tableViewDataArray[tag] insertObject:newModel atIndex:0];
                }
            }
        } else {
            [self.tableViewDataArray[tag] addObjectsFromArray:arrM];
        }
        
        // 刷新tableview
        UITableView *tableView = self.tabelViewArray[tag];
        [tableView reloadData];
        
        if (success) {
            success();
        }
        
    }failure:^(NSError *error) {
        
        if (failure) {
            failure();
        }
    }];
}

#pragma mark - scrollView代理
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if (scrollView == self.listScrollView) {
        // 监听分list滚动位置 点击title
        int index = scrollView.contentOffset.x/CGW(self.listScrollView);
        [self titleBtnClicked:self.titleBtnArray[index]];
    }
}

- (void)refreshViewBeginRefreshing:(MJRefreshBaseView *)refreshView
{
    TitleButten *btn = self.titleBtnArray[refreshView.tag];
    
    if ([refreshView isKindOfClass:[MJRefreshHeaderView class]]) {
        // 请求最新数据
        [self requesttTableViewDataWithStr:btn.lastRequestUrl tag:refreshView.tag isUpData:YES success:^{
            [refreshView endRefreshing];
        } failure:^{
            [refreshView endRefreshing];
        }];
    } else if ([refreshView isKindOfClass:[MJRefreshFooterView class]]) {
        // 上拉加载数据
        
        NSString *url = btn.requestUrl;
        NSRange range = [url rangeOfString:@".json"];
        NSRange indexRange = NSMakeRange(range.location - 1, 1);
        // 当前url page属性值
        NSString *index = [url substringWithRange:indexRange];
        // 下一个page
        int lastIndex = [index intValue]+1;
        // 替换
        NSString *str1 = [url substringToIndex:indexRange.location];
        NSString *str2 = [NSString stringWithFormat:@"%d", lastIndex];
        NSString *str3 = [url substringFromIndex:range.location];
        NSArray *array = @[str1, str2, str3];
        NSString *newUrl = [array componentsJoinedByString:@""];
//        NSLog(@"%@", newUrl);
        btn.requestUrl = newUrl;
        
        [self requesttTableViewDataWithStr:newUrl tag:refreshView.tag isUpData:NO success:^{
            [refreshView endRefreshing];
        } failure:^{
            [refreshView endRefreshing];
        }];
    }
    
}

#pragma mark - editcell5Delegate
- (void)editTableVCellType5ButtenClicked:(EditListModel *)model
{
    DescVC *desc =  [[DescVC alloc] init];
    desc.listModel = model;
    [self.navigationController pushViewController:desc animated:YES];
}


#pragma mark - SubHeaderSectionViewDelegate
- (void)subHeaderSectionView:(SubHeaderSectionView *)view titleButtenClicked:(UIButton *)btn
{
    SubscribeListHeaderVC *vc = [[SubscribeListHeaderVC alloc] init];
    vc.model = view.model;
    [self.navigationController pushViewController:vc animated:YES];
}


@end
