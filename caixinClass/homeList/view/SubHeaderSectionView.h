//
//  SubHeaderSectionView.h
//  Caixin
//
//  Created by gaocaixin on 15/4/25.
//  Copyright (c) 2015年 CX. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SubscribeModel.h"
@class SubHeaderSectionView;


@protocol SubHeaderSectionViewDelegate <NSObject>

- (void)subHeaderSectionView:(SubHeaderSectionView *)view titleButtenClicked:(UIButton *)btn;

@end

@interface SubHeaderSectionView : UIView

+ (instancetype)subHeaderSectionView;

@property (nonatomic ,weak) id<SubHeaderSectionViewDelegate> delegate;

@property (nonatomic ,strong) SubscribeModel *model;

@end
