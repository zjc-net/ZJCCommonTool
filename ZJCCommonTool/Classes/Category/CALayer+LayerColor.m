//
//  CALayer+LayerColor.m
//  PurangFinanceVillage
//
//  Created by zhiujunchun on 2017/7/6.
//  Copyright © 2017年 ___PURANG___. All rights reserved.
//

#import "CALayer+LayerColor.h"

@implementation CALayer (LayerColor)

- (void)setBorderColorFromUIColor:(UIColor *)color{
    self.borderColor = color.CGColor;
}

@end
