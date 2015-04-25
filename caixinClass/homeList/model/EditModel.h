//
//  EditModel.h
//  Caixin
//
//  Created by gaocaixin on 15/4/25.
//  Copyright (c) 2015年 CX. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EditModel : NSObject

/**
 "entity" : [
 {
 "article_type" : "1",
 "author_name" : "财新记者 刘彩萍",
 "comment" : "9",
 "id" : "265042",
 "image" : "http://img.caixin.com/2015-03-30/1427781935406468_660_440.jpg",
 "tag_image" : "",
 "time" : "1429839569",
 "title" : "【特别报道】新三板风险积聚，需未雨绸缪"
 }
 ],
 "type" : "1"
 */

/**
编辑模型数组
*/
@property (nonatomic ,strong) NSArray *listArr;

/**
 cell类型
 */
@property (nonatomic, copy) NSString *type;

// 工厂类
+ (id)modelWithDict:(NSDictionary *)dict;
@end
