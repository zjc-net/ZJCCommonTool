//
//  UIBarButtonItem+Item.h
//  PurangFinanceVillage
//
//  Created by wangxiangwei on 17/2/16.
//  Copyright © 2017年 ___PURANG___. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIButton+EdgeInsets.h"

@interface UIBarButtonItem (Item)

+ (UIBarButtonItem *)barButtonItemWithImage:(UIImage *)image highImage:(UIImage *)highImage target:(id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents;
+ (UIBarButtonItem *) rightbarButtonItemWithImage:(UIImage *)image highImage:(UIImage *)highImage target:(id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents;
+ (UIBarButtonItem *)barButtonItemWithTitle:(NSString *)title target:(id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents;
+ (UIBarButtonItem *)rightbarButtonItemWithTitle:(NSString *)title target:(id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents;
+ (UIBarButtonItem *)barButtonItemWithTitle:(NSString *)title Image:(UIImage *)image target:(id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents;

+ (UIBarButtonItem *)barButtonItemWithTitle:(NSString *)title Image:(UIImage *)image Color:(UIColor *)color Font:(UIFont *)font Type:(XWImagePositionType)type spacing:(CGFloat)spacing target:(id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents;

@end
