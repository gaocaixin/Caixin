//
//  EditTableVCellType.h
//  Caixin
//
//  Created by gaocaixin on 15/4/25.
//  Copyright (c) 2015年 CX. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EditModel.h"
#import "EditListModel.h"
#import "SubscribeListModel.h"

@interface EditTableVCellType : UITableViewCell


+ (instancetype)editTableVCell:(UITableView *)tableView;

@property (nonatomic ,strong) EditModel *model;

@property (nonatomic ,strong) SubscribeListModel *subscribeListModel;

@end
