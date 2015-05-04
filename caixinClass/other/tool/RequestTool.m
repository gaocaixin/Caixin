//
//  RequestTool.m
//  YouQuLai
//
//  Created by gaocaixin on 15/4/14.
//  Copyright (c) 2015年 GCX. All rights reserved.
//

#import "RequestTool.h"
#import "AFNTool.h"
#import "AFNetworking.h"
#import "MyMD5.h"

@implementation RequestTool
// 请求频道标题
+ (void)requestTitleListSuccess:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure
{
    NSString *url = @"http://mappv4.caixin.com/channel_list/index.json";
    
    [self requestWithURL:url isUpData:NO Success:^(id responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

// 请求订阅栏目
+ (void)requestSubListSuccess:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure
{
    NSString *url = @"http://mappv4.caixin.com/subscribe_list/index.json";
    
    [self requestWithURL:url isUpData:YES Success:^(id responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

+ (void)requestWithURL:(NSString *)urlStr isUpData:(BOOL)is Success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure
{
    NSLog(@"%@", urlStr);
    NSFileManager *manager = [NSFileManager defaultManager];
    // 文件路径
    NSString *cachePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
    NSString *tempUrlStr = [MyMD5 md5:urlStr];
    NSString *filePath = [cachePath stringByAppendingPathComponent:tempUrlStr];
//    NSLog(@"%@", filePath);
    if (is) {
        // 存在文件
    if ([manager fileExistsAtPath:filePath]) {
        // 删除原有
        [manager removeItemAtPath:filePath error:nil];
        }
    }
    if (![manager fileExistsAtPath:filePath]) {
        // 文件不存在
        // 下载数据
        NSURL *url = [NSURL URLWithString:urlStr];
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
        operation.inputStream = [NSInputStream inputStreamWithURL:url];
        operation.outputStream  = [NSOutputStream outputStreamToFileAtPath:filePath append:NO];
        
        // 成功
        [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
            if (success) {
                NSData *data = [NSData dataWithContentsOfFile:filePath];
                NSJSONSerialization *json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
//                NSLog(@"%@", json);
                success(json);
            }
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            CXLog(@"%@", error);
            if (failure) {
                failure(error);
            }
        }];
        
        [operation start];
    } else {
        // 文件存在
        if (success) {
            NSData *data = [NSData dataWithContentsOfFile:filePath];
            NSJSONSerialization *json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
//            NSLog(@"%@", json);
            success(json);
        }
    }

}



@end
