//
//  EditTableVCellType6.m
//  Caixin
//
//  Created by gaocaixin on 15/4/25.
//  Copyright (c) 2015年 CX. All rights reserved.
//

#import "EditTableVCellType6.h"
#import "UIImageView+WebCache.h"

@interface EditTableVCellType6 ()

@property (weak, nonatomic) IBOutlet UIImageView *leftImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *commentLabel;

@end

@implementation EditTableVCellType6

+ (instancetype)editTableVCell:(UITableView *)tableView
{
    EditTableVCellType6 *type = [tableView dequeueReusableCellWithIdentifier:@"EditTableVCellType6"];
    if (type == nil) {
        type = [[[NSBundle mainBundle] loadNibNamed:@"EditTableVCellType6" owner:nil options:nil] lastObject];
    }
    return type;
}

- (void)setModel:(EditModel *)model
{
    
    [super setModel:model];
    EditListModel *listModel = [model.listArr lastObject];
    [self.leftImageView sd_setImageWithURL:[NSURL URLWithString:listModel.image] placeholderImage:[UIImage imageNamed:@"pic_default"]];
    self.titleLabel.text = listModel.title;
    self.commentLabel.text = listModel.comment;
}

@end
