//
//  UITextField+ExtentRange.h
//  PurangFinanceVillage
//
//  Created by lichuanduo on 16/8/12.
//  Copyright © 2016年 ___PURANG___. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextField (ExtentRange)
- (NSRange) selectedRange;
- (void) setSelectedRange:(NSRange) range;
@end
