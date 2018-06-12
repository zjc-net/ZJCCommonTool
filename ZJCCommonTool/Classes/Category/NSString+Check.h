//
//  NSString+Check.h
//  Shake
//
//  Created by liumingkui on 14-8-8.
//  Copyright (c) 2014年 ___PURANG___. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString(Check)

- (BOOL)checkPhoneNumInput;
- (BOOL)checkEmailInput;
- (BOOL)checkIdentityCard;
- (BOOL)isBlankString;

/* 判断thing是否为空 为空返回 @"--" */
+ (NSString *)checkEmptyFromThing:(id)thing;

/* 判断thing是否为空 为空返回 @"" */
+ (NSString *)checkEmptyNoneFromThing:(id)thing;

/* 判断thing是否为空 为空返回 @"0" */
+ (NSString *)checkEmptyZeroFromThing:(id)thing;

/* 判断日期 返回  yy-MM dd:HH */
+ (NSString *)checkDateFromThing:(id)thing;

/* 去掉小数点后面的0 */
+ (NSString *)removeFloatAllZero:(NSString *)string;
/* 最多2位小数，去掉小数点后面的0 */
+ (NSString *)removeSecondFloatAllZero:(NSString *)string;
/* +相加的和 */
+ (NSString *)valueCombinedFromThing:(id)thing;
/* 日期 yyyyMMdd —> yyyy-MM-dd */
+ (NSString *)addSpaceMarkWithDateStr:(NSString *)string;

/* 拿到日期 yyyy-MM-dd */
+ (NSString *)searchYearMonthDayString:(NSString *)string;

/* 拿到日期 HH-mm-ss */
+ (NSString*)searchHourMinSecString:(NSString *)string;

/* 拿到字符串最后一位 */
+ (NSString *)lastCharFromString:(NSString *)string;

/* 拿到字符串第一位 */
+ (NSString *)firstCharFromString:(NSString *)string;

/* 拿到字符串最后一位 */
- (NSString *)lastChar;

/* 拿到字符串第一位 */
- (NSString *)firstChar;

- (NSString *)getCharsFromHead:(NSInteger)headIndex toFoot:(NSInteger )footIndex;

/**
 *   正则匹配手机号
 */
+ (BOOL)isMobilePhone:(NSString *)phoneNum;

/**
 *   正则匹配电话号
 */
+ (BOOL)isTelephoneNo:(NSString *)phoneNum;

/**
 *   是否是移动号
 */
+ (BOOL)isChinaMobile:(NSString *)phoneNum;

/**
 *   是否是联通号
 */
+ (BOOL)isChinaUnicom:(NSString *)phoneNum;

/**
 *   是否是电信号
 */
+ (BOOL)isChinaTelecom:(NSString *)phoneNum;

/**
 *   移动 ？联通 ？电信
 */
+ (NSString *)getMobilePhoneServiceProvider:(NSString *)phoneNum;

/**
 *  正则匹配用户密码6-18位数字和字母组合
 */
+ (BOOL)isPassword:(NSString *)password;

/**
 *  正则匹配用户姓名,20位的中文或英文
 */
+ (BOOL)isUserName:(NSString *)userName;

/**
 *  正则匹配用户身份证号
 */
+ (BOOL)isUserIdCard:(NSString *)idCard;

/**
 *  正则匹配邮箱
 */
+ (BOOL)isEmail:(NSString *)email;

/**
 *  正则匹配银行卡号
 */
+ (BOOL)isBankCardNumber:(NSString *)bankNumber;

/**
 *  正则匹配2位小数
 */
+ (BOOL)isFloatPointNumbers:(NSString *)numbers;

/**
 *  正则匹配 对小数位进行判断
 *
 *  @param decimal 小数类型
 */
+ (BOOL)isFloatPointNumbers:(NSString *)numbers decimal:(NSUInteger)decimal;

/**
 *  解析url
 */
- (NSMutableDictionary *)getURLParameters;

/**
 *  以stringArray个数为准，颜色默认值白色，大小14
 */
+ (NSMutableAttributedString *)getAttributeStringWithStringArray:(NSArray *)stringArray colorArray:(NSArray <UIColor *>*)colorArray fontArray:(NSArray *)fontArray;

- (NSString *)pr_checkEmpty;
- (NSString *)pr_checkEmptyWithPlaceholder;
- (NSString *)pr_checkEmptyReplaceString:(NSString *)replace;

/**
 *fontSize 数字文字大小
 *fontSize2 小数点后文字大小
 *fontSize3 整段文字大小
 */
- (NSAttributedString *)getAttributedStringFontSize1:(CGFloat)fontSize fontSize2:(CGFloat)fontSize2 fontSize3:(CGFloat)fontSize3 Color:(UIColor *)Color1 Color2:(UIColor *)Color2 Color3:(UIColor *)Color3;

/** 一段文字部分变色/大小
 *str1 要变色的文字
 *fontSize 整体文字大小
 *fontSize1 变色文字大小
 */
- (NSAttributedString *)getAttributedString:(NSString *)str1 FontSize1:(CGFloat)fontSize fontSize1:(CGFloat)fontSize1  Color:(UIColor *)Color Color1:(UIColor *)Color1;
@end
