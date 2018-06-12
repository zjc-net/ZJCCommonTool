//
//  LCDStringContainsEmoji.m
//  BrightSunnySky
//
//  Created by lichuanduo on 17/3/2.
//  Copyright © 2017年 PURANG. All rights reserved.
//

#import "LCDStringContainsEmoji.h"


@implementation LCDStringContainsEmoji
- (BOOL) emojiInUnicodeX:(short)code
{
    if (code == 0x0023
        || code == 0x002A
        || (code >= 0x0030 && code <= 0x0039)
        || code == 0x00A9
        || code == 0x00AE
        || code == 0x203C
        || code == 0x2049
        || code == 0x2122
        || code == 0x2139
        || (code >= 0x2194 && code <= 0x2199)
        || code == 0x21A9 || code == 0x21AA
        || code == 0x231A || code == 0x231B
        || code == 0x2328
        || code == 0x23CF
        || (code >= 0x23E9 && code <= 0x23F3)
        || (code >= 0x23F8 && code <= 0x23FA)
        || code == 0x24C2
        || code == 0x25AA || code == 0x25AB
        || code == 0x25B6
        || code == 0x25C0
        || (code >= 0x25FB && code <= 0x25FE)
        || (code >= 0x2600 && code <= 0x2604)
        || code == 0x260E
        || code == 0x2611
        || code == 0x2614 || code == 0x2615
        || code == 0x2618
        || code == 0x261D
        || code == 0x2620
        || code == 0x2622 || code == 0x2623
        || code == 0x2626
        || code == 0x262A
        || code == 0x262E || code == 0x262F
        || (code >= 0x2638 && code <= 0x263A)
        || (code >= 0x2648 && code <= 0x2653)
        || code == 0x2660
        || code == 0x2663
        || code == 0x2665 || code == 0x2666
        || code == 0x2668
        || code == 0x267B
        || code == 0x267F
        || (code >= 0x2692 && code <= 0x2694)
        || code == 0x2696 || code == 0x2697
        || code == 0x2699
        || code == 0x269B || code == 0x269C
        || code == 0x26A0 || code == 0x26A1
        || code == 0x26AA || code == 0x26AB
        || code == 0x26B0 || code == 0x26B1
        || code == 0x26BD || code == 0x26BE
        || code == 0x26C4 || code == 0x26C5
        || code == 0x26C8
        || code == 0x26CE
        || code == 0x26CF
        || code == 0x26D1
        || code == 0x26D3 || code == 0x26D4
        || code == 0x26E9 || code == 0x26EA
        || (code >= 0x26F0 && code <= 0x26F5)
        || (code >= 0x26F7 && code <= 0x26FA)
        || code == 0x26FD
        || code == 0x2702
        || code == 0x2705
        || (code >= 0x2708 && code <= 0x270D)
        || code == 0x270F
        || code == 0x2712
        || code == 0x2714
        || code == 0x2716
        || code == 0x271D
        || code == 0x2721
        || code == 0x2728
        || code == 0x2733 || code == 0x2734
        || code == 0x2744
        || code == 0x2747
        || code == 0x274C
        || code == 0x274E
        || (code >= 0x2753 && code <= 0x2755)
        || code == 0x2757
        || code == 0x2763 || code == 0x2764
        || (code >= 0x2795 && code <= 0x2797)
        || code == 0x27A1
        || code == 0x27B0
        || code == 0x27BF
        || code == 0x2934 || code == 0x2935
        || (code >= 0x2B05 && code <= 0x2B07)
        || code == 0x2B1B || code == 0x2B1C
        || code == 0x2B50
        || code == 0x2B55
        || code == 0x3030
        || code == 0x303D
        || code == 0x3297
        || code == 0x3299
        // 第二段
        || code == 0x23F0) {
        return YES;
    }
    return NO;
}
/**
 * 一种非官方的, 采用私有Unicode 区域
 * e0 - e5  01 - 59
 */
- (BOOL) emojiInSoftBankUnicodeX:(short)code
{
    return ((code >> 8) >= 0xE0 && (code >> 8) <= 0xE5 && (Byte)(code & 0xFF) < 0x60);
}
+ (BOOL) containEmoji :(NSString *)str
{
    NSUInteger len = [str lengthOfBytesUsingEncoding:NSUTF8StringEncoding];
    if (len < 3) {  // 大于2个字符需要验证Emoji(有些Emoji仅三个字符)
        return NO;
    }
    
    // 仅考虑字节长度为3的字符,大于此范围的全部做Emoji处理
    NSData *data = [str dataUsingEncoding:NSUTF8StringEncoding];
    
    Byte *bts = (Byte *)[data bytes];
    Byte bt;
    short v;
    for (NSUInteger i = 0; i < len; i++) {
        bt = bts[i];
        
        if ((bt | 0x7F) == 0x7F) {  // 0xxxxxxx  ASIIC编码
            continue;
        }
        if ((bt | 0x1F) == 0xDF) {  // 110xxxxx  两个字节的字符
            i += 1;
            continue;
        }
        if ((bt | 0x0F) == 0xEF) {  // 1110xxxx  三个字节的字符(重点过滤项目)
            // 计算Unicode下标
            v = bt & 0x0F;
            v = v << 6;
            v |= bts[i + 1] & 0x3F;
            v = v << 6;
            v |= bts[i + 2] & 0x3F;
            
            //            NSLog(@"%02X%02X", (Byte)(v >> 8), (Byte)(v & 0xFF));
            
            if (((v >> 8) >= 0xE0 && (v >> 8) <= 0xE5 && (Byte)(v & 0xFF) < 0x60) || (v == 0x0023
                                                                                         || v == 0x002A
                                                                                         || (v >= 0x0030 && v <= 0x0039)
                                                                                         || v == 0x00A9
                                                                                         || v == 0x00AE
                                                                                         || v == 0x203C
                                                                                         || v == 0x2049
                                                                                         || v == 0x2122
                                                                                         || v == 0x2139
                                                                                         || (v >= 0x2194 && v <= 0x2199)
                                                                                         || v == 0x21A9 || v == 0x21AA
                                                                                         || v == 0x231A || v == 0x231B
                                                                                         || v == 0x2328
                                                                                         || v == 0x23CF
                                                                                         || (v >= 0x23E9 && v <= 0x23F3)
                                                                                         || (v >= 0x23F8 && v <= 0x23FA)
                                                                                         || v == 0x24C2
                                                                                         || v == 0x25AA || v == 0x25AB
                                                                                         || v == 0x25B6
                                                                                         || v == 0x25C0
                                                                                         || (v >= 0x25FB && v <= 0x25FE)
                                                                                         || (v >= 0x2600 && v <= 0x2604)
                                                                                         || v == 0x260E
                                                                                         || v == 0x2611
                                                                                         || v == 0x2614 || v == 0x2615
                                                                                         || v == 0x2618
                                                                                         || v == 0x261D
                                                                                         || v == 0x2620
                                                                                         || v == 0x2622 || v == 0x2623
                                                                                         || v == 0x2626
                                                                                         || v == 0x262A
                                                                                         || v == 0x262E || v == 0x262F
                                                                                         || (v >= 0x2638 && v <= 0x263A)
                                                                                         || (v >= 0x2648 && v <= 0x2653)
                                                                                         || v == 0x2660
                                                                                         || v == 0x2663
                                                                                         || v == 0x2665 || v == 0x2666
                                                                                         || v == 0x2668
                                                                                         || v == 0x267B
                                                                                         || v == 0x267F
                                                                                         || (v >= 0x2692 && v <= 0x2694)
                                                                                         || v == 0x2696 || v == 0x2697
                                                                                         || v == 0x2699
                                                                                         || v == 0x269B || v == 0x269C
                                                                                         || v == 0x26A0 || v == 0x26A1
                                                                                         || v == 0x26AA || v == 0x26AB
                                                                                         || v == 0x26B0 || v == 0x26B1
                                                                                         || v == 0x26BD || v == 0x26BE
                                                                                         || v == 0x26C4 || v == 0x26C5
                                                                                         || v == 0x26C8
                                                                                         || v == 0x26CE
                                                                                         || v == 0x26CF
                                                                                         || v == 0x26D1
                                                                                         || v == 0x26D3 || v == 0x26D4
                                                                                         || v == 0x26E9 || v == 0x26EA
                                                                                         || (v >= 0x26F0 && v <= 0x26F5)
                                                                                         || (v >= 0x26F7 && v <= 0x26FA)
                                                                                         || v == 0x26FD
                                                                                         || v == 0x2702
                                                                                         || v == 0x2705
                                                                                         || (v >= 0x2708 && v <= 0x270D)
                                                                                         || v == 0x270F
                                                                                         || v == 0x2712
                                                                                         || v == 0x2714
                                                                                         || v == 0x2716
                                                                                         || v == 0x271D
                                                                                         || v == 0x2721
                                                                                         || v == 0x2728
                                                                                         || v == 0x2733 || v == 0x2734
                                                                                         || v == 0x2744
                                                                                         || v == 0x2747
                                                                                         || v == 0x274C
                                                                                         || v == 0x274E
                                                                                         || (v >= 0x2753 && v <= 0x2755)
                                                                                         || v == 0x2757
                                                                                         || v == 0x2763 || v == 0x2764
                                                                                         || (v >= 0x2795 && v <= 0x2797)
                                                                                         || v == 0x27A1
                                                                                         || v == 0x27B0
                                                                                         || v == 0x27BF
                                                                                         || v == 0x2934 || v == 0x2935
                                                                                         || (v >= 0x2B05 && v <= 0x2B07)
                                                                                         || v == 0x2B1B || v == 0x2B1C
                                                                                         || v == 0x2B50
                                                                                         || v == 0x2B55
                                                                                         || v == 0x3030
                                                                                         || v == 0x303D
                                                                                         || v == 0x3297
                                                                                         || v == 0x3299
                                                                                         // 第二段
                                                                                         || v == 0x23F0)) {
                return YES;
            }
            
            i += 2;
            continue;
        }
        if ((bt | 0x3F) == 0xBF) {  // 10xxxxxx  10开头,为数据字节,直接过滤
            continue;
        }
        
        return YES;                 // 不是以上情况的字符全部超过三个字节,做Emoji处理
    }
    
    return NO;
}

+ (BOOL)stringContainsEmoji:(NSString *)string
{
   
    
    __block BOOL returnValue = NO;
    
    [string enumerateSubstringsInRange:NSMakeRange(0, [string length])
                               options:NSStringEnumerationByComposedCharacterSequences
                            usingBlock:^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
                                const unichar hs = [substring characterAtIndex:0];
                                if (0xd800 <= hs && hs <= 0xdbff) {
                                    if (substring.length > 1) {
                                        const unichar ls = [substring characterAtIndex:1];
                                        const int uc = ((hs - 0xd800) * 0x400) + (ls - 0xdc00) + 0x10000;
                                        if (0x1d000 <= uc && uc <= 0x1f77f) {
                                            returnValue = YES;
                                        }
                                    }
                                } else if (substring.length > 1) {
                                    const unichar ls = [substring characterAtIndex:1];
                                    if (ls == 0x20e3) {
                                        returnValue = YES;
                                    }
                                } else {
                                    if (0x2100 <= hs && hs <= 0x27ff) {
                                        returnValue = YES;
                                    } else if (0x2B05 <= hs && hs <= 0x2b07) {
                                        returnValue = YES;
                                    } else if (0x2934 <= hs && hs <= 0x2935) {
                                        returnValue = YES;
                                    } else if (0x3297 <= hs && hs <= 0x3299) {
                                        returnValue = YES;
                                    } else if (hs == 0xa9 || hs == 0xae || hs == 0x303d || hs == 0x3030 || hs == 0x2b55 || hs == 0x2b1c || hs == 0x2b1b || hs == 0x2b50) {
                                        returnValue = YES;
                                    }
                                }
                            }];
    
    return returnValue;
}

@end
