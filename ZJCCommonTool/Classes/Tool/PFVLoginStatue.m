//
//  PFVLoginStatue.m
//  PurangFinanceVillage
//
//  Created by zhoujunchun on 2018/5/24.
//  Copyright © 2018年 ___PURANG___. All rights reserved.
//

#import "PFVLoginStatue.h"



@interface PFVLoginStatue()


@end

@implementation PFVLoginStatue
static dispatch_once_t onceToken;

static PFVLoginStatue *instance;
+ (instancetype)sharedInstance {
    
    dispatch_once(&onceToken, ^{
        
        instance = [PFVLoginStatue new];
        
    });
    return instance;
}


- (instancetype)initPrivate{
    self  = [super init];
    return self;
}

@end
