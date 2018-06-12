//
//  PFPageJumpTool.h
//  PurangFinanceVillage
//
//  Created by 王祥伟 on 2018/1/9.
//  Copyright © 2018年 ___PURANG___. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PFPageJumpTool : NSObject

//"app://isNav=false&native=true&name=ZZQMyOrderDetailViewController&SBName=&Identifier=&isPush=true&isHidesBottom=true<com.purang.pbd.ui.main.mine.shop.ShopMainMenuActivity>?orderNumStr=B20171031195020687"
+ (void)pageJumpWithString:(NSString *)string;

@end
