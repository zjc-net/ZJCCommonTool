//
//  NSAttributedString+Extensions.h
//  product
//
//  Created by wangxiangwei on 2017/11/24.
//  Copyright © 2017年 purang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSAttributedString (Extensions)


/*
 *    富文本
 *    @param textArray  内容 文字、图片
 *    @param colorArray color数组， 取对应值，默认whiteColor
 *    @param sizeArray  大小，可以是NSNumber，UIFont
 *
 */
+ (NSMutableAttributedString *)attributedStringFromTextArray:(NSArray *)textArray colorArray:(NSArray <UIColor *>*)colorArray sizeArray:(NSArray *)sizeArray;

/*
 *    富文本
 *    @param textArray  内容 文字、图片
 *    @param colorArray color数组， 取对应值，默认whiteColor
 *    @param sizeArray  大小，可以是NSNumber，UIFont
 *    @param offset     NSBaselineOffsetAttributeName
 *
 */
+ (NSMutableAttributedString *)attributedStringFromTextArray:(NSArray *)textArray colorArray:(NSArray <UIColor *>*)colorArray sizeArray:(NSArray *)sizeArray baselineOffset:(NSNumber *)offset;

/*
 *    富文本
 *    @param textArray  内容 文字、图片
 *    @param colorArray color数组， 取对应值，默认whiteColor
 *    @param sizeArray  大小，可以是NSNumber，UIFont
 *    @param keyArray   其他属性值
 *
 */
+ (NSMutableAttributedString *)attributedStringFromTextArray:(NSArray *)textArray colorArray:(NSArray <UIColor *>*)colorArray sizeArray:(NSArray *)sizeArray keyArray:(NSArray *)keyArray;

@end
