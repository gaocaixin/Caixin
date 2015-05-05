//
//  EditTableVCellType8.m
//  Caixin
//
//  Created by gaocaixin on 15/4/25.
//  Copyright (c) 2015年 CX. All rights reserved.
//

#import "EditTableVCellType8.h"
#import "UIImageView+WebCache.h"

@interface EditTableVCellType8 ()
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UIImageView *leftImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *commentLabel;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@end

@implementation EditTableVCellType8

- (void)awakeFromNib
{
    [super awakeFromNib];
    self.leftImageView.layer.cornerRadius = CGW(self.leftImageView)/2;
    self.leftImageView.layer.masksToBounds = YES;
}

+ (instancetype)editTableVCell:(UITableView *)tableView
{
    EditTableVCellType8 *type = [tableView dequeueReusableCellWithIdentifier:@"EditTableVCellType8"];
    if (type == nil) {
        type = [[[NSBundle mainBundle] loadNibNamed:@"EditTableVCellType8" owner:nil options:nil] lastObject];
    }
    return type;
}

- (void)setSubscribeListModel:(SubscribeListModel *)subscribeListModel
{
    [super setSubscribeListModel:subscribeListModel];
    
    self.timeLabel.text = [subscribeListModel.create_time toTime];
    [self.leftImageView sd_setImageWithURL:[NSURL URLWithString:subscribeListModel.author_img_url] placeholderImage:[UIImage imageNamed:@"pic_loaderror"]];
    self.nameLabel.text = subscribeListModel.author;
    self.commentLabel.text = subscribeListModel.comment_count;
    self.titleLabel.text = subscribeListModel.title;
}


@end
