//
//  EditListModel.h
//  Caixin
//
//  Created by gaocaixin on 15/4/25.
//  Copyright (c) 2015年 CX. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EditListModel : NSObject

/**
 文章类型
 */
@property (nonatomic, copy) NSString *article_type;
/**
 作者
 */
@property (nonatomic, copy) NSString *author_name;
/**
 评论数
 */
@property (nonatomic, copy) NSString *comment;
/**
 文章id 传入下一个页面用
 */
@property (nonatomic, copy) NSString *ID;
/**
 文章主图片
 */
@property (nonatomic, copy) NSString *image;
/**
 副图片
 */
@property (nonatomic, copy) NSString *tag_image;
/**
 创建时间
 */
@property (nonatomic, copy) NSString *time;
/**
 文章标题
 */
@property (nonatomic, copy) NSString *title;
/**
 web加载
 */
@property (nonatomic, copy) NSString *web_url;
// 工厂类
+ (id)modelWithDict:(NSDictionary *)dict;
@end
