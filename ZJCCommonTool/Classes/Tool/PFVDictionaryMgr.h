//
//  PFVDictionaryMgr.h
//  PurangFinanceVillage
//
//  Created by daichen on 2017/5/3.
//  Copyright © 2017年 ___PURANG___. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PFVDictionaryMgr : NSObject

//根据错误码 ->  错误信息
+ (NSString *)getErrorMessageByResponseCode:(NSInteger)code;
//根据票类名->票类type
+ (NSString *)getNoteType:(NSString *)noteName;
//根据票据交易模式Code-->票据交易模式名
+ (NSString *)getTradeModelNameByCode:(NSString *)code;
+ (NSString *)getTradeModeCodeByName:(NSString *)name;

//根据承兑行返回承兑类别
+ (NSString *)getAcceptType:(NSString *)acceptName;
//根据承兑类别返回承兑行
+ (NSString *)getBankName:(NSString *)bankType;
//转贴根据承兑行返回承兑类
+ (NSString *)getQuoteAcceptType:(NSString *)acceptName;
//转贴根据承兑类别返回承兑行
+ (NSString *)getQuoteBankName:(NSString *)bankType;
//撤单原因
+ (NSString *)getQuitReasonCode:(NSString *)reason;
//债券日历 筛选项 产品->code数组String
+ (NSString *)getBondProductListArrayStr:(NSArray *)array;
//债券日历 筛选项 主体评级->code数组String
+ (NSString *)getBondMainRatingListArrayStr:(NSArray *)array;
//债券日历 筛选项 期限->code数组String
+ (NSString *)getBondPeriodListArrayStr:(NSArray *)array;
@end
