//
//  UIButton+Touch.m
//  PurangFinanceVillage
//
//  Created by wangxiangwei on 2017/10/10.
//  Copyright © 2017年 ___PURANG___. All rights reserved.
//

#import "UIButton+Touch.h"
#import <objc/runtime.h>

@interface UIButton()
/**bool 类型   设置是否执行点UI方法*/
@property (nonatomic, assign) BOOL isIgnoreEvent;
@end

@implementation UIButton (Touch)

+ (void)load{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        SEL selA = @selector(sendAction:to:forEvent:);
        SEL selB = @selector(PFSendAction:to:forEvent:); // B是自己定义的方法
        Method methodA =   class_getInstanceMethod(self,selA);
        Method methodB = class_getInstanceMethod(self, selB);
        BOOL isAdd = class_addMethod(self, selA, method_getImplementation(methodB), method_getTypeEncoding(methodB));
        if (isAdd) {
            class_replaceMethod(self, selB, method_getImplementation(methodA), method_getTypeEncoding(methodA));
        }else{
            method_exchangeImplementations(methodA, methodB);
        }
    });
}

- (void)PFSendAction:(SEL)action to:(id)target forEvent:(UIEvent *)event{
    if ([NSStringFromClass(self.class) isEqualToString:@"UIButton"]) {
        if (self.timeInterval > 0) {
            
            if (self.isIgnoreEvent) {
                return;
            }
            
            self.isIgnoreEvent = YES;
            [self performSelector:@selector(setIsIgnoreEvent:) withObject:(id)NO afterDelay:self.timeInterval];
        }
    }
    [self PFSendAction:action to:target forEvent:event];
}

- (NSTimeInterval)timeInterval{
    return [objc_getAssociatedObject(self, _cmd) doubleValue];
}

- (void)setTimeInterval:(NSTimeInterval)timeInterval{
    objc_setAssociatedObject(self, @selector(timeInterval), @(timeInterval), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BOOL)isIgnoreEvent{
    return [objc_getAssociatedObject(self, _cmd) boolValue];
}

- (void)setIsIgnoreEvent:(BOOL)isIgnoreEvent{
    objc_setAssociatedObject(self, @selector(isIgnoreEvent), @(isIgnoreEvent), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
