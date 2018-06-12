//
//  UIViewController+Utils.m
//  PurangFinanceVillage-Bank
//
//  Created by zhiujunchun on 16/3/10.
//  Copyright © 2016年 ___PURANG___. All rights reserved.
//

#import "UIViewController+Utils.h"
#import <objc/runtime.h>
static void *titleKey = &titleKey;

@implementation UIViewController (Utils)

- (void)setTitleSelected:(NSString *)titleSelected{
    objc_setAssociatedObject(self, &titleKey, titleSelected, OBJC_ASSOCIATION_COPY);
}

- (NSString *)titleSelected{
    return objc_getAssociatedObject(self, &titleKey);
}

+(UIViewController*) findBestViewController:(UIViewController*)vc {
    
    if (vc.presentedViewController) {
        
        // Return presented view controller
        return [UIViewController findBestViewController:vc.presentedViewController];
        
    } else if ([vc isKindOfClass:[UISplitViewController class]]) {
        
        // Return right hand side
        UISplitViewController* svc = (UISplitViewController*) vc;
        if (svc.viewControllers.count > 0)
            return [UIViewController findBestViewController:svc.viewControllers.lastObject];
        else
            return vc;
        
    } else if ([vc isKindOfClass:[UINavigationController class]]) {
        
        // Return top view
        UINavigationController* svc = (UINavigationController*) vc;
        if (svc.viewControllers.count > 0)
            return [UIViewController findBestViewController:svc.topViewController];
        else
            return vc;
        
    } else if ([vc isKindOfClass:[UITabBarController class]]) {
        
        // Return visible view
        UITabBarController* svc = (UITabBarController*) vc;
        if (svc.viewControllers.count > 0)
            return [UIViewController findBestViewController:svc.selectedViewController];
        else
            return vc;
        
    } else {
        
        // Unknown view controller type, return last child view controller
        return vc;
        
    }
    
}

+(UIViewController*) currentViewController {
    
    // Find best view controller
    UIViewController* viewController = [UIApplication sharedApplication].keyWindow.rootViewController;
    return [UIViewController findBestViewController:viewController];
    
}

//获取当前根控制器
+ (UIViewController *)getRootVC
{
    UIViewController *result = nil;
    
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    if (window.windowLevel != UIWindowLevelNormal)
    {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow * tmpWin in windows)
        {
            if (tmpWin.windowLevel == UIWindowLevelNormal)
            {
                window = tmpWin;
                break;
            }
        }
    }
    
    UIView * frontView = [[window subviews] objectAtIndex:0];
    id nextResponder = [frontView nextResponder];
    int i = 0;
    while(![nextResponder isKindOfClass:[UIViewController class]])//这里跳不出来。。。有人说这里跳不出来，其实是因为它没有当前这个view放入ViewController中，自然也就跳不出来了，会死循环，使用时需要注意。
    {
        nextResponder = [nextResponder nextResponder];
        i++;
        if (i>3) {
            break;
        }
    }
    if ([nextResponder isKindOfClass:[UIViewController class]])
    {
        result = (UIViewController *)nextResponder;
    } else {
        result = window.rootViewController;
    }
    
    //    if ([nextResponder isKindOfClass:[UIViewController class]])
    //        result = nextResponder;
    //    else
    //        if ([window respondsToSelector:@selector(rootViewController)] && window.rootViewController != nil){
    //        result = window.rootViewController;
    //    }else
    //
    //        NSAssert(NO, @"ShareKit: Could not find a root view controller.  You can assign one manually by calling [[SHK currentHelper] setRootViewController:YOURROOTVIEWCONTROLLER].");
    
    
    return result;
}


+ (UIViewController *)getCurrentVC
{
    UIViewController *rootViewController = [UIApplication sharedApplication].keyWindow.rootViewController;
    
    UIViewController *currentVC = [UIViewController getCurrentVCFrom:rootViewController];
    
    return currentVC;
}

+ (UIViewController *)getCurrentVCFrom:(UIViewController *)rootVC
{
    UIViewController *currentVC;
    
    if ([rootVC presentedViewController]) {
        // 视图是被presented出来的
        
        rootVC = [rootVC presentedViewController];
    }
    
    if ([rootVC isKindOfClass:[UITabBarController class]]) {
        // 根视图为UITabBarController
        
        currentVC = [self getCurrentVCFrom:[(UITabBarController *)rootVC selectedViewController]];
        
    } else if ([rootVC isKindOfClass:[UINavigationController class]]){
        // 根视图为UINavigationController
        
        currentVC = [self getCurrentVCFrom:[(UINavigationController *)rootVC visibleViewController]];
        
    } else {
        // 根视图为非导航类
        
        currentVC = rootVC;
    }
    
    return currentVC;
}
@end
