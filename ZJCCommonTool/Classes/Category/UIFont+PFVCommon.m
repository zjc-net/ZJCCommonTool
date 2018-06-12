//
//  UIFont+PFVCommon.m
//  PurangFinanceVillage
//
//  Created by daichen on 2017/11/6.
//  Copyright © 2017年 ___PURANG___. All rights reserved.
//

#import "UIFont+PFVCommon.h"
#import "UIDevice+UIDeviceCategory.h"

@implementation UIFont (PFVCommon)

+ (UIFont *)fontWithFontName:(FontName)fontName size:(CGFloat)size{
    UIFont *font;
    if ([UIDevice getiOSVersion] >=9) {
        switch (fontName) {
            case FontNameDefault:
                font = [UIFont systemFontOfSize:size];
                break;
            case FontNamePingFangUltralight:
                font = [UIFont fontWithName:@"PingFangSC-Ultralight" size:size];
                break;
            case FontNamePingFangRegular:
                font = [UIFont fontWithName:@"PingFangSC-Regular" size:size];
                break;
            case FontNamePingFangSemibold:
                font = [UIFont fontWithName:@"PingFangSC-Semibold" size:size];
                break;
            case FontNamePingFangThin:
                font = [UIFont fontWithName:@"PingFangSC-Thin" size:size];
                break;
            case FontNamePingFangLight:
                font = [UIFont fontWithName:@"PingFangSC-Light" size:size];
                break;
            case FontNamePingFangMedium:
                font = [UIFont fontWithName:@"PingFangSC-Medium" size:size];
                break;
            case FontNamePingFangBold:
                font = [UIFont fontWithName:@"PingFangSC-Bold" size:size];
                break;
                
            default:
                font = [UIFont systemFontOfSize:size];
                break;
        }
    }else {
        font = [UIFont systemFontOfSize:size];
    }
    return font;
}

+ (UIFont *)fontWithFontName:(FontName)fontName defaultFontName:(PFVFontName)defaultFontName size:(CGFloat)size{
    UIFont *font;
    if ([UIDevice getiOSVersion] >=9) {
        switch (fontName) {
            case FontNameDefault:
                font = [UIFont systemFontOfSize:size];
                break;
            case FontNamePingFangUltralight:
                font = [UIFont fontWithName:@"PingFangSC-Ultralight" size:size];
                break;
            case FontNamePingFangRegular:
                font = [UIFont fontWithName:@"PingFangSC-Regular" size:size];
                break;
            case FontNamePingFangSemibold:
                font = [UIFont fontWithName:@"PingFangSC-Semibold" size:size];
                break;
            case FontNamePingFangThin:
                font = [UIFont fontWithName:@"PingFangSC-Thin" size:size];
                break;
            case FontNamePingFangLight:
                font = [UIFont fontWithName:@"PingFangSC-Light" size:size];
                break;
            case FontNamePingFangMedium:
                font = [UIFont fontWithName:@"PingFangSC-Medium" size:size];
                break;
            case FontNamePingFangBold:
                font = [UIFont fontWithName:@"PingFangSC-Bold" size:size];
                break;
                
            default:
                font = [UIFont systemFontOfSize:size];
                break;
        }
    }else {
        switch (defaultFontName) {
            case PFVFontNameSystem:
                font = [UIFont systemFontOfSize:size];
                break;
            case PFVFontNameBold:
                font = [UIFont boldSystemFontOfSize:size];
                break;
            default:
                font = [UIFont systemFontOfSize:size];
                break;
        }
    }
    return font;
}

+ (UIFont *)fontWithOtherFontName:(PRArtFontName)fontName size:(CGFloat)size
{
    UIFont *font;
        switch(fontName) {
            case PRDFPWaWaFont:
                font = [UIFont fontWithName:@"DFPWaWaW5-GB" size:size];
                break;
            case PRSTKaitiFont:
                font = [UIFont fontWithName:@"STKaiti" size:size];
                break;
            case PRSentyTEAFont:
                font = [UIFont fontWithName:@"SentyTEA ÂµÙ" size:size];
                break;
            case PRBSentyTEAFont:
                font = [UIFont fontWithName:@"SentyTEA-Platinum" size:size];
                break;
            default:
                font = [UIFont systemFontOfSize:size];
                break;
        }
    return font;
}


@end
