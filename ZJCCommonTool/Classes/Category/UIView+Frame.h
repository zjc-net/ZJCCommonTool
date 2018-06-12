//
//  UIView+Frame.h
//  传智微博
//
//  Created by apple on 15-3-5.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Frame)
// 分类不能添加成员属性
// @property如果在分类里面，只会自动生成get,set方法的声明，不会生成成员属性，和方法的实现
@property (nonatomic, assign) CGFloat x;
@property (nonatomic, assign) CGFloat y;
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, assign) CGSize size;
@property (nonatomic, assign) CGPoint origin;
@property (nonatomic, assign) CGFloat centerX;
@property (nonatomic, assign) CGFloat centerY;
@property (nonatomic, assign) CGFloat left;
@property (nonatomic, assign) CGFloat top;
@property (nonatomic, assign) CGFloat right;
@property (nonatomic, assign) CGFloat bottom;
@property (nonatomic, strong) CAGradientLayer *gradientLayer;
- (void)removeAllSubviews;

/**
 *  画虚线
 *
 *  @param size      虚线单位size
 *  @param spacing   间隔
 *  @param radius    颜色
 *  @param radius    圆角
 */

- (void)drawRectDotterLineWithSize:(CGSize)size andSpacing:(CGFloat)spacing andColor:(UIColor *)color andcCornerRadius:(CGFloat)radius;

/**
 *  间隔线  默认屏幕宽度 0.5高度  0xd2d2d2背景色
 */

+ (UIView *)setLineViewOrginY:(CGFloat)y;

 
@end
