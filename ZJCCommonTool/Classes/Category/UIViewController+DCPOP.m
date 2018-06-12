//
//  UIViewController+DCPOP.m
//  PurangFinanceVillage
//
//  Created by daichen on 2017/4/27.
//  Copyright © 2017年 ___PURANG___. All rights reserved.
//

#import "UIViewController+DCPOP.h"
#import <objc/runtime.h>
#import "Header.h"
#import "UIFont+PFVCommon.h"

@implementation UIViewController (DCPOP)

+ (void)load
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class class = [self class];
        swizzleMethod(class, @selector(viewWillAppear:), @selector(hc_viewWillAppear:));
        swizzleMethod(class, @selector(viewWillDisappear:), @selector(hc_viewWillDisappear:));
    });
}

void swizzleMethod(Class class, SEL originalSelector, SEL swizzledSelector){
    
    Method originalMethod = class_getInstanceMethod(class, originalSelector);
    Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
    BOOL didAddMethod = class_addMethod(class,
                                        originalSelector,
                                        method_getImplementation(swizzledMethod),
                                        method_getTypeEncoding(swizzledMethod));if (didAddMethod) {
        class_replaceMethod(class,
                            swizzledSelector,
                            method_getImplementation(originalMethod),
                            method_getTypeEncoding(originalMethod));
    } else {
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
}

- (void)hc_viewWillAppear:(BOOL)animated {
    
    [self hc_viewWillAppear:animated];
    
    if ([self isKindOfClass:[UINavigationController class]]) {
        
//        [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(0, -60) forBarMetrics:UIBarMetricsDefault];
        
        self.view.backgroundColor = [UIColor colorWithWhite:0.94f alpha:1.0f];
        self.edgesForExtendedLayout = UIRectEdgeNone;
        
//        [[UINavigationBar appearance] setBackgroundImage:IMG(@"naviBarBG") forBarMetrics:UIBarMetricsDefault];
        //设置导航栏背景色
//        [[UINavigationBar appearance] setBarTintColor:[UIColor colorFromHexCode:@"344E71"]];
        //设置导航栏文字图片背景颜色
        [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
        [[UINavigationBar appearance] setTranslucent:NO];
//        //设置导航栏 文字颜色、字体大小
        [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName:[UIFont fontWithFontName:FontNamePingFangRegular size:18.0f]}];
        if (iPhoneX) {
            [[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@"naviBarBG_X"] forBarMetrics:UIBarMetricsDefault];
        }else{
            [[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@"naviBarBG"] forBarMetrics:UIBarMetricsDefault];
        }
        //tabBar 背景颜色
//        for (id obj in self.childViewControllers) {
//            if ([obj isMemberOfClass:[UIViewController class]]) {
//                [[UINavigationBar appearance] setBarTintColor:[UIColor whiteColor]];
//            }else{//PUUIAlbumListViewController,PUPhotoPickerHostViewController
//                [[UINavigationBar appearance] setBarTintColor:[UIColor colorFromHexCode:@"344E71"]];
//                break;
//            }
//        }
    }
}



-(void)hc_viewWillDisappear:(BOOL)animated{
    
    [self hc_viewWillDisappear:animated];
}


@end
