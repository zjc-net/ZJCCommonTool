//
//  UIViewController+Utils.h
//  PurangFinanceVillage-Bank
//
//  Created by zhiujunchun on 16/3/10.
//  Copyright © 2016年 ___PURANG___. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (Utils)
@property (nonatomic , strong) NSString *titleSelected;
+(UIViewController*) currentViewController;
+(UIViewController *)getRootVC;



+ (UIViewController *)getCurrentVC;
+ (UIViewController *)getCurrentVCFrom:(UIViewController *)rootVC;
@end
