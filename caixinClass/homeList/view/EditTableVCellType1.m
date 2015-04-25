//
//  EditTableVCellType1.m
//  Caixin
//
//  Created by gaocaixin on 15/4/25.
//  Copyright (c) 2015年 CX. All rights reserved.
//

#import "EditTableVCellType1.h"
#import "UIImageView+WebCache.h"
#import "EditListModel.h"
#import "EditModel.h"

@interface EditTableVCellType1 ()
@property (weak, nonatomic) IBOutlet UIImageView *bgImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@end

@implementation EditTableVCellType1

- (void)awakeFromNib {
}


+ (instancetype)editTableVCellType1:(UITableView *)tableView
{
    EditTableVCellType1 *type1 = [tableView dequeueReusableCellWithIdentifier:@"EditTableVCellType1"];
    if (type1 == nil) {
        type1 = [[[NSBundle mainBundle] loadNibNamed:@"EditTableVCellType1" owner:nil options:nil] lastObject];
    }
    return type1;
}


- (void)setModel:(EditModel *)model
{
    _model = model;
    EditListModel *listModel = [model.listArr lastObject];
    [self.bgImageView sd_setImageWithURL:[NSURL URLWithString:listModel.image] placeholderImage:nil];
    self.titleLabel.text = listModel.title;
}


@end