//
//  NSCalendar+PRCalender.h
//  PurangFinance
//
//  Created by liumingkui on 15/5/12.
//  Copyright (c) 2015年 ___PURANG___. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSCalendar (MySpecialCalculations)

- (NSInteger)daysWithinEraFromDate:(NSDate *)startDate toDate:(NSDate *) endDate;

@end
