//
//  EditTableVCellType4.m
//  Caixin
//
//  Created by gaocaixin on 15/4/25.
//  Copyright (c) 2015年 CX. All rights reserved.
//

#import "EditTableVCellType4.h"

@interface EditTableVCellType4 ()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *commentLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@end

@implementation EditTableVCellType4

+ (instancetype)editTableVCell:(UITableView *)tableView
{
    EditTableVCellType4 *type = [tableView dequeueReusableCellWithIdentifier:@"EditTableVCellType4"];
    if (type == nil) {
        type = [[[NSBundle mainBundle] loadNibNamed:@"EditTableVCellType4" owner:nil options:nil] lastObject];
    }
    return type;
}

- (void)setModel:(EditModel *)model
{
    [super setModel:model];
    
    EditListModel *leftListModel = [model.listArr firstObject];
    self.titleLabel.text = leftListModel.title;
    self.commentLabel.text = leftListModel.comment;
    
}


- (void)setSubscribeListModel:(SubscribeListModel *)subscribeListModel
{
    [super setSubscribeListModel:subscribeListModel];
    
    self.timeLabel.text = subscribeListModel.create_time;
    self.commentLabel.text = subscribeListModel.comment_count;
    self.titleLabel.text = subscribeListModel.title;
}


@end
