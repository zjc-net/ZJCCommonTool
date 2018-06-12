//
//  UILabel+PFVAlignment.h
//  PurangFinanceVillage
//
//  Created by daichen on 2017/8/10.
//  Copyright © 2017年 ___PURANG___. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (PFVAlignment)

//两端对齐
- (void)textAlignmentLeftAndRight;

//指定Label以最后的冒号对齐的width两端对齐
- (void)textAlignmentLeftAndRightWith:(CGFloat)labelWidth;

/**
 *  改变行间距
 */
- (void)changeLineSpaceForLabelWithSpace:(float)space;

/**
 *  改变字间距
 */
- (void)changeWordSpaceForLabelWithSpace:(float)space;

/**
 *  改变行间距和字间距
 */
- (void)changeSpaceForLabelwithLineSpace:(float)lineSpace WordSpace:(float)wordSpace;

@end
