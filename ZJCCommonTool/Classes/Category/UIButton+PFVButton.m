//
//  UIButton+PFVButton.m
//  PurangFinanceVillage
//
//  Created by daichen on 2017/12/18.
//  Copyright © 2017年 ___PURANG___. All rights reserved.
//

#import "UIButton+PFVButton.h"
#import <objc/runtime.h>
#import "Header.h"
#import "UIFont+PFVCommon.h"
#import "Utils.h"

NSString const *badgeKey                 = @"badgeKey";

NSString const *badgeBGColorKey          = @"badgeBGColorKey";
NSString const *badgeTextColorKey        = @"badgeTextColorKey";
NSString const *badgeFontKey             = @"badgeFontKey";
NSString const *badgePaddingKey          = @"badgePaddingKey";
NSString const *badgeMinSizeKey          = @"badgeMinSizeKey";
NSString const *badgeOriginXKey          = @"badgeOriginXKey";
NSString const *badgeOriginYKey          = @"badgeOriginYKey";
NSString const *shouldHideBadgeAtZeroKey = @"shouldHideBadgeAtZeroKey";
NSString const *shouldAnimateBadgeKey    = @"shouldAnimateBadgeKey";
NSString const *badgeValueKey            = @"badgeValueKey";
@implementation UIButton (PFVButton)
- (void)badgeInit
{
    // 初始化，设定默认值
    self.badgeBGColor   = self.badgeBGColor ? self.badgeBGColor :[UIColor redColor];
    self.badgeTextColor = self.badgeTextColor ? self.badgeTextColor :[UIColor whiteColor];
    self.badgeFont      = self.badgeFont ? self.badgeFont : [UIFont systemFontOfSize:12.0];
    self.badgePadding   = self.badgePadding?self.badgePadding:2;//8;//
    self.badgeMinSize   = self.badgeMinSize?self.badgeMinSize:12;//8;//
    self.badgeOriginX   = (self.badgeOriginX)?self.badgeOriginX: self.frame.size.width - self.badge.frame.size.width/2;
    self.badgeOriginY   = self.badgeOriginY ? self.badgeOriginY: 6;
    self.shouldHideBadgeAtZero = YES;
    self.shouldAnimateBadge = YES;
    // 避免角标被裁剪
    self.clipsToBounds = NO;
}

#pragma mark - Utility methods

// 当角标的属性改变时，调用此方法
- (void)refreshBadge{
    // 更新属性
    self.badge.textColor        = self.badgeTextColor;
    self.badge.backgroundColor  = self.badgeBGColor;
    self.badge.font             = self.badgeFont;
}

- (CGSize) badgeExpectedSize{
    // 自适应角标
    UILabel *frameLabel = [self duplicateLabel:self.badge];
    [frameLabel sizeToFit];
    
    CGSize expectedLabelSize = frameLabel.frame.size;
    return expectedLabelSize;
}
/**
 *  更新角标的frame
 */
- (void)updateBadgeFrame{
    
    CGSize expectedLabelSize = [self badgeExpectedSize];
    
    CGFloat minHeight = expectedLabelSize.height;
    
    // 判断如果小于最小size，则为最小size
    minHeight = MAX(expectedLabelSize.height, self.badgeMinSize);//(minHeight < self.badgeMinSize) ? self.badgeMinSize : expectedLabelSize.height;
    CGFloat minWidth = expectedLabelSize.width;
    CGFloat padding = self.badgePadding;
    
    // 填充边界
    minWidth =  MAX(minHeight, expectedLabelSize.width);// (minWidth < minHeight) ? minHeight : expectedLabelSize.width;
    self.badge.frame = CGRectMake(self.badgeOriginX, self.badgeOriginY, minWidth + padding, minHeight + padding);
//    self.badge.frame = CGRectMake(self.badgeOriginX, self.badgeOriginY, minWidth, minHeight);
    self.badge.layer.cornerRadius = self.badge.frame.size.width/ 2;
    self.badge.layer.masksToBounds = YES;
}

// 角标值变化
- (void)updateBadgeValueAnimated:(BOOL)animated{
    // 动画效果
    if (animated && self.shouldAnimateBadge && ![self.badge.text isEqualToString:self.badgeValue]) {
        CABasicAnimation * animation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
        [animation setFromValue:[NSNumber numberWithFloat:1.5]];
        [animation setToValue:[NSNumber numberWithFloat:1]];
        [animation setDuration:0.2];
        [animation setTimingFunction:[CAMediaTimingFunction functionWithControlPoints:.4f :1.3f :1.f :1.f]];
        [self.badge.layer addAnimation:animation forKey:@"bounceAnimation"];
    }
    self.badge.text = self.badgeValue;
    
    // 动画时间
    NSTimeInterval duration = animated ? 0.2 : 0;
    [UIView animateWithDuration:duration animations:^{
        [self updateBadgeFrame];
    }];
}

- (UILabel *)duplicateLabel:(UILabel *)labelToCopy{
    UILabel *duplicateLabel = [[UILabel alloc] initWithFrame:labelToCopy.frame];
    duplicateLabel.text = labelToCopy.text;
    duplicateLabel.font = labelToCopy.font;
    
    return duplicateLabel;
}

- (void)removeBadge{
    // 移除角标
    [UIView animateWithDuration:0.2 animations:^{
        self.badge.transform = CGAffineTransformMakeScale(0, 0);
    } completion:^(BOOL finished) {
        [self.badge removeFromSuperview];
        self.badge = nil;
    }];
}

#pragma mark - getters/setters
-(UILabel*) badge {
    return objc_getAssociatedObject(self, &badgeKey);
}

-(void)setBadge:(UILabel *)badgeLabel{
    objc_setAssociatedObject(self, &badgeKey, badgeLabel, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

// 显示角标
-(NSString *)badgeValue {
    return objc_getAssociatedObject(self, &badgeValueKey);
}

-(void) setBadgeValue:(NSString *)badgeValue{
    objc_setAssociatedObject(self, &badgeValueKey, badgeValue, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    // 当角标信息不存在，或者为空，则移除
    if (!badgeValue || [badgeValue isEqualToString:@""] || ([badgeValue isEqualToString:@"0"] && self.shouldHideBadgeAtZero)) {
        [self removeBadge];
    } else if (!self.badge) {
        //当又有值时，重新设置角标
        self.badge                      = [[UILabel alloc] initWithFrame:CGRectMake(self.badgeOriginX, self.badgeOriginY, 20, 20)];
        self.badge.textColor            = self.badgeTextColor;
        self.badge.backgroundColor      = self.badgeBGColor;
        self.badge.font                 = self.badgeFont;
        self.badge.textAlignment        = NSTextAlignmentCenter;
        [self badgeInit];
        [self addSubview:self.badge];
        [self updateBadgeValueAnimated:NO];
    } else {
        [self updateBadgeValueAnimated:YES];
    }
}

//进行关联
-(UIColor *)badgeBGColor {
    return objc_getAssociatedObject(self, &badgeBGColorKey);
}

//获取关联
-(void)setBadgeBGColor:(UIColor *)badgeBGColor{
    objc_setAssociatedObject(self, &badgeBGColorKey, badgeBGColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    if (self.badge) {
        [self refreshBadge];
    }
}

-(UIColor *)badgeTextColor {
    return objc_getAssociatedObject(self, &badgeTextColorKey);
}

-(void)setBadgeTextColor:(UIColor *)badgeTextColor{
    objc_setAssociatedObject(self, &badgeTextColorKey, badgeTextColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    if (self.badge) {
        [self refreshBadge];
    }
}

-(UIFont *)badgeFont {
    return objc_getAssociatedObject(self, &badgeFontKey);
}

-(void)setBadgeFont:(UIFont *)badgeFont{
    objc_setAssociatedObject(self, &badgeFontKey, badgeFont, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    if (self.badge) {
        [self refreshBadge];
    }
}

-(CGFloat) badgePadding {
    NSNumber *number = objc_getAssociatedObject(self, &badgePaddingKey);
    return number.floatValue;
}

-(void) setBadgePadding:(CGFloat)badgePadding{
    NSNumber *number = [NSNumber numberWithDouble:badgePadding];
    objc_setAssociatedObject(self, &badgePaddingKey, number, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    if (self.badge) {
        [self updateBadgeFrame];
    }
}

-(CGFloat) badgeMinSize {
    NSNumber *number = objc_getAssociatedObject(self, &badgeMinSizeKey);
    return number.floatValue;
}

-(void) setBadgeMinSize:(CGFloat)badgeMinSize{
    NSNumber *number = [NSNumber numberWithDouble:badgeMinSize];
    objc_setAssociatedObject(self, &badgeMinSizeKey, number, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    if (self.badge) {
        [self updateBadgeFrame];
    }
}

-(CGFloat) badgeOriginX {
    NSNumber *number = objc_getAssociatedObject(self, &badgeOriginXKey);
    return number.floatValue;
}

-(void) setBadgeOriginX:(CGFloat)badgeOriginX{
    NSNumber *number = [NSNumber numberWithDouble:badgeOriginX];
    objc_setAssociatedObject(self, &badgeOriginXKey, number, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    if (self.badge) {
        [self updateBadgeFrame];
    }
}

-(CGFloat) badgeOriginY {
    NSNumber *number = objc_getAssociatedObject(self, &badgeOriginYKey);
    return number.floatValue;
}

-(void) setBadgeOriginY:(CGFloat)badgeOriginY{
    NSNumber *number = [NSNumber numberWithDouble:badgeOriginY];
    objc_setAssociatedObject(self, &badgeOriginYKey, number, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    if (self.badge) {
        [self updateBadgeFrame];
    }
}

-(BOOL) shouldHideBadgeAtZero {
    NSNumber *number = objc_getAssociatedObject(self, &shouldHideBadgeAtZeroKey);
    return number.boolValue;
}

- (void)setShouldHideBadgeAtZero:(BOOL)shouldHideBadgeAtZero{
    NSNumber *number = [NSNumber numberWithBool:shouldHideBadgeAtZero];
    objc_setAssociatedObject(self, &shouldHideBadgeAtZeroKey, number, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(BOOL) shouldAnimateBadge {
    NSNumber *number = objc_getAssociatedObject(self, &shouldAnimateBadgeKey);
    return number.boolValue;
}

- (void)setShouldAnimateBadge:(BOOL)shouldAnimateBadge{
    NSNumber *number = [NSNumber numberWithBool:shouldAnimateBadge];
    objc_setAssociatedObject(self, &shouldAnimateBadgeKey, number, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}


+ (UIButton *)buttonTitle:(NSString *)title frame:(CGRect)frame target:(id)target action:(SEL)action{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitle:title forState:UIControlStateSelected];
    button.frame = frame;
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return button;
}

+ (UIButton *)note_createButtonTitle:(NSString *)title frame:(CGRect)frame{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = frame;
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:COLORRGB(27, 26 ,66) forState:UIControlStateNormal];
    [button setBackgroundColor:[UIColor clearColor]];
    button.titleLabel.font = SYSTEMFONT(12);
    return button;
}

+ (UIButton *)note_createButtonTitle:(NSString *)title frame:(CGRect)frame target:(id)target action:(SEL)action{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = frame;
    button.titleLabel.font = SYSTEMFONT(14);
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button setImage:IMG(@"down_15") forState:UIControlStateNormal];
    UIImage *image = button.imageView.image;
    [button setBackgroundColor:COLORRGB(234, 156, 63)];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    CGSize textSize = [button.titleLabel.text sizeWithAttributes:@{NSFontAttributeName : button.titleLabel.font}];
    [button setTitleEdgeInsets:UIEdgeInsetsMake(0, -image.size.width, 0, image.size.width+2)];
    [button setImageEdgeInsets:UIEdgeInsetsMake(0, textSize.width+2, 0, -textSize.width)];
    ViewRadius(button, 2.5);
    return button;
}

+ (UIButton *)note1_createButtonTitle:(NSString *)title selectStr:(NSString *)selectStr frame:(CGRect)frame target:(id)target action:(SEL)action{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = frame;
    button.titleLabel.font = [UIFont fontWithFontName:FontNamePingFangRegular defaultFontName:PFVFontNameSystem size:13];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitle:selectStr forState:UIControlStateSelected];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    [button setImage:IMG(@"down_15") forState:UIControlStateNormal];
    [button setImage:IMG(@"down_15") forState:UIControlStateSelected];
    UIImage *image = button.imageView.image;
    [button setBackgroundImage:[Utils createImageWithColor:[UIColor clearColor]] forState:UIControlStateNormal];
    [button setBackgroundImage:[Utils createImageWithColor:COLORRGB(108, 176, 206)] forState:UIControlStateSelected];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    NSString *text = button.titleLabel.text;
    if (button.selected == YES) {
        text = selectStr;
    }else{
        text = button.titleLabel.text;
    }
    CGSize textSize = [text sizeWithAttributes:@{NSFontAttributeName : button.titleLabel.font}];
    [button setTitleEdgeInsets:UIEdgeInsetsMake(0, -image.size.width, 0, image.size.width+3)];
    [button setImageEdgeInsets:UIEdgeInsetsMake(0, textSize.width+3, 0, -textSize.width)];
    return button;
}

+ (UIButton *)note_butttonTitle:(NSString *)title imageName:(NSString *)imageName target:(id)target action:(SEL)action tag:(NSInteger)tag frame:(CGRect)frame{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = frame;
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    UIImage *image = IMG(imageName);
    [btn setImage:image forState:UIControlStateNormal];
    btn.titleLabel.textAlignment = NSTextAlignmentCenter;
    btn.titleLabel.font = [UIFont systemFontOfSize:11];
    CGSize textSize = [btn.titleLabel.text sizeWithAttributes:@{NSFontAttributeName : btn.titleLabel.font}];
    [btn setTitleEdgeInsets:UIEdgeInsetsMake(0, -image.size.width, 0, image.size.width)];
    [btn setImageEdgeInsets:UIEdgeInsetsMake(0, textSize.width, 0, -textSize.width)];
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    btn.tag = 1000+tag;
    return btn;
}

@end


