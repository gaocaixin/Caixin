//
//  SubscribeListHeaderVC.m
//  Caixin
//
//  Created by gaocaixin on 15/5/4.
//  Copyright (c) 2015年 CX. All rights reserved.
//

#import "SubscribeListHeaderVC.h"
#import "SubscribeModel.h"
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

@interface SubscribeListHeaderVC () <UITableViewDelegate, UITableViewDataSource, MJRefreshBaseViewDelegate>
// tableView数据源
@property (nonatomic ,strong) NSMutableArray *tableViewDataArray;
@property (nonatomic ,weak) UITableView *tableView;
@property (nonatomic ,weak) MJRefreshHeaderView *header;
@property (nonatomic ,weak) MJRefreshFooterView *footer;

@property (nonatomic, assign) int curPage;
@end

@implementation SubscribeListHeaderVC

- (NSMutableArray *)tableViewDataArray
{
    if (_tableViewDataArray == nil) {
        _tableViewDataArray = [[NSMutableArray alloc] init];
    }
    return _tableViewDataArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = self.model.title;
    self.curPage = 1;
    [self creteTableView];
    [self reloadData];
}

- (void)reloadData
{
    NSString *url = [NSString stringWithFormat:@"http://mappv4.caixin.com/subscribe/list_%@_20_1.json", self.model.ID];
//    NSLog(@"%@", url);
    [self requesttTableViewDataWithStr:url isUpData:NO success:^{} failure:^{}];
}

- (void)requesttTableViewDataWithStr:(NSString *)url isUpData:(int)is success:(void (^)())success failure:(void (^)())failure
{
    [RequestTool requestWithURL:url isUpData:is Success:^(id responseObject) {
        // 数据转模型
        NSArray *array = responseObject[@"data"];
        NSMutableArray *arrM = [NSMutableArray array];
        
        // 数据转模型
        for (NSDictionary *dict in array) {
            SubscribeListModel *model = [SubscribeListModel modelWithDict:dict];
            [arrM addObject:model];
        }
        
        if (is) {
        // 插入下标
        long index = arrM.count-1;
        
        SubscribeListModel *model1 = self.tableViewDataArray[0];
        // 遍历
        for (long i = arrM.count-1; i >= 0; i--) {
            SubscribeListModel *model = arrM[i];
            // 找到相等的下标
            if ([model.ID isEqualToString:model1.ID]) {
                index = i;
            }
        }
        // 插入新数据
        for (long i = index-1; i >= 0; i--) {
            SubscribeListModel *newModel = arrM[i];
            [self.tableViewDataArray insertObject:newModel atIndex:0];
        }
            
    } else {
        [self.tableViewDataArray addObjectsFromArray:arrM];
    }
     
     
     // 刷新tableview
     [self.tableView reloadData];
        
    if (success) {
        success();
    }
     
     } failure:^(NSError *error) {
         if (failure) {
             failure();
         }
     }];

}

- (void)creteTableView
{
    // 创建tableview
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.sectionHeaderHeight = 0;
    tableView.sectionFooterHeight = 0;
    tableView.contentInset = UIEdgeInsetsMake(-35, 0, -19, 0);
//    tableView.bounces = NO;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    MJRefreshHeaderView *headerView = [MJRefreshHeaderView header];
    headerView.scrollView = tableView;
    headerView.delegate = self;
    self.header = headerView;
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
    if ([refreshView isKindOfClass:[MJRefreshHeaderView class]]) {
    // 请求最新数据
    
        NSString *url = [NSString stringWithFormat:@"http://mappv4.caixin.com/subscribe/list_%@_20_1.json", self.model.ID];
        //    NSLog(@"%@", url);
        [self requesttTableViewDataWithStr:url isUpData:YES success:^{
            [refreshView endRefreshing];
        } failure:^{
            [refreshView endRefreshing];
        }];
        
    } else if ([refreshView isKindOfClass:[MJRefreshFooterView class]]) {
    // 上拉加载数据
    
    self.curPage ++;
    NSString *url = [NSString stringWithFormat:@"http://mappv4.caixin.com/subscribe/list_%@_20_%d.json", self.model.ID,self.curPage];
        
    [self requesttTableViewDataWithStr:url isUpData:NO success:^{
        [refreshView endRefreshing];
    } failure:^{
        [refreshView endRefreshing];
    }];
}

}
- (void)dealloc
{
    [self.header free];
    [self.footer free];
//    NSLog(@"dealloc");
}

@end
