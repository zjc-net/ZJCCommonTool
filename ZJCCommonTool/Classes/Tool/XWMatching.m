//
//  XWMatching.m
//  XWEncapsulation
//
//  Created by wangxiangwei on 17/3/6.
//  Copyright © 2017年 purang. All rights reserved.
//

#import "XWMatching.h"

@implementation XWMatching
//匹配字符里的url 返回range数组
+ (NSArray *)urlRangeArrWithString:(NSString *)string{
    NSString *regulaStr = @"((http[s]{0,1}|ftp)://[a-zA-Z0-9\\.\\-]+\\.([a-zA-Z]{2,4})(:\\d+)?(/[a-zA-Z0-9\\.\\-~!@#$%^&*+?:_/=<>]*)?)|(www.[a-zA-Z0-9\\.\\-]+\\.([a-zA-Z]{2,4})(:\\d+)?(/[a-zA-Z0-9\\.\\-~!@#$%^&*+?:_/=<>]*)?)";
    NSArray *rangeArr = [XWMatching rangeArrWithString:string andMatchingString:regulaStr];
    return rangeArr;
}

//匹配字符里的url 返回url数组
+ (NSArray *)urlArrWithString:(NSString *)string{
    NSArray *rangeArr = [XWMatching urlRangeArrWithString:string];
    NSArray *urlStr_Arr = [XWMatching subRangeStringWithString:string andRangeArr:rangeArr];
    return urlStr_Arr.copy;
}

/**
 *  匹配手机号码
 *  返回手机字符数组
 */
+ (NSArray *)phoneNumArrWithString:(NSString *)string{
    NSArray *phoneRange_Arr = [XWMatching phoneNumRangeArrWithString:string];
    NSArray *phoneNum_Arr = [XWMatching subRangeStringWithString:string andRangeArr:phoneRange_Arr];
    return phoneNum_Arr;
}

/**
 *  @return 手机号码range数组
 */
+ (NSArray *)phoneNumRangeArrWithString:(NSString *)string{
    NSString *regulaStr = @"((\\d{11})|^((\\d{7,8})|(\\d{4}|\\d{3})-(\\d{7,8})|(\\d{4}|\\d{3})-(\\d{7,8})-(\\d{4}|\\d{3}|\\d{2}|\\d{1})|(\\d{7,8})-(\\d{4}|\\d{3}|\\d{2}|\\d{1}))$)";
    NSArray *phoneNumberRange_Arr = [XWMatching rangeArrWithString:string andMatchingString:regulaStr];
    return phoneNumberRange_Arr;
}

/**
 *  匹配邮箱
 * 返回邮箱数组
 */
+ (NSArray *)emailStringArrWithString:(NSString *)string{
    NSArray *emailRange_Arr = [XWMatching emailRangeArrWithString:string];
    NSArray *email_Arr = [XWMatching subRangeStringWithString:string andRangeArr:emailRange_Arr];
    return email_Arr;
}

/**
 *  返回邮箱range数组
 */
+ (NSArray *)emailRangeArrWithString:(NSString *)string{
    NSString *regulaStr = @"([a-zA-Z0-9_\\-\\.]+)@((\\[[0-9]{1,3}\\.[0-9]{1,3}\\.[0-9]{1,3}\\.)|(([a-zA-Z0-9\\-]+\\.)+))([a-zA-Z]{2,4}|[0-9]{1,3})";
    
    NSArray *emailRange_Arr = [XWMatching rangeArrWithString:string andMatchingString:regulaStr];
    return emailRange_Arr;
}

+ (NSArray *)rangeArrWithString:(NSString *)string andMatchingString:(NSString *)matchingString{
    //创建正则表达式
    NSError *error = nil;
    NSRegularExpression *rge = [NSRegularExpression regularExpressionWithPattern:matchingString options:0 error:&error];
    if (error) return nil;
    NSMutableArray *rangeArr = [NSMutableArray array];
    NSInteger index = 0;
    while (true){
        //匹配字符
        NSTextCheckingResult *rs = [rge firstMatchInString:string options:0 range:NSMakeRange(0, string.length)];
        if (rs){
            NSDictionary *ranDic = @{locationKey:@(rs.range.location + index),lengthKey:@(rs.range.length)};
            [rangeArr addObject:ranDic];
            index = (rs.range.length  + rs.range.location +index -1) ;
            string = [string substringFromIndex:(rs.range.length + rs.range.location-1)];
        }else{
            break;
        }
    }
    return rangeArr.copy;
}

+ (NSArray *)subRangeStringWithString:(NSString *)string andRangeArr:(NSArray *)rangeArr{
    NSMutableArray *subStr_Arr = [NSMutableArray array];
    for (NSDictionary *dict in rangeArr){
        int locationI = [dict[locationKey]intValue];
        int lengthI = (int)[dict[lengthKey]integerValue];
        NSRange range = NSMakeRange(locationI, lengthI);
        NSString *subStr = [string substringWithRange:range];
        [subStr_Arr addObject:subStr];
    }
    return subStr_Arr.copy;
}

@end
