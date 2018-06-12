//
//  NSString+XWKit.m
//  PurangFinanceVillage
//
//  Created by wangxiangwei on 17/2/20.
//  Copyright © 2017年 ___PURANG___. All rights reserved.
//

#import "NSString+XWKit.h"

#define one_char [self characterAtIndex:index]

@implementation NSString (XWKit)
- (BOOL)isNumberOneCharacterAtIndex:(NSUInteger)index{
    return self.length ? isdigit(one_char) : NO;
}

- (BOOL)isLettersCharacterAtIndex:(NSUInteger)index{
    return self.length ? isalpha(one_char) : NO;
}

- (BOOL)isHanZiOneCharacterAtIndex:(NSUInteger)index{
    return ((one_char > 0x4E00) && (one_char < 0x9FFF)) ? YES : NO;
}

- (BOOL)isPunctOneCharacterAtIndex:(NSUInteger)index{
    return ispunct(one_char);
}

- (BOOL)isASCIIOneCharacterAtIndex:(NSUInteger)index{
    return isascii(one_char);
}

+ (BOOL)isUserName:(NSString *)userName{
    NSString *pattern = @"^[a-zA-Z\u4E00-\u9FA5]{1,20}";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",pattern];
    return [pred evaluateWithObject:userName];
}

+ (BOOL)isUserIdCard:(NSString *)idCard{
    NSString *pattern = @"(^[0-9]{15}$)|([0-9]{17}([0-9]|X)$)";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",pattern];
    return [pred evaluateWithObject:idCard];
}

+ (BOOL)isBankCardNumber:(NSString *)bankNumber{
    NSString *pattern = @"^[0-9]{16,19}$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",pattern];
    return [pred evaluateWithObject:bankNumber];
}

+ (BOOL)isMobilePhone:(NSString *)phoneNum{
    NSString *MP = @"^1(3[0-9]|4[57]|5[0-35-9]|8[0-9]|7[06-8])\\d{8}$";
    NSPredicate *pre = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MP];
    return [pre evaluateWithObject:phoneNum];
}

@end
