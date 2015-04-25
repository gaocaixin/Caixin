//
//  SubscribeModel.h
//  Caixin
//
//  Created by gaocaixin on 15/4/25.
//  Copyright (c) 2015年 CX. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SubscribeModel : NSObject

@property (nonatomic, copy) NSString *icon_url;
/**
 id
 */
@property (nonatomic, copy) NSString *ID;
/**
 组标题
 */
@property (nonatomic, copy) NSString *title;
/**
 子数组
 */
@property (nonatomic ,strong) NSArray *listArr;
// 工厂类
+ (id)modelWithDict:(NSDictionary *)dict;
@end
