//
//  UIView+PFVViewUtils.h
//  PurangFinanceVillage
//
//  Created by daichen on 2017/7/5.
//  Copyright © 2017年 ___PURANG___. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (PFVViewUtils)
/**
 *  通过 CAShapeLayer 方式绘制虚线
 *
 *  param lineLength:     虚线的宽度
 *  param lineSpacing:    虚线的间距
 *  param lineColor:      虚线的颜色
 *  param lineDirection   虚线的方向  YES 为水平方向， NO 为垂直方向
 */
- (void)drawLineOfDashByCAShapeLayerlineLength:(int)lineLength lineSpacing:(int)lineSpacing lineColor:(UIColor *)lineColor lineDirection:(BOOL)isHorizonal;

/***
 * 切圆角
 * corners 圆角位置
 * cornerRadii 圆角大小
 */
- (void)bezierbyRoundingCorners:(UIRectCorner)corners cornerRadii:(CGSize)cornerRadii;
/**
 *  通过 CAShapeLayer 方式绘制虚线
 *
 *  param lineLength:     虚线的宽度
 *  param lineSpacing:    虚线的间距
 *  param lineColor:      虚线的颜色
 *  param lineDirection   虚线的方向  YES 为水平方向， NO 为垂直方向
 *  param frame layer 的frame
 */
+ (CAShapeLayer *)drawLineOfDashByCAShapeLayerlineLength:(int)lineLength lineSpacing:(int)lineSpacing lineColor:(UIColor *)lineColor lineDirection:(BOOL)isHorizonal frame:(CGRect)frame;
@end
