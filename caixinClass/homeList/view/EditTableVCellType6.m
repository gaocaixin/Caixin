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
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UIImageView *phototsImageView;
@property (weak, nonatomic) IBOutlet UIImageView *videoImageView;

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
    [self hiddenImage:listModel.article_type];
}

- (void)setSubscribeListModel:(SubscribeListModel *)subscribeListModel
{
    [super setSubscribeListModel:subscribeListModel];
    
    self.timeLabel.text = [subscribeListModel.create_time toTime];
    [self.leftImageView sd_setImageWithURL:[NSURL URLWithString:subscribeListModel.picture_url] placeholderImage:[UIImage imageNamed:@"pic_default"]];
    self.commentLabel.text = subscribeListModel.comment_count;
    self.titleLabel.text = subscribeListModel.title;
    
    [self hiddenImage:subscribeListModel.article_type];
}

- (void)hiddenImage:(NSString *)str
{
    self.phototsImageView.hidden = ([str intValue] != 3);
    self.videoImageView.hidden = ([str intValue] != 2);
}

@end
