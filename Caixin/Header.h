//
//  Header.h
//  Caixin
//
//  Created by gaocaixin on 15/4/24.
//  Copyright (c) 2015年 CX. All rights reserved.
//

#ifndef Caixin_Header_h
#define Caixin_Header_h

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

// 判读是否是ios7
#define iOS7   ([[UIDevice currentDevice].systemVersion doubleValue] >= 7.0)
// 自定义log
#ifdef DEBUG
#define CXLog(...) NSLog(__VA_ARGS__)
#else
#define CXLog(...)
#endif
// 宽度
#define CGW(view)               view.bounds.size.width
#define CGH(view)               view.bounds.size.height
#define CGX(rect)               rect.origin.x
#define CGY(rect)               rect.origin.y

#define HEIGHT_NAV              44
#define HEIGHT_STA              20
#define HEIGHT_TOOLBAR          49


#define NickNameFont 15
#define TimeLabelFont 12

#define kScreenWidth [[UIScreen mainScreen]bounds].size.width
#define kScreenHeight [[UIScreen mainScreen]bounds].size.height

#define CXColor(a,b,c) [UIColor colorWithRed:a/255.0 green:b/255.0 blue:c/255.0 alpha:1]

#endif
