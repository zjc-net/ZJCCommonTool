//
//  DCViewController.m
//  BrightSunnySky
//
//  Created by purang\daichen on 2017/4/5.
//  Copyright © 2017年 PURANG. All rights reserved.
//

#import "DCViewController.h"
#import "YTKNetworkAgent.h"

#import "UIColor+HexCode.h"
#import "Header.h"
#import "UIView+Frame.h"
#import "UIFont+PFVCommon.h"
#import "PFPageJumpTool.h"

@interface DCViewController ()<MBProgressHUDDelegate>

@end

@implementation DCViewController

- (void)viewDidLoad{
    [super viewDidLoad];
    self.view.backgroundColor = COLORRGB(229, 242, 252);
//    [self.navigationController.navigationBar.subviews[0].layer addSublayer:self.dcGradientLayer];
    self.dcheaderNaviHeight = StatusBarAndNavigationBarHeight;
}

- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    if (_baseRequest) {
        [[YTKNetworkAgent  sharedAgent] cancelRequest:_baseRequest];
    }
    DLog(@"%@ dealloc",NSStringFromClass([self class]));
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}

- (void)alertView:(NSString *)message {
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"提示" message:message preferredStyle:UIAlertControllerStyleAlert];
    [alertVC addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }]];
    [self presentViewController:alertVC animated:YES completion:nil];
}

- (void)alertViewTitle:(NSString *)title message:(NSString *)message actionTitle:(NSString *)actionTitle{
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    [alertVC addAction:[UIAlertAction actionWithTitle:actionTitle style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }]];
    [self presentViewController:alertVC animated:YES completion:nil];
}

- (void)setupBackItem{
    self.dcbackBtn.frame = CGRectMake(0, 0, 30, 30);
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:self.dcbackBtn];
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, 30, 30);
    UIBarButtonItem *oneItem = [[UIBarButtonItem alloc]initWithCustomView:btn];
    self.navigationItem.leftBarButtonItems = @[item, oneItem];
}

- (void)setupRightItem{
    self.dcrightButton.frame = CGRectMake(0, 0, 30, 30);
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:self.dcrightButton];
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, 30, 30);
    UIBarButtonItem *oneItem = [[UIBarButtonItem alloc]initWithCustomView:btn];
    self.navigationItem.rightBarButtonItems = @[item, oneItem];
}

- (void)backBtnClick {
    [self hideHUDView];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)clickdcKindBtn:(UIButton *)sender{
    
}

- (void)clickdcRightButton:(UIButton *)sender{
    
}

- (void)presentLoginVC{
    
    [PFPageJumpTool pageJumpWithString:@"app://isNav=ture&native=flase&name=LoginViewController&SBName=LoginController&Identifier=Login&isPush=true&isHidesBottom=true<>"];
    
//    UIStoryboard* userCenterSB = [UIStoryboard storyboardWithName:@"LoginController" bundle:[NSBundle mainBundle]];
//    LoginViewController* loginVC = [userCenterSB instantiateViewControllerWithIdentifier:@"Login"];
//    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:loginVC];
//    [self presentViewController:nav animated:YES completion:nil];
}


- (void)presentCompleteInfoVC{
    UIAlertController* alertVC = [UIAlertController alertControllerWithTitle:@"提示" message:@"您尚未信息尚未完善，是否补全信息" preferredStyle:UIAlertControllerStyleAlert];
    [alertVC addAction:[UIAlertAction actionWithTitle:@"是" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        [PFPageJumpTool pageJumpWithString:@"app://isNav=ture&native=flase&name=LoginViewController&SBName=LoginController&Identifier=PFCompletionInformationLaterVC&isPush=true&isHidesBottom=true<>?isRegist=0"];
        
//        PFCompletionInformationLaterVC *vc = SBVC(@"LoginController", @"PFCompletionInformationLaterVC");
//        vc.isRegist = NO;
//        vc.hidesBottomBarWhenPushed = YES;
//        UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:vc];
//        [self presentViewController:nav animated:YES completion:nil];
    }]];
    [alertVC addAction:[UIAlertAction actionWithTitle:@"否" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }]];
    [self presentViewController:alertVC animated:YES completion:nil];

}

#pragma mark - touchesBegan

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    //点击空白 消除键盘
    [self.view endEditing:YES];
}

#pragma mark - HUDView

- (void)showErrorHint:(NSError *)error{
    NSString *msg = @"服务器异常，请稍候再试!";
    switch (error.code) {
        case -999:
            //请求取消，不提示
            return;
        case -1000:
        case -1002:
            msg = @"系统异常，请稍后再试";
            break;
        case -1001:
            msg = @"请求超时，请检查您的网络!";
            break;
        case -1004:
        case -1005:
        case -1006:
        case -1009:
            msg = @"网络异常，请检查您的网络!";
            break;
        default:
            break;
    }
    [self show:msg icon:nil];
}

- (void)showHUDView:(NSString *)text{
    
    [UIActivityIndicatorView appearanceWhenContainedIn:[MBProgressHUD class], nil].color = [UIColor whiteColor];
    _HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    _HUD.delegate = self;
    _HUD.label.text = text;
    _HUD.label.textColor = [UIColor whiteColor];
    _HUD.bezelView.backgroundColor = [UIColor blackColor];
    
    [self.view endEditing:YES];
}

- (void)showHUDViewHadNav:(NSString *)text{
    
    [UIActivityIndicatorView appearanceWhenContainedIn:[MBProgressHUD class], nil].color = [UIColor whiteColor];
    _HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    _HUD.delegate = self;
    _HUD.label.text = text;
    _HUD.label.textColor = [UIColor whiteColor];
    _HUD.bezelView.backgroundColor = [UIColor blackColor];
    
    _HUD.frame = CGRectMake(0, StatusBarAndNavigationBarHeight, SCREEN_WIDTH, SCREEN_HEIGHT-StatusBarAndNavigationBarHeight);
    
    [self.view endEditing:YES];
}


- (void)hideHUDView{
    //    [_HUD hide:YES];
    [_HUD hideAnimated:YES];
}

#pragma mark - HUD显示异常

- (void)showHUDText:(NSString *)content{
    [self show:content icon:nil];
}

- (void)showHUDError:(NSString *)error{
    [self show:error icon:@"hud_error"];
}

- (void)showHUDSuccess:(NSString *)success{
    [self show:success icon:@"hud_success"];
}

- (void)show:(NSString *)text icon:(NSString *)icon{
    [self hideHUDView];
//    UIView *view = [UIApplication sharedApplication].keyWindow;
    if (IsEmpty(text)) {
        return;
    }
    // 快速显示一个提示信息
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.detailsLabel.text = text;
    hud.detailsLabel.font = [UIFont systemFontOfSize:14];
    // 设置图片
    hud.customView = [[UIImageView alloc]initWithImage:IMG(icon)];
    // 再设置模式
    hud.mode = MBProgressHUDModeCustomView;
    hud.bezelView.backgroundColor = [UIColor blackColor];
    hud.detailsLabel.textColor = [UIColor whiteColor];
    [UIActivityIndicatorView appearanceWhenContainedIn:[MBProgressHUD class], nil].color = [UIColor whiteColor];
    // 隐藏时候从父控件中移除
    hud.removeFromSuperViewOnHide = YES;
    
    double delayTime = 1.2;
    delayTime = MAX(delayTime, text.length*0.3);
    delayTime = MIN(delayTime, 2.5);
    // 1秒之后再消失
    [hud hideAnimated:YES afterDelay:delayTime];
}

#pragma mark - MBProgressHUDDelegate

- (void)hudWasHidden:(MBProgressHUD *)hud {
    // Remove HUD from screen when the HUD was hidded
    [_HUD removeFromSuperview];
    _HUD = nil;
}

- (CAGradientLayer *)dcGradientLayer{
    if (!_dcGradientLayer) {
        _dcGradientLayer = [CAGradientLayer layer];
        _dcGradientLayer.colors = @[(__bridge id)COLORRGB(80, 158, 197).CGColor, (__bridge id)COLORRGB(141, 196, 221).CGColor];
        _dcGradientLayer.locations = @[@0.3, @1.0];
        _dcGradientLayer.startPoint = CGPointMake(0, 0);
        _dcGradientLayer.endPoint = CGPointMake(0.0, 1.0);
        _dcGradientLayer.frame = CGRectMake(0, 0, SCREEN_WIDTH, StatusBarAndNavigationBarHeight);
    }
    return _dcGradientLayer;
}

- (void)setDcheaderNaviHeight:(CGFloat)dcheaderNaviHeight{
    _dcheaderNaviHeight  =  dcheaderNaviHeight;
    self.dcheaderNaviView.height = dcheaderNaviHeight;
    self.dcGradientLayer.frame = CGRectMake(0, 0, WIDTHOf(self.dcheaderNaviView), dcheaderNaviHeight);
}

- (void)setTitle:(NSString *)title{
    [super setTitle:title];
    self.dctitleNaviLabel.text = title;
}

- (UIView *)dcheaderNaviView{
    if (!_dcheaderNaviView) {
        _dcheaderNaviView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, self.dcheaderNaviHeight)];
        _dcheaderNaviView.backgroundColor = COLORRGB(80, 158, 197);
        [_dcheaderNaviView.layer addSublayer:self.dcGradientLayer];
        [_dcheaderNaviView addSubview:self.dctitleNaviLabel];
    }
    return _dcheaderNaviView;
}

- (UILabel *)dctitleNaviLabel{
    if (!_dctitleNaviLabel) {
        _dctitleNaviLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, StatusBarHeight, 200, 44)];
        _dctitleNaviLabel.textColor = [UIColor whiteColor];
        _dctitleNaviLabel.backgroundColor = [UIColor clearColor];
        _dctitleNaviLabel.centerX = SCREEN_WIDTH/2;
        _dctitleNaviLabel.font = [UIFont fontWithFontName:FontNamePingFangRegular size:18.f];
        _dctitleNaviLabel.textAlignment = NSTextAlignmentCenter;
        _dctitleNaviLabel.text = self.title;
    }
    return _dctitleNaviLabel;
}

- (UIButton *)dcbackBtn{
    if (!_dcbackBtn) {
        _dcbackBtn= [UIButton buttonWithType:UIButtonTypeCustom];
        _dcbackBtn.frame = CGRectMake(0, StatusBarHeight, 44, 44);
        [_dcbackBtn setImage:[UIImage imageNamed:@"fanhui"] forState:UIControlStateNormal];
        [_dcbackBtn addTarget:self action:@selector(backBtnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _dcbackBtn;
}

- (UIButton *)dcrightButton{
    if (!_dcrightButton) {
        _dcrightButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _dcrightButton.frame = CGRectMake(SCREEN_WIDTH-50, StatusBarHeight, 44, 44);
        [_dcrightButton setTitleColor:COLORRGB(21, 93 ,23) forState:UIControlStateNormal];
        [_dcrightButton addTarget:self action:@selector(clickdcRightButton:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _dcrightButton;
}


- (UIButton *)dckindBtn{
    if (!_dckindBtn) {
        _dckindBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_dckindBtn addTarget:self action:@selector(clickdcKindBtn:) forControlEvents:UIControlEventTouchUpInside];
        _dckindBtn.frame = CGRectMake(0, StatusBarHeight+8, 78, 28);
        _dckindBtn.titleLabel.font = SYSTEMFONT(18);
        [_dckindBtn setBackgroundImage:OrigIMG(@"titleBtnbackImage") forState:0];
    }
    return _dckindBtn;
}
@end
