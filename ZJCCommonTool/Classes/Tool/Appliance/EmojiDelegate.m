//
//  EmojiDelegate.m
//  uitextfield
//
//  Created by zhiujunchun on 17/3/2.
//  Copyright © 2017年 PURANG. All rights reserved.
//

#import "EmojiDelegate.h"
#import "NSString+Emoji.h"
#import "UITextField+BXExtension.h"

@implementation EmojiDelegate

- (id) initWithTextField:(UITextField *)textField
{
    self = [super init];
    
    self.textField = textField;
    [textField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    
    return self;
}

- (void) dealloc
{
    [_textField removeTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    self.originalDelegate = nil;
    self.prevText = nil;
    //    [super dealloc];
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if ([self.originalDelegate respondsToSelector:@selector(textFieldShouldBeginEditing:)]) {
        return [self.originalDelegate textFieldShouldBeginEditing:textField];
    }
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    self.prevText = textField.text;
    if ([self.originalDelegate respondsToSelector:@selector(textFieldDidBeginEditing:)]) {
        return [self.originalDelegate textFieldDidBeginEditing:textField];
    }
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    if ([self.originalDelegate respondsToSelector:@selector(textFieldShouldEndEditing:)]) {
        return [self.originalDelegate textFieldShouldEndEditing:textField];
    }
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if ([self.originalDelegate respondsToSelector:@selector(textFieldDidEndEditing:)]) {
        return [self.originalDelegate textFieldDidEndEditing:textField];
    }
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    //    if (string.length == 0) {
    //        return YES;
    //    }
    
    /// 过滤emoji
    
    
    
    if ([textField isFirstResponder]) {
        if ([[[textField textInputMode] primaryLanguage] isEqualToString:@"emoji"] || ![[textField textInputMode] primaryLanguage]) {
            return NO;
        }
        //判断键盘是不是九宫格键盘
        if ([string isNineKeyBoard] ){
            return YES;
        }else{
            if ([string hasEmoji] || [string stringContainsEmoji]){
                return NO;
            }
        }
        // 忽略系统默认的emoji键盘
        if ([[[textField textInputMode] primaryLanguage] isEqualToString:@"emoji"]) {
            return NO;
        }
    }
    //    // 忽略系统默认的emoji键盘
    //    if ([[[textField textInputMode] primaryLanguage] isEqualToString:@"emoji"]) {
    //        return NO;
    //    }
    //
    //    // 验证string的emoji字符
    //    if ([string containEmoji]) {
    //        return NO;
    //    }
    
    if ([self.originalDelegate respondsToSelector:@selector(textField:shouldChangeCharactersInRange:replacementString:)]) {
        return [self.originalDelegate textField:textField shouldChangeCharactersInRange:range replacementString:string];
    }
    return YES;
}

- (BOOL)textFieldShouldClear:(UITextField *)textField
{
    if ([self.originalDelegate respondsToSelector:@selector(textFieldShouldClear:)]) {
        return [self.originalDelegate textFieldShouldClear:textField];
    }
    return NO;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if ([self.originalDelegate respondsToSelector:@selector(textFieldShouldReturn:)]) {
        return [self.originalDelegate textFieldShouldReturn:textField];
    }
    return YES;
}

/**
 * 监听UITextField文本变动,规避中文输入法联想输入Emoji问题
 */
- (void) textFieldDidChange:(UITextField *)textField
{
    if ([textField markedTextRange] == nil) {
        NSString *text = textField.text;
        if ([text containEmoji]) {
            NSUInteger location = [textField selectedRange].location - 2;
            textField.text = _prevText;
            if (location > _prevText.length) {
                location = _prevText.length;
            }
            [textField setSelectedRange:NSMakeRange(location, 0)];
        } else {
            self.prevText = text;
        }
    }
}

@end

