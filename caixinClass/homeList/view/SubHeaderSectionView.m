//
//  SubHeaderSectionView.m
//  Caixin
//
//  Created by gaocaixin on 15/4/25.
//  Copyright (c) 2015年 CX. All rights reserved.
//

#import "SubHeaderSectionView.h"
#import "UIImageView+WebCache.h"

@interface SubHeaderSectionView ()

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (weak, nonatomic) IBOutlet UIImageView *titleImage;
- (IBAction)arrorBtn:(UIButton *)sender;

@end

@implementation SubHeaderSectionView

+ (instancetype)subHeaderSectionView
{
    return [[[NSBundle mainBundle] loadNibNamed:@"SubHeaderSectionView" owner:nil options:nil] lastObject];
}

- (void)setModel:(SubscribeModel *)model
{
    _model = model;
    self.titleLabel.text = model.title;
    [self.titleImage sd_setImageWithURL:[NSURL URLWithString:model.icon_url] placeholderImage:[UIImage imageNamed:@"pic_default"]];
}

- (IBAction)arrorBtn:(UIButton *)sender {
    NSLog(@"%@", self.model.ID);
}
@end
