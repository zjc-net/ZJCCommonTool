//
//  XWMatching.h
//  XWEncapsulation
//
//  Created by wangxiangwei on 17/3/6.
//  Copyright © 2017年 purang. All rights reserved.
//

#import <Foundation/Foundation.h>

#define locationKey @"location"
#define lengthKey @"length"

@interface XWMatching : NSObject

/**
 *
 *  @return 匹配字符里的url 返回urlString数组
 */
+ (NSArray *)urlArrWithString:(NSString *)string;


/**
 *  @return 匹配字符里的url 返回range字典数组
 *  字典key: locationKey存放range的loction lengthKey存放range的length
 */
+ (NSArray *)urlRangeArrWithString:(NSString *)string;


/**
 *  匹配手机号码
 *  返回手机字符数组
 */
+ (NSArray *)phoneNumArrWithString:(NSString *)string;


/**
 *  @return 手机号码range数组
 */
+ (NSArray *)phoneNumRangeArrWithString:(NSString *)string;



/**
 *  匹配邮箱
 *  返回邮箱数组
 */
+ (NSArray *)emailStringArrWithString:(NSString *)string;


/**
 *  返回邮箱range数组
 */
+ (NSArray *)emailRangeArrWithString:(NSString *)string;

@end
