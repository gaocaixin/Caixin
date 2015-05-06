//
//  SearchVC.m
//  Caixin
//
//  Created by gaocaixin on 15/5/4.
//  Copyright (c) 2015年 CX. All rights reserved.
//

#import "SearchVC.h"
#import "SubscribeListModel.h"
#import "EditTableVCellType1.h"
#import "EditTableVCellType2.h"
#import "EditTableVCellType3.h"
#import "EditTableVCellType4.h"
#import "EditTableVCellType5.h"
#import "EditTableVCellType6.h"
#import "EditTableVCellType7.h"
#import "EditTableVCellType8.h"
#import "RequestTool.h"
#import "MJRefresh.h"
#import "DescVC.h"
#import "MBProgressHUD+MJ.h"

#define SEARCH_HEIGHT 40
@interface SearchVC ()<UITableViewDelegate, UITableViewDataSource, MJRefreshBaseViewDelegate>

@property (nonatomic ,strong) NSMutableArray *tableViewDataArray;
@property (nonatomic ,weak) UITableView *tableView;
@property (nonatomic ,weak) MJRefreshHeaderView *header;
@property (nonatomic ,weak) MJRefreshFooterView *footer;

@property (nonatomic, assign) int curPage;

@property (nonatomic ,weak) UITextField *tetField;
@property (nonatomic ,weak) UIButton *categoryBtn;

@property (nonatomic ,weak) UIView *categoryView;

@end

@implementation SearchVC

-(NSMutableArray *)tableViewDataArray
{
    if (_tableViewDataArray == nil) {
        _tableViewDataArray = [[NSMutableArray alloc] init];
    }
    return _tableViewDataArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUp];
//    [self createCatagoryView];
    [self creteTableView];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 40, 30)];
    label.text = @"搜索";
    label.font = [UIFont boldSystemFontOfSize:16];
    label.textColor = [UIColor blackColor];
    self.navigationItem.titleView = label;
    
}
/**
 创建分类view
 */
- (void)createCatagoryView
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetMinX(self.categoryBtn.frame), CGRectGetMaxY(self.categoryBtn.frame), CGW(self.categoryBtn), CGH(self.categoryBtn) * 4)];
    view.backgroundColor = [UIColor blackColor];
    self.categoryView = view;
    [self.view.window addSubview:view];
    
    NSArray *arr = @[@"全部", @"图片", @"视频", @"博客"];
    CGFloat W = CGW(self.categoryBtn);
    CGFloat H = CGH(self.categoryBtn);
    CGFloat X = CGRectGetMinX(self.categoryBtn.frame);
    for (int i = 0; i < 4; i++) {
        UIButton *btn = [self createCategoryBtnWithFrame:CGRectMake(X, H*i, W, H) title:arr[i]];
        [view addSubview:btn];
        [btn addTarget:self action:@selector(categoryViewBtn:) forControlEvents:UIControlEventTouchUpInside];
    }
    NSLog(@"%@", NSStringFromCGRect(self.categoryView.frame));
}

- (void)setUp
{
    self.view.backgroundColor = [UIColor whiteColor];
    // 分类btn
    UIButton *categoryBtn = [self createCategoryBtnWithFrame:CGRectMake(0, HEIGHT_STA + HEIGHT_NAV, 80, SEARCH_HEIGHT) title:@"全部"];
    [categoryBtn addTarget:self action:@selector(categoryBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:categoryBtn];
    self.categoryBtn = categoryBtn;

    // 搜索背景
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(categoryBtn.frame), CGRectGetMinY(categoryBtn.frame), CGW(self.view) - CGW(categoryBtn), SEARCH_HEIGHT)];
    view.backgroundColor = CXColor(50, 50, 255);
    [self.view addSubview:view];
    
    // 输入框
    UITextField *text = [[UITextField alloc] initWithFrame:CGRectMake(5, 0, CGW(view) - 2 * SEARCH_HEIGHT - 2*5, SEARCH_HEIGHT)];
    text.textColor = [UIColor whiteColor];
    NSDictionary *dict = @{NSForegroundColorAttributeName : [UIColor whiteColor], NSFontAttributeName : [UIFont systemFontOfSize:14]};
    NSAttributedString *string = [[NSAttributedString alloc] initWithString:@"输入你要搜索的内容" attributes:dict];
    text.attributedPlaceholder = string;
//    text.placeholder = @"输入你要搜索的内容";
    text.keyboardType = UIKeyboardTypeDefault;
    [view addSubview:text];
    self.tetField = text;
    
    // 下划线
    UIView *xiahuaView = [[UIView alloc] initWithFrame:CGRectMake(0, CGH(text)-8, CGW(text), 1)];
    xiahuaView.backgroundColor = [UIColor whiteColor];
    [text addSubview:xiahuaView];
    
    // 清除btn
    UIButton *clearBtn = [[UIButton alloc] initWithFrame:CGRectMake(CGW(view)-2*SEARCH_HEIGHT, 0, SEARCH_HEIGHT, SEARCH_HEIGHT)];
    [clearBtn addTarget:self action:@selector(clearBtn) forControlEvents:UIControlEventTouchUpInside];
    [clearBtn setImage:[UIImage imageNamed:@"icon_setting_search_cancel"] forState:UIControlStateNormal];
    [view addSubview:clearBtn];
    
    // 搜索btn
    UIButton *searchBtn = [[UIButton alloc] initWithFrame:CGRectMake(CGW(view)-SEARCH_HEIGHT, 0, SEARCH_HEIGHT, SEARCH_HEIGHT)];
    [searchBtn setImage:[UIImage imageNamed:@"icon_setting_search_gray"] forState:UIControlStateNormal];
    [searchBtn addTarget:self  action:@selector(searchBtn) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:searchBtn];
}
// 分类btn点击
- (void)categoryBtn:(UIButton *)btn
{
    if (self.categoryView) {
        [self.categoryView removeFromSuperview];
        return;
    }
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetMinX(self.categoryBtn.frame), CGRectGetMaxY(self.categoryBtn.frame), CGW(self.categoryBtn), CGH(self.categoryBtn) * 4)];
    view.backgroundColor = [UIColor blackColor];
    self.categoryView = view;
    [self.view addSubview:view];
    
    NSArray *arr = @[@"全部", @"图片", @"视频", @"博客"];
    CGFloat W = CGW(self.categoryBtn);
    CGFloat H = CGH(self.categoryBtn);
    CGFloat X = CGRectGetMinX(self.categoryBtn.frame);
    for (int i = 0; i < 4; i++) {
        UIButton *btn = [self createCategoryBtnWithFrame:CGRectMake(X, H*i, W, H) title:arr[i]];
        [view addSubview:btn];
        [btn addTarget:self action:@selector(categoryViewBtn:) forControlEvents:UIControlEventTouchUpInside];
    }
//    NSLog(@"%@", NSStringFromCGRect(self.categoryView.frame));

}
// 分类view的btn点击
- (void)categoryViewBtn:(UIButton *)btn
{
    [self.categoryBtn setTitle:btn.titleLabel.text forState:UIControlStateNormal];
    [self.categoryView removeFromSuperview];
}

- (UIButton *)createCategoryBtnWithFrame:(CGRect)frame title:(NSString *)title
{
    UIButton *categoryBtn = [[UIButton alloc] initWithFrame:frame];
    [categoryBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [categoryBtn setTitle:title forState:UIControlStateNormal];
    [categoryBtn setBackgroundColor:CXColor(80, 80, 80)];
    return categoryBtn;
}

- (void)clearBtn
{
    self.tetField.text = @"";
}

- (void)searchBtn
{
    if (self.tetField.text.length <= 0) {
        [MBProgressHUD showError:@"请输入搜索关键字"];
    } else {
        // 初始化
        [self.tableViewDataArray removeAllObjects];
        self.curPage = 1;
        [self.view endEditing:YES];
        [self requestDataSuccess:nil failure:nil];
    }
}

- (void)requestDataSuccess:(void (^)())success failure:(void (^)())failure
{
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    NSString *str = @"http://mapiv4.caixin.com/api.php";
    
    dict[@"m"] = @"api_article";
    dict[@"a"] = @"searchArticleList";
    dict[@"keywords"] = self.tetField.text;
    dict[@"page_number"] = [NSString stringWithFormat:@"%d", self.curPage];
    dict[@"page_size"] = @"20";
    
    if ([self.categoryBtn.titleLabel.text isEqualToString:@"全部"]) {
        
    } else if ([self.categoryBtn.titleLabel.text isEqualToString:@"图片"]) {
        dict[@"channel"] = @"1";
    } else if ([self.categoryBtn.titleLabel.text isEqualToString:@"视频"]) {
        dict[@"channel"] = @"2";
    } else if ([self.categoryBtn.titleLabel.text isEqualToString:@"博客"]) {
        dict[@"channel"] = @"150";
    }
    [self reloadDataWithURL:str parameters:dict success:^{
        if (success) {
            success();
        }
    } failure:^{
        if (failure) {
            failure();
        }
    }];
}


- (void)reloadDataWithURL:(NSString *)url parameters:(NSDictionary *)parameters success:(void (^)())success failure:(void (^)())failure
{
    [RequestTool GET:url parameters:parameters success:^(id responseObject) {
        NSLog(@"%@", url);
        NSLog(@"%@", responseObject);
        
        if ([responseObject[@"data"] count] == 0) {
            [MBProgressHUD showError:@"没有搜索到数据"];
            return;
        }
        
        NSArray *array = responseObject[@"data"][@"normal"];
        NSMutableArray *arrM = [NSMutableArray array];
        
        // 数据转模型
        for (NSDictionary *dict in array) {
            SubscribeListModel *model = [SubscribeListModel modelWithDict:dict];
            [arrM addObject:model];
        }
        [self.tableViewDataArray addObjectsFromArray:arrM];
        // 刷新tableview
        [self.tableView reloadData];
        
        if (success) {
            success();
        }
    } failure:^(NSError *error) {
        NSLog(@"%@", error);
        if (failure) {
            failure();
        }
    }];
    
}

/**
 创建tableview
 */
- (void)creteTableView
{
    // 创建tableview
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, HEIGHT_NAV + HEIGHT_STA+SEARCH_HEIGHT, CGW(self.view), CGH(self.view)-(HEIGHT_NAV + HEIGHT_STA+SEARCH_HEIGHT)) style:UITableViewStyleGrouped];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.sectionHeaderHeight = 0;
    tableView.sectionFooterHeight = 0;
    tableView.contentInset = UIEdgeInsetsMake(-35, 0, -19, 0);
    //    tableView.bounces = NO;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    MJRefreshFooterView *footerView = [MJRefreshFooterView footer];
    footerView.scrollView = tableView;
    footerView.delegate = self;
    self.footer = footerView;
    
    self.tableView = tableView;
    [self.view addSubview:tableView];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.tableViewDataArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    SubscribeListModel *listModel = self.tableViewDataArray[indexPath.section];
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

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    SubscribeListModel *listModel = self.tableViewDataArray[indexPath.section];
    if (listModel.web_article_url.length > 0) {
        DescVC *desc =  [[DescVC alloc] init];
        desc.subListModel = listModel;
        [self.navigationController pushViewController:desc animated:YES];
    }
}

#pragma mark - 刷新代理
- (void)refreshViewBeginRefreshing:(MJRefreshBaseView *)refreshView
{
    if ([refreshView isKindOfClass:[MJRefreshFooterView class]]) {
        // 上拉加载数据
        
        self.curPage ++;
        
        [self requestDataSuccess:^{
            [refreshView endRefreshing];
        } failure:^{
            [refreshView endRefreshing];
        }];
    }
    
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.view endEditing:YES];
}

- (void)dealloc
{
    [self.header free];
    [self.footer free];
    //    NSLog(@"dealloc");
}

@end
