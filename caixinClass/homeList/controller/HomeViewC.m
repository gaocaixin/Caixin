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
#import "DescVC.h"

#define CHANNLE_BTN_INTERVAL 10
#define TITLEVIEW_HEIGHT 30

@interface HomeViewC () <UIScrollViewDelegate, UITableViewDelegate, UITableViewDataSource>

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
@end

@implementation HomeViewC

// 初始化
- (instancetype)init
{
    if (self = [super init]) {
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
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
    UITableView *tableView = [[UITableView alloc] initWithFrame:frame style:UITableViewStyleGrouped];
    tableView.tag = tag;
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.sectionFooterHeight = 0;
    tableView.sectionHeaderHeight = 0;
    [self.listScrollView addSubview:tableView];
    [self.tabelViewArray addObject:tableView];
    // 给tableview增加一个数据源
    NSMutableArray *array  = [[NSMutableArray alloc] init];
    [self.tableViewDataArray addObject:array];
    
    self.listScrollView.contentSize = CGSizeMake(self.tabelViewArray.count * CGW(self.listScrollView), -1000);
    
}


#pragma mark - tableview数据源方法

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.tableViewDataArray[tableView.tag] count];
//    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 编辑精选
    if (tableView == self.tabelViewArray[0]) {
        EditModel *model = self.tableViewDataArray[0][indexPath.row];
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
    static NSString *ID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 编辑精选
    if (tableView == self.tabelViewArray[0]) {
        EditModel *model = self.tableViewDataArray[0][indexPath.row];
        switch ([model.type intValue]) {
            case 1:
            {
                return 180;
            }
                break;
            case 2:
            {
                return 80;
            }
                break;
            case 3:
            {
                return 80;
            }
                break;
            case 4:
            {
                return 80;
            }
                break;
                
            case 5:
            {
                return 80;
            }
                break;
            case 6:
            {
                return 80;
            }
                break;
            case 7:
            {
                return 80;
            }
                break;
            default:
                break;
        }
    }
    return 100;
}

#pragma mark - tableView代理方法
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.tabelViewArray[0]) {
        EditModel *model = self.tableViewDataArray[0][indexPath.row];
        EditListModel *listModel = [model.listArr lastObject];
        NSString *url = [NSString stringWithFormat:@"http://mappv4.caixin.com/article/%@.html?fontsize=1", listModel.ID];
        DescVC *desc =  [[DescVC alloc] init];
        desc.url = url;
        [self.navigationController pushViewController:desc animated:YES];
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
    NSArray *array = @[@"编辑精选" ,@"我的订阅", @"最新文章"];
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
- (void)createTitleBtnWithTitle:(NSString *)title tag:(int)tag urlStr:(NSString *)urlStr
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

- (void)requestTableViewDataWithTag:(int)tag
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
    NSLog(@"%@", btn.titleLabel.text);
    // 解析数据
    [RequestTool requestWithURL:btn.requestUrl Success:^(id responseObject) {
        if ([btn.titleLabel.text isEqualToString:@"编辑精选"]) {
            
            // 数据转模型
            NSArray *array = responseObject[@"data"];
            NSMutableArray *arrM = [NSMutableArray array];
            for (NSDictionary *dict in array) {
                EditModel *model = [EditModel modelWithDict:dict];
                [arrM addObject:model];
            }
            [self.tableViewDataArray[btn.tag] addObjectsFromArray:arrM];
            
            // 刷新tableview
            UITableView *tableView = self.tabelViewArray[btn.tag];
            [tableView reloadData];
        }
    } failure:^(NSError *error) {
        NSLog(@"%@", error);
    }];
}

#pragma mark - scrollView代理
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if (scrollView == self.listScrollView) {
        // 监听分list滚动位置 点击title
        int index = scrollView.contentOffset.x/CGW(self.listScrollView);
        [self titleBtnClicked:self.titleBtnArray[index]];
    }
}



@end
