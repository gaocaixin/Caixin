//
//  SubListModel.h
//  Caixin
//
//  Created by gaocaixin on 15/4/28.
//  Copyright (c) 2015年 CX. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SubListModel : NSObject

/**
 "icon_url" : "http://file.caixin.com/images/m/finance_logo.png",
 "id" : "166",
 "title" : "金融混业观察"
 */

@property (nonatomic, copy) NSString *icon_url;
@property (nonatomic, copy) NSString *ID;
@property (nonatomic, copy) NSString *title;

@end
