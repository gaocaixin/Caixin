//
//  AFNTool.m
//  YouQuLai
//
//  Created by gaocaixin on 15/4/14.
//  Copyright (c) 2015年 GCX. All rights reserved.
//

#import "AFNTool.h"
#import "AFNetworking.h"


@implementation AFNTool

+ (void)GET:(NSString *)URLString parameters:(id)parameters success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    [manager GET:URLString parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        // 有block 调用
        if (success) {
            success(responseObject);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        // 有block就调用
        if (failure) {
            failure(error);
        }
    }];
}

+ (void)POST:(NSString *)URLString parameters:(id)parameters success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    [manager POST:URLString parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        // 有block 调用
        if (success) {
            success(responseObject);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        // 有block就调用
        if (failure) {
            failure(error);
        }
    }];
}



@end
