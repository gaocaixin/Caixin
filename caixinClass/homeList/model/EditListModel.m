//
//  EditListModel.m
//  Caixin
//
//  Created by gaocaixin on 15/4/25.
//  Copyright (c) 2015年 CX. All rights reserved.
//

#import "EditListModel.h"

@implementation EditListModel

+ (id)modelWithDict:(NSDictionary *)dict
{
    EditListModel *model = [[EditListModel alloc] init];
    model.article_type = dict[@"article_type"];
    model.author_name = dict[@"author_name"];
    model.comment = dict[@"comment"];
    model.ID = dict[@"id"];
    model.image = dict[@"image"];
    model.time = dict[@"time"];
    model.title = dict[@"title"];
    model.web_url = dict[@"web_url"];
    return model;
}

@end
