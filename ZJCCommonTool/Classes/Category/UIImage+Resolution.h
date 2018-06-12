//
//  UIImage+Resolution.h
//  PurangFinance
//
//  Created by liumingkui on 15/5/20.
//  Copyright (c) 2015年 ___PURANG___. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Resolution)

-(UIImage*)imageScaledToSize:(CGSize)newSize;
-(UIImage*)imageScaledToSize2:(CGSize)newSize;
- (UIImage *)imageScaledToSize3:(CGSize)newSize;

//颜色转换成图片(带圆角的)
+ (UIImage *)imageWithColor:(UIColor *)color redius:(CGFloat)redius size:(CGSize)size;
//将图片截成圆形图片
+ (UIImage *)imagewithImage:(UIImage *)image;
@end
