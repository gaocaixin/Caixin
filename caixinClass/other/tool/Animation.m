//
//  Animation.m
//  Caixin
//
//  Created by gaocaixin on 15/4/26.
//  Copyright (c) 2015年 CX. All rights reserved.
//

#import "Animation.h"

@implementation Animation

/**
 派生到我的代码片
 
 animation.type = kCATransitionFade;
 
 animation.type = kCATransitionPush;
 
 animation.type = kCATransitionReveal;
 
 animation.type = kCATransitionMoveIn;
 
 animation.type = @"cube";
 
 animation.type = @"suckEffect";
 
 // 页面旋转
 animation.type = @"oglFlip";
 
 //水波纹
 animation.type = @"rippleEffect";
 
 animation.type = @"pageCurl";
 
 animation.type = @"pageUnCurl";
 
 animation.type = @"cameraIrisHollowOpen";
 
 animation.type = @"cameraIrisHollowClose";
 */



+ (CATransition *)kCATransitionPushFromTop
{
    CATransition *transition = [CATransition animation];
    transition.duration = 0.5;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition.type = kCATransitionPush;
    transition.subtype = kCATransitionFromTop;
    return transition;
}

@end
