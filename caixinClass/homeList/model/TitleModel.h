//
//  TitleModel.h
//  Caixin
//
//  Created by gaocaixin on 15/4/24.
//  Copyright (c) 2015年 CX. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TitleModel : NSObject

/*
 "id" : "8",
 "show_type" : 0,
 "title" : "经济频道#|#Economy"
 */

@property (nonatomic, copy) NSString *ID;

@property (nonatomic, assign) int show_type;

@property (nonatomic, copy) NSString *title;


+ (id)modelWithDict:(NSDictionary *)dict;
@end
