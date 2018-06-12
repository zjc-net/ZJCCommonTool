//
//  UIView+Frame.m
//  传智微博
//
//  Created by apple on 15-3-5.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "UIView+Frame.h"
#import "Header.h"

@implementation UIView (Frame)

- (void)setX:(CGFloat)x
{
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

- (CGFloat)x
{
    return self.frame.origin.x;
}

- (void)setY:(CGFloat)y
{
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

- (CGFloat)y
{
    return self.frame.origin.y;
}

- (CGFloat)width
{
    return self.frame.size.width;
}

- (void)setWidth:(CGFloat)width
{
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}


- (CGFloat)height{
    return self.frame.size.height;
}

- (void)setHeight:(CGFloat)height
{
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

-(void)setSize:(CGSize)size{
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}

- (CGSize)size{
    return self.frame.size;
}

- (void)setOrigin:(CGPoint)origin{
    CGRect frame = self.frame;
    frame.origin = origin;
    self.frame = frame;
}

- (CGPoint)origin{
    return self.frame.origin;
}

- (void)setCenterX:(CGFloat)centerX{
    CGPoint center = self.center;
    center.x = centerX;
    self.center = center;
}

- (CGFloat)centerX{
    return self.center.x;
}

-(void)setCenterY:(CGFloat)centerY{
    CGPoint center = self.center;
    center.y = centerY;
    self.center = center;
}

- (CGFloat)centerY{
    return self.center.y;
}

- (void)removeAllSubviews{
    for (UIView *one in [self subviews]) {
        
        [one removeFromSuperview];
    }
}

- (CGFloat)left{
    return self.frame.origin.x;
}

- (void)setLeft:(CGFloat)x{
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

- (CGFloat)top{
    return self.frame.origin.y;
}

- (void)setTop:(CGFloat)y{
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

- (CGFloat)right{
    return self.frame.origin.x + self.frame.size.width;
}

- (void)setRight:(CGFloat)right{
    CGRect frame = self.frame;
    frame.origin.x = right - frame.size.width;
    self.frame = frame;
}

- (CGFloat)bottom{
    return self.frame.origin.y + self.frame.size.height;
}

- (void)setBottom:(CGFloat)bottom{
    CGRect frame = self.frame;
    frame.origin.y = bottom - frame.size.height;
    self.frame = frame;
}


- (void)drawRectDotterLineWithSize:(CGSize)size andSpacing:(CGFloat)
spacing andColor:(UIColor *)color andcCornerRadius:(CGFloat)radius{
    CAShapeLayer *layer = [CAShapeLayer layer];
    [layer setFrame:self.bounds];
    [layer setStrokeColor:color.CGColor];
    [layer setFillColor:[UIColor clearColor].CGColor];
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:self.bounds cornerRadius:radius];
    layer.path = path.CGPath;
    if (size.width > self.width || size.height > self.height) {
        NSAssert(NO, @"虚线size值不可以超过矩形size");
    }
    layer.lineWidth = size.height;
    layer.lineDashPattern =  @[[NSNumber numberWithFloat:size.width], [NSNumber numberWithFloat:spacing]];
    [self.layer addSublayer:layer];
    if (radius >= 0) {
        self.layer.masksToBounds = YES;
        self.layer.cornerRadius = radius;
    }else{
        NSAssert(NO, @"radius值不能小于零");
    }
}

+ (UIView *)setLineViewOrginY:(CGFloat)y{
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, y, SCREEN_WIDTH, 0.5)];
    line.backgroundColor = RGBHex(0xd2d2d2);
    return line;
}

- (void)setGradientLayer:(CAGradientLayer *)gradientLayer{
    [self.layer addSublayer:gradientLayer];
}

@end
