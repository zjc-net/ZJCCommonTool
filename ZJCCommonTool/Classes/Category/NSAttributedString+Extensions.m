//
//  NSAttributedString+Extensions.m
//  product
//
//  Created by wangxiangwei on 2017/11/24.
//  Copyright © 2017年 purang. All rights reserved.
//

#import "NSAttributedString+Extensions.h"
#import "Header.h"

#define defaultColor [UIColor whiteColor]
#define defaultSize  14

@implementation NSAttributedString (Extensions)

+ (NSMutableAttributedString *)attributedStringFromTextArray:(NSArray *)textArray colorArray:(NSArray <UIColor *>*)colorArray sizeArray:(NSArray *)sizeArray{
    
    return [self attributedStringFromTextArray:textArray colorArray:colorArray sizeArray:sizeArray keyArray:nil baselineOffset:nil];
}

+ (NSMutableAttributedString *)attributedStringFromTextArray:(NSArray *)textArray colorArray:(NSArray <UIColor *>*)colorArray sizeArray:(NSArray *)sizeArray baselineOffset:(NSNumber *)offset{
    
    return [self attributedStringFromTextArray:textArray colorArray:colorArray sizeArray:sizeArray keyArray:nil baselineOffset:offset];
}

+ (NSMutableAttributedString *)attributedStringFromTextArray:(NSArray *)textArray colorArray:(NSArray <UIColor *>*)colorArray sizeArray:(NSArray *)sizeArray keyArray:(NSArray *)keyArray{
    
    return [self attributedStringFromTextArray:textArray colorArray:colorArray sizeArray:sizeArray keyArray:keyArray baselineOffset:nil];
}

+ (NSMutableAttributedString *)attributedStringFromTextArray:(NSArray *)textArray colorArray:(NSArray <UIColor *>*)colorArray sizeArray:(NSArray *)sizeArray keyArray:(NSArray *)keyArray baselineOffset:(NSNumber *)offset{
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] init];
    
    [textArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        if ([textArray[idx] isKindOfClass:[UIImage class]]) {
            NSTextAttachment *textAttachment = [[NSTextAttachment alloc]init];
            textAttachment.image = textArray[idx];
            CGFloat imgW = textAttachment.image.size.width;
            CGFloat imgH = textAttachment.image.size.height;
            
            if (!textAttachment.image) return ;
            CGSize sizeValue = CGSizeMake(imgW, imgH);
            if (sizeArray.count > idx) {
                if ([sizeArray[idx] isKindOfClass:[NSString class]]) {
                    sizeValue = CGSizeFromString(sizeArray[idx]);
                }
            }
            //居中
            CGFloat orgin_y = 0.0;
            if (imgH > sizeValue.height) {
                orgin_y = (imgH-sizeValue.height)/2;
            }
            textAttachment.bounds = CGRectMake(0.0, orgin_y, sizeValue.width, sizeValue.height);
            [attributedString appendAttributedString:[NSAttributedString attributedStringWithAttachment:textAttachment]];
        }else if ([obj isKindOfClass:[NSString class]]){
            NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc] initWithString:obj];
            
            UIColor *colorValue = defaultColor;
            if (colorArray.count > idx) {
                if ([colorArray[idx] isKindOfClass:[UIColor class]]) {
                    colorValue = colorArray[idx];
                }
            }else{
                if ([[colorArray lastObject] isKindOfClass:[UIColor class]]) {
                    colorValue = [colorArray lastObject];
                }
            }
            
            UIFont *fontValue = [UIFont systemFontOfSize:defaultSize];
            if (sizeArray.count > idx) {
                if ([sizeArray[idx] isKindOfClass:[UIFont class]]) {
                    fontValue = sizeArray[idx];
                }else if ([sizeArray[idx] isKindOfClass:[NSNumber class]]){
                    fontValue = [UIFont systemFontOfSize:[sizeArray[idx] floatValue]];
                }
            }else{
                if ([[sizeArray lastObject] isKindOfClass:[NSNumber class]]) {
                    fontValue = [UIFont systemFontOfSize:[[sizeArray lastObject] floatValue]];
                }else if([[sizeArray lastObject] isKindOfClass:[UIFont class]]){
                    fontValue = [sizeArray lastObject];
                }
            }
            
            
            [attrString addAttributes:@{
                                        NSForegroundColorAttributeName: colorValue,
                                        NSFontAttributeName: fontValue
                                        } range:NSMakeRange(0, attrString.length)];
            
            if (!IsEmpty(keyArray)) {
                if (keyArray.count > idx) {
                    id thing = keyArray[idx];
                    if ([thing isKindOfClass:[NSDictionary class]]) {
                        [attrString addAttributes:thing range:NSMakeRange(0, attrString.length)];
                    }
                }
            }
            
            if (!IsEmpty(offset)) {
                [attrString addAttributes:@{NSBaselineOffsetAttributeName: offset} range:NSMakeRange(0, attrString.length)];
            }
            
            [attributedString appendAttributedString:attrString];
        }
        
    }];
    return attributedString;
}

@end
