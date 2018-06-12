//
//  UIDevice+UIDeviceCategory.h
//  格桑梅朵
//
//  Created by liumingkui on 14-8-8.
//  Copyright (c) 2014年 ___PURANG___. All rights reserved.
//

#define DEVICE_MODELID_EOOR          0x00
#define DEVICE_MODELID_IPHONE_480h   0x01
#define DEVICE_MODELID_IPHONE_568h   0x02
#define DEVICE_MODELID_IPAD          0x03

#define SCREEN_NORMAL                0x01
#define SCREEN_RETINA                0x02

#import <UIKit/UIKit.h>

@interface UIDevice (UIDeviceCategory)

+ (NSInteger)modelId;

+ (CGFloat)width;
+ (CGFloat)height;

+ (NSInteger)screenType;

+ (NSInteger)systemVersionFirstNumber;

+ (BOOL)supportsAirdrop;

+ (void)printAllFont;

+ (CGFloat)autoSizeScaleX;
+ (CGFloat)autoSizeScaleY;

+ (CGFloat)getiOSVersion;

@end
