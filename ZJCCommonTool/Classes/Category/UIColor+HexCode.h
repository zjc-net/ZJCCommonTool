//
//  UIColor+HexCode.h
//  Shake
//
//  Created by liumingkui on 14-8-11.
//  Copyright (c) 2014年 ___PURANG___. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor(HexCode)

+ (UIColor *) colorFromHexCode:(NSString *)hexString;

+ (CAGradientLayer *) colorArray:(NSArray *)colorArray frame:(CGRect)frame;

@end
