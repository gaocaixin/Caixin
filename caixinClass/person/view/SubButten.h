//
//  SubButten.h
//  Caixin
//
//  Created by gaocaixin on 15/4/28.
//  Copyright (c) 2015年 CX. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SubListModel;

@interface SubButten : UIButton
@property (nonatomic ,strong) SubListModel *model;

@property (nonatomic, assign) BOOL isMy;
@end
