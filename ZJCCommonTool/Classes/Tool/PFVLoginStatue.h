//
//  PFVLoginStatue.h
//  PurangFinanceVillage
//
//  Created by zhoujunchun on 2018/5/24.
//  Copyright © 2018年 ___PURANG___. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PFVLoginStatue : NSObject

@property (nonatomic, assign) BOOL isLogin;

+ (instancetype)sharedInstance;

@end
