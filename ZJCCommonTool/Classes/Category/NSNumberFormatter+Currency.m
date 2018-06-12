//
//  NSNumberFormatter+Current.m
//  Shake
//
//  Created by liumingkui on 14-8-12.
//  Copyright (c) 2014年 ___PURANG___. All rights reserved.
//

#import "NSNumberFormatter+Currency.h"

@implementation NSNumberFormatter(Currency)

- (void)numberFormatterCurrencyStyle
{
    [self setFormatterBehavior:NSNumberFormatterBehavior10_4];
    [self setPositiveFormat:@"###0.00"];
    [self setUsesGroupingSeparator:YES];
    [self setGroupingSize:3];
    [self setGroupingSeparator:@" "];
}

- (void)numberFormatterPurchaseStyle
{
    [self setFormatterBehavior:NSNumberFormatterBehavior10_4];
    [self setPositiveFormat:@"#"];
    [self setUsesGroupingSeparator:YES];
    [self setGroupingSize:3];
    [self setGroupingSeparator:@" "];
}

@end
