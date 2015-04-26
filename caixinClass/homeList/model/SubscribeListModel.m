//
//  SubscribeListModel.m
//  Caixin
//
//  Created by gaocaixin on 15/4/25.
//  Copyright (c) 2015年 CX. All rights reserved.
//

#import "SubscribeListModel.h"

@implementation SubscribeListModel


+ (id)modelWithDict:(NSDictionary *)dict
{
    SubscribeListModel *model = [[SubscribeListModel alloc] init];
    model.author = dict[@"author"];
    model.author_img_url = dict[@"author_img_url"];
    model.comment_count = dict[@"comment_count"];
    model.create_time = dict[@"create_time"];
    model.picture_url = dict[@"picture_url"];
    model.title = dict[@"title"];
    model.web_article_url = dict[@"web_article_url"];
    model.from_web_title = dict[@"from_web_title"];
    model.ID = dict[@"id"];
    return model;
}


@end
