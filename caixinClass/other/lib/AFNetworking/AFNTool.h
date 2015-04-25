//
//  AFNTool.h
//  YouQuLai
//
//  Created by gaocaixin on 15/4/14.
//  Copyright (c) 2015年 GCX. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AFNTool : NSObject

+ (void)GET:(NSString *)URLString parameters:(id)parameters success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure;

+ (void)POST:(NSString *)URLString parameters:(id)parameters success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure;

@end
