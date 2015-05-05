//
//  EditTableVCellType5.m
//  Caixin
//
//  Created by gaocaixin on 15/4/25.
//  Copyright (c) 2015年 CX. All rights reserved.
//

#import "EditTableVCellType5.h"

@interface EditTableVCellType5 ()<UIGestureRecognizerDelegate>

@property (weak, nonatomic) IBOutlet UILabel *leftTitleLabel;

@property (weak, nonatomic) IBOutlet UILabel *leftCommentLabel;
@property (weak, nonatomic) IBOutlet UILabel *rightTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *rightCommentLabel;
@property (weak, nonatomic) IBOutlet UIButton *leftBtn;
@property (weak, nonatomic) IBOutlet UIButton *rightBtn;
- (IBAction)leftBtnClick:(UIButton *)sender;
- (IBAction)rightBtnClick:(UIButton *)sender;

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



- (IBAction)leftBtnClick:(UIButton *)sender {
    
    if ([self.delegate respondsToSelector:@selector(editTableVCellType5ButtenClicked:)]) {
        EditListModel *leftListModel = [self.model.listArr firstObject];
        [self.delegate editTableVCellType5ButtenClicked:leftListModel];
    }
}

- (IBAction)rightBtnClick:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(editTableVCellType5ButtenClicked:)]) {
        EditListModel *rightListModel = [self.model.listArr lastObject];
        [self.delegate editTableVCellType5ButtenClicked:rightListModel];
    }
}

@end
