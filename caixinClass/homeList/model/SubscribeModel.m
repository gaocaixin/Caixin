//
//  SubscribeModel.m
//  Caixin
//
//  Created by gaocaixin on 15/4/25.
//  Copyright (c) 2015年 CX. All rights reserved.
//

#import "SubscribeModel.h"
#import "SubscribeListModel.h"

@implementation SubscribeModel

+ (id)modelWithDict:(NSDictionary *)dict
{
    SubscribeModel *model = [[SubscribeModel alloc] init];
    model.icon_url = dict[@"icon_url"];
    model.ID = dict[@"id"];
    model.title = dict[@"title"];
    
    NSArray *arr = dict[@"article"];
    NSMutableArray *array = [NSMutableArray array];
    for (NSDictionary *dict in arr) {
        SubscribeListModel *listModel = [SubscribeListModel modelWithDict:dict];
        [array addObject:listModel];
    }
    model.listArr = array;
    
    return model;
}

@end
