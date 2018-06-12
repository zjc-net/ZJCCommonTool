//
//  NSDate+Extensions.h
//  PurangFinanceVillage-Bank
//
//  Created by wangyilu on 16/1/27.
//  Copyright © 2016年 ___PURANG___. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (Extensions)

+(NSDate*)addMonthDate:(NSDate*) now withMonths:(NSInteger) months;

+(NSDate*)addDayDate:(NSDate*) now withDays:(NSInteger) days;

+(NSString *)getCurrentyear;

+(NSString *)getCurrentMonth;

+(NSString *)getCurrentDay;

+(NSString *)getCurrentHours;

+(NSString *)getCurrentDateString;

-(NSString *)formatDateString;

/**
 * 获得年-月-日
 */
+ (NSString *)getYearMonthDayString;

/**
 * 获得年-月
 */
- (NSString *)formatDateYearAndMonthString;


/**
 *  NSDate -> NSString  yyyy-MM-dd
 *
 *  @param date
 */
+ (NSString *)getYearMonthDayWithNSDate:(NSDate *)date;

/**
 * 获得某日期的时间差
 *
 *  @param time  时间间隔
 *  @param time  年-月-日
 */
+ (NSString *)getDateWithTimeInterval:(NSTimeInterval)time dayStr:(NSString *)dayStr;

/**
 * 获得某日期的是'星期几'
 *
 *  @param date  日期
 */
+ (NSString *)weekdayStringFromDate:(NSDate *)date;

/**
 *  当前时间与给定时间timeString的时间【日】差
 *
 *  @param timeString 年-月-日
 */
+ (NSString *)daysFromTimeString:(NSString *)timeString;
@end
