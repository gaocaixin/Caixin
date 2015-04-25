//
//  TitleModel.m
//  Caixin
//
//  Created by gaocaixin on 15/4/24.
//  Copyright (c) 2015年 CX. All rights reserved.
//

#import "TitleModel.h"

@implementation TitleModel

+ (id)modelWithDict:(NSDictionary *)dict
{
    TitleModel *model = [[TitleModel alloc] init];
    model.title = dict[@"title"];
    model.ID = dict[@"id"];
    model.show_type = (int)dict[@"show_type"];
    return model;
}

@end
