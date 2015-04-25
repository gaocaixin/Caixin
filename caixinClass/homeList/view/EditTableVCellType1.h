//
//  EditTableVCellType1.h
//  Caixin
//
//  Created by gaocaixin on 15/4/25.
//  Copyright (c) 2015年 CX. All rights reserved.
//

#import <UIKit/UIKit.h>
@class EditModel;

@interface EditTableVCellType1 : UITableViewCell

+ (instancetype)editTableVCellType1:(UITableView *)tableView;

@property (nonatomic ,strong) EditModel *model;

@end
