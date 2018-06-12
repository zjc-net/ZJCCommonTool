//
//  XWAlertViewController.h
//  XWEncapsulation
//
//  Created by wangxiangwei on 17/3/16.
//  Copyright © 2017年 purang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XWAlertViewController : UIView

/**
 *  点击'取消'响应block  UIAlertActionStyleCancel
 */
typedef void (^cancelBlock)(id cancel);

/**
 *  点击'确定'响应block  UIAlertActionStyleDefault
 */
typedef void (^sureBlock)(id sure);

/**
 *  There is only one default options
 *
 *  @param title   title
 *  @param message message
 */
+ (void)alertControllerWithTitle:(NSString *)title message:(NSString *)message;

/**
 *  There is only one default options
 *
 *  @param vc      viewController
 *  @param title   title
 *  @param message message
 */
+ (void)alertControllerInVC:(UIViewController *)vc title:(NSString *)title message:(NSString *)message;

/**
 *  Only a confirmation options, the default value is '确定'
 *
 *  @param vc          viewController
 *  @param title       title
 *  @param message     message
 *  @param cancelTitle title
 */
+ (void)alertControllerInVC:(UIViewController *)vc title:(NSString *)title message:(NSString *)message cancelTitle:(NSString *)cancelTitle;

/**
 *  If a default option, with a click option processing events
 *
 *  @param vc          viewController
 *  @param title       title
 *  @param message     message
 *  @param cancelTitle title
 *  @param cancelBlock block
 */
+ (void)alertControllerInVC:(UIViewController *)vc title:(NSString *)title message:(NSString *)message cancelTitle:(NSString *)cancelTitle cancel:(cancelBlock)cancelBlock;

/**
 *  There are two options, respectively with click options
 *
 *  @param vc          viewController
 *  @param title       title
 *  @param message     message
 *  @param cancelTitle title
 *  @param cancelBlock block
 *  @param sureTitle   title
 *  @param sureBlock   block
 */
+ (void)alertControllerInVC:(UIViewController *)vc title:(NSString *)title message:(NSString *)message cancelTitle:(NSString *)cancelTitle cancel:(cancelBlock)cancelBlock sureTitle:(NSString *)sureTitle sure:(sureBlock)sureBlock;

/**
 *  There are N options, respectively with click options handle events
 *
 *  @param vc          viewController
 *  @param title       title
 *  @param message     message
 *  @param cancelTitle title
 *  @param cancelBlock block
 *  @param otherTitle  title
 *  @param sureBlock   block
 */
+ (void)alertControllerInVC:(UIViewController *)vc title:(NSString *)title message:(NSString *)message cancelTitle:(NSString *)cancelTitle cancel:(cancelBlock) cancelBlock otherTitle:(NSArray <NSString *>*)otherTitle sure:(sureBlock)sureBlock;

/**
 *  There are N options and style, respectively with click options handle events
 *
 *  @param vc          viewController
 *  @param style       style
 *  @param title       title
 *  @param message     message
 *  @param cancelTitle style
 *  @param cancelBlock block
 *  @param otherTitle  style
 *  @param sureBlock   block
 */
+ (void)alertControllerInVC:(UIViewController *)vc style:(UIAlertControllerStyle)style title:(NSString *)title message:(NSString *)message cancelTitle:(NSString *)cancelTitle cancel:(cancelBlock) cancelBlock otherTitle:(NSArray <NSString *>*)otherTitle sure:(sureBlock)sureBlock;


+ (void)alertControllerInVC:(UIViewController *)vc title:(NSString *)title message:(NSString *)message titleAlignment:(NSTextAlignment)titleAlignment messageAlignment:(NSTextAlignment)messageAlignment cancelTitle:(NSString *)cancelTitle cancel:(cancelBlock)cancelBlock sureTitle:(NSString *)sureTitle sure:(sureBlock)sureBlock;


+ (void)alertControllerInVC:(UIViewController *)vc title:(NSString *)title message:(NSString *)message textAlignment:(NSTextAlignment)textAlignment cancelTitle:(NSString *)cancelTitle cancel:(cancelBlock)cancelBlock sureTitle:(NSString *)sureTitle sure:(sureBlock)sureBlock;


// 当前控制器
+ (UIViewController *)getTopViewController;

@end
