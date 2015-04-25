//
//  SubscribeListModel.h
//  Caixin
//
//  Created by gaocaixin on 15/4/25.
//  Copyright (c) 2015年 CX. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SubscribeListModel : NSObject

@property (nonatomic, copy) NSString *article_permission;
@property (nonatomic, copy) NSString *article_type;
@property (nonatomic, copy) NSString *audio_url;
/**
 记者名字
 */
@property (nonatomic, copy) NSString *author;
/**
 记者头像 优先使用
 */
@property (nonatomic, copy) NSString *author_img_url;
@property (nonatomic, copy) NSString *category_id;
@property (nonatomic, copy) NSString *channel_id;
@property (nonatomic, copy) NSString *cms_keywords;
/**
 评论
 */
@property (nonatomic, copy) NSString *comment_count;
/**
 创建时间
 */
@property (nonatomic, copy) NSString *create_time;
@property (nonatomic, copy) NSString *create_user;
@property (nonatomic, copy) NSString *edit_time;
@property (nonatomic, copy) NSString *from_web_title;
@property (nonatomic, copy) NSString *from_web_url;
@property (nonatomic, copy) NSString *ID;
@property (nonatomic, copy) NSString *iphone_add;
@property (nonatomic, copy) NSString *magazine_id;
@property (nonatomic, copy) NSString *media;

@property (nonatomic, copy) NSString *show_type;
@property (nonatomic, copy) NSString *source_id;
@property (nonatomic, copy) NSString *summary;
/**
 优先名字加载
 标题图片
 */
@property (nonatomic, copy) NSString *picture_url;
/**
 标题
 */
@property (nonatomic, copy) NSString *title;
/**
 文章加载
 */
@property (nonatomic, copy) NSString *web_article_url;



// 工厂类
+ (id)modelWithDict:(NSDictionary *)dict;

@end
