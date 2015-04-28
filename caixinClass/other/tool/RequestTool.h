//
//  RequestTool.h
//  YouQuLai
//
//  Created by gaocaixin on 15/4/14.
//  Copyright (c) 2015年 GCX. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RequestTool : NSObject

// 请求titleList
+ (void)requestTitleListSuccess:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure;

// 请求url数据
+ (void)requestWithURL:(NSString *)urlStr isUpData:(BOOL)is Success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure;

// 请求订阅栏目
+ (void)requestSubListSuccess:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure;

@end
