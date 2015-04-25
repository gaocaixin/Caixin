//
//  EditModel.m
//  Caixin
//
//  Created by gaocaixin on 15/4/25.
//  Copyright (c) 2015年 CX. All rights reserved.
//

#import "EditModel.h"
#import "EditListModel.h"

@implementation EditModel

+ (id)modelWithDict:(NSDictionary *)dict
{
    EditModel *model = [[EditModel alloc] init];
    NSArray *arr = dict[@"entity"];
    // 转化模型
    NSMutableArray *arrM = [NSMutableArray array];
    for (NSDictionary *listDict in arr) {
        EditListModel *listModel = [EditListModel modelWithDict:listDict];
        [arrM addObject:listModel];
    }
    model.listArr = arrM;
    model.type = dict[@"type"];
    return model;
}

@end
