//
//  EmojiDelegate.h
//  uitextfield
//
//  Created by zhiujunchun on 17/3/2.
//  Copyright © 2017年 PURANG. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface EmojiDelegate : NSObject<UITextFieldDelegate>
@property(nonatomic, weak) UITextField *textField;
@property(nonatomic, weak) id<UITextFieldDelegate> originalDelegate;

@property(nonatomic, strong) NSString *prevText;    // 上次的输入结果

- (id) initWithTextField:(UITextField *)textField;
@end

