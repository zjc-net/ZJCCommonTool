//
//  PRWaitingView.h
//  PurangFinance
//
//  Created by liumingkui on 15/5/15.
//  Copyright (c) 2015年 ___PURANG___. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PRWaitingView : UIView

- (instancetype)initWithFrame:(CGRect)frame withCornerRadius:(float)cornerRadius;
- (void)showInView:(UIView*)supView;
- (void)remove;

@end
