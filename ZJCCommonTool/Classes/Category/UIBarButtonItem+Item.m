//
//  UIBarButtonItem+Item.m
//  PurangFinanceVillage
//
//  Created by wangxiangwei on 17/2/16.
//  Copyright © 2017年 ___PURANG___. All rights reserved.
//

#import "UIBarButtonItem+Item.h"

@implementation UIBarButtonItem (Item)

+ (UIBarButtonItem *)barButtonItemWithImage:(UIImage *)image highImage:(UIImage *)highImage target:(id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setImage:image forState:UIControlStateNormal];
    btn.adjustsImageWhenHighlighted = NO;
    [btn setImage:highImage forState:UIControlStateHighlighted];
    btn.frame = CGRectMake(0, 0, 30, 44);
    btn.imageEdgeInsets = UIEdgeInsetsMake(0, -20, 0, 0);
    [btn addTarget:target action:action forControlEvents:controlEvents];
    return  [[UIBarButtonItem alloc] initWithCustomView:btn];
}

+ (UIBarButtonItem *) rightbarButtonItemWithImage:(UIImage *)image highImage:(UIImage *)highImage target:(id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setImage:image forState:UIControlStateNormal];
    btn.adjustsImageWhenHighlighted = NO;
    [btn sizeToFit];
    [btn setImage:highImage forState:UIControlStateHighlighted];
    [btn addTarget:target action:action forControlEvents:controlEvents];
    return  [[UIBarButtonItem alloc] initWithCustomView:btn];
}

+ (UIBarButtonItem *)barButtonItemWithTitle:(NSString *)title target:(id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:title forState: UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn sizeToFit];
    [btn addTarget:target action:action forControlEvents:controlEvents];
    btn.titleLabel.font = [UIFont systemFontOfSize:15];
    btn.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, -5);
    return  [[UIBarButtonItem alloc] initWithCustomView:btn];
}

+ (UIBarButtonItem *)rightbarButtonItemWithTitle:(NSString *)title target:(id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:title forState: UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn sizeToFit];
    [btn addTarget:target action:action forControlEvents:controlEvents];
    btn.titleLabel.font = [UIFont systemFontOfSize:15];
    return  [[UIBarButtonItem alloc] initWithCustomView:btn];
}

+ (UIBarButtonItem *)barButtonItemWithTitle:(NSString *)title Image:(UIImage *)image target:(id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setImage:image forState:UIControlStateNormal];
    btn.adjustsImageWhenHighlighted = NO;
    [btn setTitle:title forState:(UIControlStateNormal)];
    [btn sizeToFit];
    btn.titleLabel.font = [UIFont systemFontOfSize:15];
    btn.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, -5);
    return  [[UIBarButtonItem alloc] initWithCustomView:btn];
}

+ (UIBarButtonItem *)barButtonItemWithTitle:(NSString *)title Image:(UIImage *)image Color:(UIColor *)color Font:(UIFont *)font Type:(XWImagePositionType)type spacing:(CGFloat)spacing target:(id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setImage:image forState:UIControlStateNormal];
    btn.adjustsImageWhenHighlighted = NO;
    [btn setTitle:title forState:UIControlStateNormal];
    btn.frame = CGRectMake(0, 0, 44, 44);
    btn.titleLabel.font = font;
    [btn setTitleColor:color forState:0];
    [btn addTarget:target action:action forControlEvents:controlEvents];
    btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [btn setImagePositionWithType:type spacing:spacing];
    return  [[UIBarButtonItem alloc] initWithCustomView:btn];
}

@end
