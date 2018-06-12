//
//  NSString+Emoji.h
//  uitextfield
//
//  Created by zhiujunchun on 17/3/3.
//  Copyright © 2017年 PURANG. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Emoji)

- (BOOL) containEmoji;


- (BOOL)isEmoji;
- (BOOL)isIncludingEmoji ;
- (instancetype)removedEmojiString;

/**
 *  判断字符串中是否存在emoji
 * @param string 字符串
 * @return YES(含有表情)
 */
- (BOOL)stringContainsEmoji;
/**
 *  判断字符串中是否存在emoji
 * @param string 字符串
 * @return YES(含有表情)
 */
- (BOOL)hasEmoji;
/**
 * 判断 字母、数字、中文
 */
- (BOOL)isInputRuleAndNumber;
/**
 判断是不是九宫格
 @param string  输入的字符
 @return YES(是九宫格拼音键盘)
 */
-(BOOL)isNineKeyBoard;
@end
