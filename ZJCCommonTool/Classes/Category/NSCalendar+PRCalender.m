//
//  NSCalendar+PRCalender.m
//  PurangFinance
//
//  Created by liumingkui on 15/5/12.
//  Copyright (c) 2015年 ___PURANG___. All rights reserved.
//

#import "NSCalendar+PRCalender.h"

@implementation NSCalendar (MySpecialCalculations)

- (NSInteger)daysWithinEraFromDate:(NSDate *) startDate toDate:(NSDate *) endDate
{
    NSInteger startDay = [self ordinalityOfUnit:NSCalendarUnitDay
                                       inUnit: NSCalendarUnitEra forDate:startDate];
    NSInteger endDay = [self ordinalityOfUnit:NSCalendarUnitDay
                                     inUnit: NSCalendarUnitEra forDate:endDate];
    return endDay - startDay;
}

@end
