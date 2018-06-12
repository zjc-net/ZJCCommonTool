//
//  NSString+Currency.m
//  字符串
//
//  Created by 刘明魁 on 14/12/11.
//  Copyright (c) 2014年 liumingkui. All rights reserved.
//

#import "NSString+Currency.h"

@implementation NSString (Currency)

- (NSString*)changeToCurrencyString
{
    NSNumberFormatter *formatter= [[NSNumberFormatter alloc]init];
    formatter.numberStyle = NSNumberFormatterDecimalStyle;
    NSNumber* number = [formatter numberFromString:self];
    if (number) {
        NSString* newString = [formatter stringFromNumber:number];
        return newString;
    }
    return self;
}

@end
