//
//  EditTableVCellType5.m
//  Caixin
//
//  Created by gaocaixin on 15/4/25.
//  Copyright (c) 2015年 CX. All rights reserved.
//

#import "EditTableVCellType5.h"

@interface EditTableVCellType5 ()

@property (weak, nonatomic) IBOutlet UILabel *leftTitleLabel;

@property (weak, nonatomic) IBOutlet UILabel *leftCommentLabel;
@property (weak, nonatomic) IBOutlet UILabel *rightTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *rightCommentLabel;

@end

@implementation EditTableVCellType5

+ (instancetype)editTableVCell:(UITableView *)tableView
{
    EditTableVCellType5 *type = [tableView dequeueReusableCellWithIdentifier:@"EditTableVCellType5"];
    if (type == nil) {
        type = [[[NSBundle mainBundle] loadNibNamed:@"EditTableVCellType5" owner:nil options:nil] lastObject];
    }
    return type;
}

- (void)setModel:(EditModel *)model
{
    [super setModel:model];
    
    EditListModel *leftListModel = [model.listArr firstObject];
    self.leftTitleLabel.text = leftListModel.title;
    self.leftCommentLabel.text = leftListModel.comment;
    
    EditListModel *rightListModel = [model.listArr lastObject];
    self.rightTitleLabel.text = rightListModel.title;
    self.rightCommentLabel.text = rightListModel.comment;
}

@end
