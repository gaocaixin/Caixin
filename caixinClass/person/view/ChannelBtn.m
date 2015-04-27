//
//  ChannelBtn.m
//  Caixin
//
//  Created by gaocaixin on 15/4/27.
//  Copyright (c) 2015年 CX. All rights reserved.
//

#import "ChannelBtn.h"

@interface ChannelBtn ()

@property (nonatomic ,weak) UIImageView *addImageView;
@end

@implementation ChannelBtn

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.titleLabel.font = [UIFont systemFontOfSize:13];
    
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
    if (isMy) {
        self.addImageView.hidden = YES;
    }
}

- (void)setTitle:(NSString *)title forState:(UIControlState)state
{
    [super setTitle:title forState:state];
    
    if ([title isEqualToString:@""]) {
        self.addImageView.hidden = YES;
        self.userInteractionEnabled = NO;
    } else {
        self.addImageView.hidden = NO;
        self.userInteractionEnabled = YES;
    }
    if (self.isMy) {
        self.addImageView.hidden = YES;
    }
}

@end
