//
//  EditTableVCellType5.h
//  Caixin
//
//  Created by gaocaixin on 15/4/25.
//  Copyright (c) 2015年 CX. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EditTableVCellType.h"

@protocol EditTableVCellType5Delegate <NSObject>

- (void)editTableVCellType5ButtenClicked:(EditListModel *)model;

@end

@interface EditTableVCellType5 : EditTableVCellType

@property (nonatomic ,weak) id<EditTableVCellType5Delegate> delegate;

@end
