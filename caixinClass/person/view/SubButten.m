//
//  SubButten.m
//  Caixin
//
//  Created by gaocaixin on 15/4/28.
//  Copyright (c) 2015年 CX. All rights reserved.
//

#import "SubButten.h"
#import "SubListModel.h"
#import "UIImageView+WebCache.h"

@interface SubButten ()
@property (nonatomic ,weak) UIImageView *addImageView;
@end

@implementation SubButten

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.titleLabel.font = [UIFont systemFontOfSize:13];

//        self.backgroundColor = [UIColor redColor];
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(frame.size.width/2-10, 0, CGW(self)/2, CGH(self))];
        imageView.image = [UIImage imageNamed:@"btn_add_channel"];
        imageView.contentMode = UIViewContentModeRight;
        //        imageView.backgroundColor = [UIColor yellowColor];
        self.addImageView = imageView;
        [self addSubview:imageView];
    }
    return self;
}

- (void)setIsMy:(BOOL)isMy
{
    _isMy = isMy;
    if (isMy == YES) {
        self.addImageView.hidden = YES;
    }
}

- (void)setModel:(SubListModel *)model
{
    _model = model;
    
    [self setTitle:model.title forState:UIControlStateNormal];
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:model.icon_url]];
    if (model == nil) {
        self.addImageView.hidden = YES;
    } else {
        self.addImageView.hidden = NO;
    }
    if (self.isMy == YES) {
        self.addImageView.hidden = YES;
    }
}

@end
