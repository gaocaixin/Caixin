//
//  EditTableVCellType.m
//  Caixin
//
//  Created by gaocaixin on 15/4/25.
//  Copyright (c) 2015年 CX. All rights reserved.
//

#import "EditTableVCellType.h"


@implementation EditTableVCellType

- (void)awakeFromNib {
    // Initialization code
//    CGRect rect = self.frame;
//    rect.size.width = SCREEN_WIDTH;
//    self.frame = rect;
//    self.backgroundColor = [UIColor redColor];
    [self setSelectionStyle:UITableViewCellSelectionStyleNone];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}





@end
