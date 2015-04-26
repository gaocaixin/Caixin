//
//  DescVC.h
//  Caixin
//
//  Created by gaocaixin on 15/4/25.
//  Copyright (c) 2015年 CX. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EditListModel.h"
#import "SubscribeListModel.h"

@interface DescVC : UIViewController

@property (nonatomic ,strong) EditListModel *listModel;
@property (nonatomic ,strong) SubscribeListModel *subListModel;
@end
