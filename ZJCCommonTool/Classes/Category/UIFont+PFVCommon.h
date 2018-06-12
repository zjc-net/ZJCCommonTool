//
//  UIFont+PFVCommon.h
//  PurangFinanceVillage
//
//  Created by daichen on 2017/11/6.
//  Copyright © 2017年 ___PURANG___. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger,FontName) {
    FontNameDefault,
    FontNamePingFangLight,
    FontNamePingFangRegular,
    FontNamePingFangUltralight,
    FontNamePingFangSemibold,
    FontNamePingFangThin,
    FontNamePingFangMedium,
    FontNamePingFangBold
};


typedef NS_ENUM(NSInteger,PFVFontName) {
    PFVFontNameSystem,
    PFVFontNameBold
};

typedef NS_ENUM(NSInteger,PRArtFontName) {
    PRDFPWaWaFont,//娃娃体
    PRSTKaitiFont,//华文楷体
    PRSentyTEAFont,//新蒂下午茶基本版
    PRBSentyTEAFont//新蒂下午茶基本版
};

@interface UIFont (PFVCommon)

+ (UIFont *)fontWithFontName:(FontName)fontName size:(CGFloat)size;

+ (UIFont *)fontWithFontName:(FontName)fontName defaultFontName:(PFVFontName)defaultFontName size:(CGFloat)size;

+ (UIFont *)fontWithOtherFontName:(PRArtFontName)fontName size:(CGFloat)size;

@end
