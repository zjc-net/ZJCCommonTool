//
//  UIDevice+UIDeviceCategory.m
//  格桑梅朵
//
//  Created by liumingkui on 14-8-8.
//  Copyright (c) 2014年 ___PURANG___. All rights reserved.
//


#import <sys/types.h>
#import <sys/sysctl.h>

#import "UIDevice+UIDeviceCategory.h"

@implementation UIDevice (UIDeviceCategory)

static CGFloat mainScreenWidth = 0;
static CGFloat mainScreenHeight = 0;
static NSInteger systemVersionFirstNumber = -1;

+ (NSInteger)modelId
{
    CGFloat  deviceWidth = [UIDevice width];
    if (deviceWidth == 768)
    {
        return DEVICE_MODELID_IPAD;
    }
    else if (deviceWidth == 320)
    {
        CGFloat deviceHeight = [UIDevice height];
        if (deviceHeight == 480)
        {
            return DEVICE_MODELID_IPHONE_480h;
        }
        else if (deviceHeight == 568)
        {
            return DEVICE_MODELID_IPHONE_568h;
        }
    }
    
    return DEVICE_MODELID_EOOR;
}

+ (CGFloat)width
{
    if (mainScreenWidth == 0)
    {
        mainScreenWidth = [UIScreen mainScreen].bounds.size.width;
    }
    return mainScreenWidth;
}

+ (CGFloat)height
{
    if (mainScreenHeight == 0)
    {
        mainScreenHeight = [UIScreen mainScreen].bounds.size.height;
    }

    return mainScreenHeight;
}

+ (CGFloat)autoSizeScaleX
{
    if ([UIDevice width] > 320)
    {
        return [UIDevice width]/320.0;
    }
    else
    {
        return 1.0;
    }
    
}

+ (CGFloat)autoSizeScaleY
{
    if ([UIDevice height] > 568)
    {
        return [UIDevice height]/568.0;
    }
    else
    {
        return 1.0;
    }
}

+ (NSInteger)screenType
{
    if ([[UIScreen mainScreen] respondsToSelector:@selector(displayLinkWithTarget:selector:)]
        && ([UIScreen mainScreen].scale == 2.0))
    {
        return SCREEN_RETINA;
    }
    else
    {
        return SCREEN_NORMAL;
    }
}

+ (NSInteger)systemVersionFirstNumber
{
    if (systemVersionFirstNumber == -1)
    {
        NSString *systemVersionString = [[UIDevice currentDevice] systemVersion];
        systemVersionFirstNumber = [systemVersionString UTF8String][0] - '0';
    }
    
    return systemVersionFirstNumber;
}

+ (NSString *)machineName
{
    size_t size;
    if (sysctlbyname("hw.machine", NULL, &size, NULL, 0) < 0) {
        return nil;
    }
    char *name = malloc(size);
    if (sysctlbyname("hw.machine", name, &size, NULL, 0) < 0) {
        free(name);
        return nil;
    }
    
    NSString *machine = [NSString stringWithCString:name encoding:NSUTF8StringEncoding];
    free(name);
    return machine;
}

+ (BOOL)machineComponentsWithName:(NSString **)theName major:(NSString **)theMajor minor:(NSString **)theMinor
{
    NSString *machineName = [self machineName];
    if ([machineName length]) {
        NSInteger ii = 0;
        for (; ii < [machineName length]; ii++) {
            unichar c = [machineName characterAtIndex:ii];
            if (c >= '0' && c <= '9') {
                // End of name, begin of major
                if (theName) {
                    *theName = [machineName substringToIndex:ii];
                    break;
                }
            }
        }
        NSInteger jj = ii;
        for (; jj < [machineName length]; jj++) {
            if ([machineName characterAtIndex:jj] == ',') {
                if (theMajor) {
                    *theMajor = [machineName substringWithRange:NSMakeRange(ii, jj - ii)];
                }
                if (theMinor) {
                    *theMinor = [machineName substringFromIndex:jj + 1];
                }
                return YES;
            }
        }
    }
    return NO;
}

+ (BOOL)supportsAirdrop
{
    if ([UIDevice systemVersionFirstNumber] >= 7)
    {
        NSString *theName = nil;
        NSString *theMajor = nil;
        NSString *theMinor = nil;
        if ([self machineComponentsWithName:&theName major:&theMajor minor:&theMinor])
        {
            if ([theName isEqualToString:@"iPhone"] || [theName isEqualToString:@"iPod"])
            {
                return [theMajor intValue] >= 5;
            }
            if ([theName isEqualToString:@"iPad"])
            {
                return ([theMajor intValue] == 2 && [theMinor intValue] >= 5) // iPad mini
                ||
                ([theMajor intValue] == 3 && [theMinor intValue] >= 4)// iPad 4
                ||
                [theMajor intValue] >= 4; // Suppose all future models will support AirDrop
            }
        }
    }
    return NO;
}

//打印所有字体
+ (void)printAllFont
{
    NSArray *familyNames = [[NSArray alloc] initWithArray:[UIFont familyNames]];
    NSArray *fontNames;
    NSInteger indFamily, indFont;
    for(indFamily=0;indFamily<[familyNames count];++indFamily)
    {
        NSLog(@"Family name: %@", [familyNames objectAtIndex:indFamily]);
        fontNames =[[NSArray alloc]initWithArray:[UIFont fontNamesForFamilyName:[familyNames objectAtIndex:indFamily]]];
        for(indFont=0; indFont<[fontNames count]; ++indFont)
        {
            NSLog(@" Font name: %@",[fontNames objectAtIndex:indFont]);
        }
    }
}

+ (CGFloat)getiOSVersion
{
    return [[[UIDevice currentDevice] systemVersion] floatValue];
}

@end
