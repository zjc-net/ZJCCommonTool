//
//  DCViewController.h
//  BrightSunnySky
//
//  Created by purang\daichen on 2017/4/5.
//  Copyright © 2017年 PURANG. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"
#import "PRBaseRequest.h"
@interface DCViewController : UIViewController
{
    PRBaseRequest    *_baseRequest;
    MBProgressHUD *_HUD;
//    UIButton* _backLeftBtn;
}

@property (nonatomic, strong) NSDictionary *data;
@property (nonatomic, strong) CAGradientLayer *dcGradientLayer;


@property (strong, nonatomic)  UIButton * dckindBtn;

@property (nonatomic, strong) UIView *dcheaderNaviView;
@property (nonatomic, strong) UILabel *dctitleNaviLabel;
@property (nonatomic, strong) UIButton *dcbackBtn;

@property (nonatomic, strong)UIButton *dcrightButton;
//导航视图高度
@property (nonatomic, assign) CGFloat dcheaderNaviHeight;
- (void)clickdcRightButton:(UIButton *)sender;
- (void)clickdcKindBtn:(UIButton *)sender;

//设置返回按钮
- (void)setupBackItem;
//设置右边按钮
- (void)setupRightItem;
- (void)backBtnClick;

- (void)presentLoginVC;
- (void)presentCompleteInfoVC;

/**
 *  请求请求系统错误提示
 *
 *  @param error 错误内容
 */
- (void)showErrorHint:(NSError *)error;
- (void)showHUDText:(NSString *)content;
- (void)showHUDView:(NSString *)text;
- (void)showHUDError:(NSString *)error;
//- (void)showHUDSuccess:(NSString *)success;
- (void)hideHUDView;
- (void)showHUDViewHadNav:(NSString *)text;
- (void)dealloc;


- (void)alertView:(NSString *)message;
- (void)alertViewTitle:(NSString *)title message:(NSString *)message actionTitle:(NSString *)actionTitle;
@end
