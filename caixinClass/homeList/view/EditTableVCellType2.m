//
//  EditTableVCellType2.m
//  Caixin
//
//  Created by gaocaixin on 15/4/25.
//  Copyright (c) 2015年 CX. All rights reserved.
//

#import "EditTableVCellType2.h"
#import "UIImageView+WebCache.h"

@interface EditTableVCellType2 ()
@property (weak, nonatomic) IBOutlet UIImageView *leftImageView;
@property (weak, nonatomic) IBOutlet UIImageView *futuImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *commentLabel;

@end

@implementation EditTableVCellType2

+ (instancetype)editTableVCell:(UITableView *)tableView
{
    EditTableVCellType2 *type = [tableView dequeueReusableCellWithIdentifier:@"EditTableVCellType2"];
    if (type == nil) {
        type = [[[NSBundle mainBundle] loadNibNamed:@"EditTableVCellType2" owner:nil options:nil] lastObject];
    }
    return type;
}


- (void)setModel:(EditModel *)model
{
    [super setModel:model];
    EditListModel *listModel = [model.listArr lastObject];
    
    [self.leftImageView sd_setImageWithURL:[NSURL URLWithString:listModel.image] placeholderImage:[UIImage imageNamed:@"pic_loaderror"]];
    self.titleLabel.text = listModel.title;
    self.commentLabel.text = listModel.comment;
    
    if (listModel.tag_image.length > 0) {
        [self.futuImageView setHidden:NO];
        [self.futuImageView sd_setImageWithURL:[NSURL URLWithString:listModel.tag_image] placeholderImage:[UIImage imageNamed:@"pic_loaderror"]];
        
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
