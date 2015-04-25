//
//  EditTableVCellType3.m
//  Caixin
//
//  Created by gaocaixin on 15/4/25.
//  Copyright (c) 2015年 CX. All rights reserved.
//

#import "EditTableVCellType3.h"
#import "UIImageView+WebCache.h"

@interface EditTableVCellType3 ()
@property (weak, nonatomic) IBOutlet UIImageView *futuImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *commendLabel;
@property (weak, nonatomic) IBOutlet UIImageView *rightImageView;

@end

@implementation EditTableVCellType3

+ (instancetype)editTableVCell:(UITableView *)tableView
{
    EditTableVCellType3 *type3 = [tableView dequeueReusableCellWithIdentifier:@"EditTableVCellType3"];
    if (type3 == nil) {
        type3 = [[[NSBundle mainBundle] loadNibNamed:@"EditTableVCellType3" owner:nil options:nil] lastObject];
    }
    return type3;
}


- (void)setModel:(EditModel *)model
{
    [super setModel:model];
    EditListModel *listModel = [model.listArr lastObject];
    [self.rightImageView sd_setImageWithURL:[NSURL URLWithString:listModel.image] placeholderImage:[UIImage imageNamed:@"pic_default"]];
    self.titleLabel.text = listModel.title;
    self.commendLabel.text = listModel.comment;
    
    if (listModel.tag_image.length > 0) {
        [self.futuImageView setHidden:NO];
        [self.futuImageView sd_setImageWithURL:[NSURL URLWithString:listModel.tag_image] placeholderImage:[UIImage imageNamed:@"pic_default"]];
        
//        CGRect rect = self.titleLabel.frame;
//        rect.origin.x = 30;
//        self.titleLabel.frame = rect;
    } else {
//        [self.futuImageView setHidden:YES];
//        CGRect rect = self.titleLabel.frame;
//        rect.origin.x = 10;
//        self.titleLabel.frame = rect;
    }
}

@end
