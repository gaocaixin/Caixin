//
//  EditTableVCellType1.m
//  Caixin
//
//  Created by gaocaixin on 15/4/25.
//  Copyright (c) 2015年 CX. All rights reserved.
//

#import "EditTableVCellType1.h"
#import "UIImageView+WebCache.h"

@interface EditTableVCellType1 ()
@property (weak, nonatomic) IBOutlet UIImageView *bgImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *photosImageView;

@end

@implementation EditTableVCellType1

- (void)awakeFromNib {
    [super awakeFromNib];
}


+ (instancetype)editTableVCell:(UITableView *)tableView
{
    EditTableVCellType1 *type1 = [tableView dequeueReusableCellWithIdentifier:@"EditTableVCellType1"];
    if (type1 == nil) {
        type1 = [[[NSBundle mainBundle] loadNibNamed:@"EditTableVCellType1" owner:nil options:nil] lastObject];
    }
    return type1;
}


- (void)setModel:(EditModel *)model
{
    [super setModel:model];
    
    EditListModel *listModel = [model.listArr lastObject];
    [self.bgImageView sd_setImageWithURL:[NSURL URLWithString:listModel.image] placeholderImage:[UIImage imageNamed:@"pic_loaderror"]];
    self.titleLabel.text = listModel.title;
    
    self.photosImageView.hidden = ([listModel.article_type intValue] != 3);
}


@end
