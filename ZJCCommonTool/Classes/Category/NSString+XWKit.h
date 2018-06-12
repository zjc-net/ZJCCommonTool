//
//  NSString+XWKit.h
//  PurangFinanceVillage
//
//  Created by wangxiangwei on 17/2/20.
//  Copyright © 2017年 ___PURANG___. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (XWKit)
/**
 *
 *  是否是数字     0-9
 */
- (BOOL)isNumberOneCharacterAtIndex:(NSUInteger)index;
/**
 *
 *  是否是中文
 */
- (BOOL)isHanZiOneCharacterAtIndex:(NSUInteger)index;
/**
 *
 *  是否是字母   A-Z|a-z
 */
- (BOOL)isLettersCharacterAtIndex:(NSUInteger)index;
/**
 *
 *  是否是标点符号
 */
- (BOOL)isPunctOneCharacterAtIndex:(NSUInteger)index;

/**
 *
 *  是否是ascii码   0x00-0x7F
 */
- (BOOL)isASCIIOneCharacterAtIndex:(NSUInteger)index;

/**
 *  正则匹配用户姓名,20位的中文或英文
 */
+ (BOOL)isUserName:(NSString *)userName;

/**
 *  正则匹配用户身份证号
 */
+ (BOOL)isUserIdCard:(NSString *)idCard;

/**
 *  正则匹配银行卡号
 */
+ (BOOL)isBankCardNumber:(NSString *)bankNumber;

/**
 *   正则匹配手机号
 */
+ (BOOL)isMobilePhone:(NSString *)phoneNum;

@end
