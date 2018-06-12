//
//  PFPageJumpTool.m
//  PurangFinanceVillage
//
//  Created by 王祥伟 on 2018/1/9.
//  Copyright © 2018年 ___PURANG___. All rights reserved.
//

#import "PFPageJumpTool.h"
#import <objc/runtime.h>
#import "Utils.h"
#import "Header.h"
#import "XWAlertViewController.h"

@implementation PFPageJumpTool

+ (void)pageJumpWithString:(NSString *)string{
    [[self alloc] jump:string];
}

- (void)jump:(NSString *)string{
    if (IsEmpty(string)) return;
    
    //处理字符串
    NSArray *arr1 = [string componentsSeparatedByString:@"//"];
    NSString *string1 = [arr1 lastObject];
    if (IsEmpty(string1)) return;
    
    //拿到vc的属性
    NSArray *arr2 = [string1 componentsSeparatedByString:@"?"];
    NSString *property = [arr2 lastObject];
    NSArray *propertyArr = [property componentsSeparatedByString:@"&"];
    
    NSMutableDictionary *propertyDic = [NSMutableDictionary dictionary];
    for (NSString *str in propertyArr) {
        NSArray *temp = [str componentsSeparatedByString:@"="];
        [propertyDic setObject:[temp lastObject] forKey:[temp firstObject]];
    }
    
    //vc的其他配置
    NSString *string2 = [arr2 firstObject];
    if (IsEmpty(string2)) return;
    NSArray *arr4 = [string2 componentsSeparatedByString:@"<"];
    NSString *matchString = [arr4 firstObject];
    NSArray *matchArr = [matchString componentsSeparatedByString:@"&"];
    
    NSMutableDictionary *matchDic = [NSMutableDictionary dictionary];
    for (NSString *str in matchArr) {
        NSArray *temp = [str componentsSeparatedByString:@"="];
        [matchDic setObject:[temp lastObject] forKey:[temp firstObject]];
    }
    
    
    // 类名
    id instance = nil;
    NSString *class = [NSString stringWithFormat:@"%@", matchDic[@"name"]];
    const char *className = [class cStringUsingEncoding:NSASCIIStringEncoding];
    // 从一个字串返回一个类
    Class newClass = objc_getClass(className);
    if (!newClass){//找不到类名
        return;
    }
    
    
    
    
    // 创建对象
    if ([self isCheck:@"native" andDic:matchDic]) {
        instance = [[newClass alloc] init];
    }else{
        
        
        NSString *name = [NSString stringWithFormat:@"%@",matchDic[@"SBName"]];
        NSString *vcId = [NSString stringWithFormat:@"%@",matchDic[@"Identifier"]];
        if (name.length == 0 || vcId.length == 0) {
            return;
        }
        instance = SBVC(name, vcId);
    }
    
    [propertyDic enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        // 检测这个对象是否存在该属性
        if ([self checkIsExistPropertyWithInstance:instance verifyPropertyName:key]) {
            // 利用kvc赋值
            [instance setValue:obj forKey:key];
        }
    }];
    
    UIViewController *vc = instance;
    if ([self isCheck:@"isHidesBottom" andDic:matchDic]) {
        vc.hidesBottomBarWhenPushed = YES;
    }
    
    UIViewController *topVC = [XWAlertViewController getTopViewController];
    
    UIViewController *topVC1 = [self getCurrentVC];
    if ([class isEqualToString:@"PFAStoreTabbarViewController"] && [Format(propertyDic[@"isGoToDetail"]) isEqualToString:@"1"]) {
        
        //        NSArray * ControllersArray =  topVC1.navigationController.viewControllers;
        Class PFAStoreTabbarViewController = NSClassFromString(@"PFAStoreTabbarViewController");
        BOOL isHave = [topVC isKindOfClass:PFAStoreTabbarViewController];
        
        if (isHave) {
            
            
            UIViewController * DetailVC = [[NSClassFromString(@"PFGoodDetailViewController") alloc] init];
            [propertyDic enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
                // 检测这个对象是否存在该属性
                if ([self checkIsExistPropertyWithInstance:DetailVC verifyPropertyName:key]) {
                    // 利用kvc赋值
                    [DetailVC setValue:obj forKey:key];
                }
            }];
            DetailVC.hidesBottomBarWhenPushed = YES;
            [topVC.navigationController pushViewController:DetailVC animated:YES];
            
        }else{
            
            [topVC1.navigationController pushViewController:vc animated:NO];
            
        }
        
        return;
    }
    
    Class TabBar = NSClassFromString(@"IndexTabBarViewController");
    
    if ([topVC isKindOfClass:TabBar]) {
        
        UITabBarController *tabbarVC = (UITabBarController *)[XWAlertViewController getTopViewController];
        if ([matchDic objectForKey:@"selectedIndex"]) {
            tabbarVC.selectedIndex = [[matchDic objectForKey:@"selectedIndex"] integerValue];
        }
        topVC = tabbarVC.selectedViewController;
        if ([topVC isKindOfClass:[UINavigationController class]]) {
            topVC = [(UINavigationController *)topVC topViewController];
        }
    }
    if ([self isCheck:@"isHidesNav" andDic:matchDic]) {
        topVC1.navigationController.navigationBarHidden = YES;
    }
    
    if ([self isCheck:@"isPush" andDic:matchDic]) {
        [topVC1.navigationController pushViewController:vc animated:YES];
    }else{
        if ([self isCheck:@"isNav" andDic:matchDic]) {
            UINavigationController * nav = [[UINavigationController alloc] initWithRootViewController:vc];
            [topVC1 presentViewController:nav animated:YES completion:nil];
        }else{
            [topVC1 presentViewController:vc animated:YES completion:nil];
        }
    }
}

- (BOOL)isCheck:(NSString *)string andDic:(NSDictionary *)dic{
    if ([dic objectForKey:string]) {
        NSString *temp = [dic objectForKey:string];
        if ([temp isEqualToString:@"true"]) {
            return YES;
        }
    }
    return NO;
}

/**
 *  检测对象是否存在该属性
 */
- (BOOL)checkIsExistPropertyWithInstance:(id)instance verifyPropertyName:(NSString *)verifyPropertyName
{
    unsigned int outCount, i;
    
    // 获取对象里的属性列表
    objc_property_t * properties = class_copyPropertyList([instance
                                                           class], &outCount);
    
    for (i = 0; i < outCount; i++) {
        objc_property_t property =properties[i];
        //  属性名转成字符串
        NSString *propertyName = [[NSString alloc] initWithCString:property_getName(property) encoding:NSUTF8StringEncoding];
        // 判断该属性是否存在
        if ([propertyName isEqualToString:verifyPropertyName]) {
            free(properties);
            return YES;
        }
    }
    free(properties);
    
    return NO;
}

-(UIViewController *)getCurrentVC {
    
    UIWindow *window = [[UIApplication sharedApplication].windows firstObject];
    if (!window) {
        return nil;
    }
    UIView *tempView;
    for (UIView *subview in window.subviews) {
        if ([[subview.classForCoder description] isEqualToString:@"UILayoutContainerView"]) {
            tempView = subview;
            break;
        }
    }
    if (!tempView) {
        tempView = [window.subviews lastObject];
    }
    
    id nextResponder = [tempView nextResponder];
    while (![nextResponder isKindOfClass:[UIViewController class]] || [nextResponder isKindOfClass:[UINavigationController class]] || [nextResponder isKindOfClass:[UITabBarController class]]) {
        tempView =  [tempView.subviews firstObject];
        
        if (!tempView) {
            return nil;
        }
        nextResponder = [tempView nextResponder];
    }
    return  (UIViewController *)nextResponder;
}



@end
