//
//  NSString+ToTimeStr.m
//  Caixin
//
//  Created by gaocaixin on 15/4/27.
//  Copyright (c) 2015年 CX. All rights reserved.
//

#import "NSString+ToTimeStr.h"

@implementation NSString (ToTimeStr)

- (NSString *)toTime
{
    
    // 日历
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    int unit = NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    
    // 获取当前时间的年月日
    NSDate *nowDate = [NSDate date];
    NSDateComponents *nowCmps = [calendar components:unit fromDate:nowDate];
    
    // 获取发布时间的年月日
    NSDate *createDate = [NSDate dateWithTimeIntervalSince1970:[self doubleValue]];
    NSDateComponents *createCmps = [calendar components:unit fromDate:createDate];
    
    // 返回时间
    if (nowCmps.year != createCmps.year || nowCmps.month != createCmps.month || nowCmps.day != createCmps.day) {
        return [NSString stringWithFormat:@"%d年%d月%d日", createCmps.year, createCmps.month, createCmps.day];
    } else if (nowCmps.hour != createCmps.hour) {
        return [NSString stringWithFormat:@"%d小时前", nowCmps.hour-createCmps.hour];
    } else if (nowCmps.minute != createCmps.minute) {
        return [NSString stringWithFormat:@"%d分钟前", nowCmps.minute-createCmps.minute];
    } else {
        return [NSString stringWithFormat:@"%d秒前", nowCmps.second-createCmps.second];
    }
    
}
@end
