//
//  PFVDictionaryMgr.m
//  PurangFinanceVillage
//
//  Created by daichen on 2017/5/3.
//  Copyright © 2017年 ___PURANG___. All rights reserved.
//

#import "PFVDictionaryMgr.h"

#import "Header.h"
#import "Utils.h"

@implementation PFVDictionaryMgr


+ (NSString *)getErrorMessageByResponseCode:(NSInteger)code{
    NSString *message;
    switch (code) {
        case 1:
            message = @"用户不存在";
            break;
        case 2:
            message = @"该手机号已被注册";
            break;
        case 3:
            message = @"系统错误";
            break;
        case 4:
            message = @"验证码已过期";
            break;
        case 5:
            message = @"验证码发送次数超过限制";
            break;
        case 6:
            message = @"参数为空";
            break;
        case 7:
            message = @"数据不一致";
            break;
        case 8:
            message = @"未授权访问";
            break;
        case 9:
            message = @"密码不正确";
            break;
        case 10:
            message = @"获取验证码错误";
            break;
        case 11:
            message = @"验证码不存在";
            break;
        case 12:
            message = @"超过最大上传限制2M";
            break;
        case 13:
            message = @"不支持上传文件的类型";
            break;
        case 14:
            message = @"没有传入登录账号";
            break;
        case 15:
            message = @"用户已存在或者不唯一";
            break;
        case 16:
            message = @"参数错误";
            break;
        case 17:
            message = @"强制下线";
            break;
        case 18:
            message = @"登录需要验证码";
            break;
        case 19:
            message = @"机构用户已经注册但未审核通过";
            break;
        case 20:
            message = @"价格倒挂";
            break;
        case 21:
            message = @"债券无法计算";
            break;
        case 22:
            message = @"净价输入非法";
            break;
        case 23:
            message = @"全价输入非法";
            break;
        case 24:
            message = @"申购业务状态已变更，请重新获取数据";
            break;
        case 25:
            message = @"您不能同时处理多笔业务，请处理后再次点击";
            break;
        case 26:
            message = @"业务状态已变更，不可修改";
            break;
        case 27:
            message = @"客户无归属，不可申报";
            break;
        case 29:
            message = @"业务状态已变更，请重新获取数据";
            break;
        case 31:
            message = @"调用太频繁";
            break;
        case 32:
            message = @"图形验证码已失效,请重新填写";
            break;
        case 33:
            message = @"图形验证码不正确";
            break;
        case 34:
            message = @"有交易中子单，无法进行操作";
            break;
        case 35:
            message = @"剩余金额小于等于0时，不可进行撤单操作";
            break;
        case 36:
            message = @"剩余金额小于等于0时，不可进行撤单操作";
            break;
        case 37:
            message = @"此贴现人暂无直贴-卖出的申报/申购权限，请更换贴现人";
            break;
        case 99:
            message = @"请更新至最新版本";
            break;
        
        case -1000:
        case -1002:
            message = @"系统异常，请稍后再试";
            break;
        case -1001:
            message = @"请求超时，请检查您的网络!";
            break;
        case -1005:
        case -1006:
        case -1009:
            message = @"网络异常，请检查您的网络!";
            break;
            
        default:
            message = @"系统正忙";
            break;
    }
    return message;
}

+ (NSString *)getNoteType:(NSString *)noteName{
    if (IsEmpty(noteName)) {
        return @"";
    }
    NSDictionary *noteDic = @{@"银票-纸票":@"1",
                              @"银票-电票":@"2",
                              @"商票-纸票":@"3",
                              @"商票-电票":@"4",
                              @"财票-纸票":@"5",
                              @"财票-电票":@"6"};
    
    
    return [Utils getResult:noteDic text:noteName];
    
}

+ (NSString *)getTradeModelNameByCode:(NSString *)code{
    if (IsEmpty(code)) {
        return @"";
    }
//    NSString *tradeName;
    NSDictionary *dic = @{
                                    @"1001":@"买断",
                                    @"1002":@"卖断",
                                    @"1003":@"正回购",
                                    @"1004":@"逆回购",
                                    @"1005":@"回买",
                                    @"1006":@"回卖"};
//    tradeName = tradeModelDic[code];
    return [Utils getResult:dic text:code];
}

+ (NSString *)getTradeModeCodeByName:(NSString *)name{
    NSString *code = @"";
    if ([name isEqualToString:@"买断"]) {
        code = @"1001";
    }else if ([name isEqualToString:@"卖断"]){
        code = @"1002";
    }else if ([name isEqualToString:@"正回购"]){
        code = @"1003";
    }else if ([name isEqualToString:@"逆回购"]){
        code = @"1004";
    }else if ([name isEqualToString:@"回买"]){
        code = @"1005";
    }else if ([name isEqualToString:@"回卖"]){
        code = @"1006";
    }
    return code;
}

+ (NSString *)getAcceptType:(NSString *)acceptName{
    if (IsEmpty(acceptName)) {
        return @"";
    }
//    NSString *type;
    NSDictionary *dic = @{
                          @"国有":@"3010",
                          @"股份":@"3015",
                          @"城商":@"3020",
                          @"农商":@"3030",
                          @"农信":@"3035",
                          @"农合":@"3036",
                          @"外资":@"3040",
                          @"村镇":@"3045",
                          @"财务":@"3046",
                          @"无":@"3050",
                          @"保兑":@"3060",
                          @"保贴":@"3065",
                          @"其他":@"3070"};
    
//    type = [dic objectForKey:acceptName];
//    return type;
    return [Utils getResult:dic text:acceptName];
}


//+ (NSString *)getAcceptLevel:(NSString *)text{
//    if (IsEmpty(text)) {
//        return @"";
//    }
//    NSString *type;
//    NSDictionary *dic = @{@"AAA":@"3010",
//                          @"AA+":@"3015",
//                          @"AA":@"3020",
//                          @"AA-":@"3030",
//                          @"A":@"3035"};
//    
//    type = [dic objectForKey:text];
//    return type;
//}

+ (NSString *)getBankName:(NSString *)bankType{
    if (IsEmpty(bankType)) {
        return @"";
    }
//    NSString *bankName;
    NSDictionary *dic = @{
                          @"3010":@"国有",
                          @"3015":@"股份",
                          @"3020":@"城商",
                          @"3030":@"农商",
                          @"3035":@"农信",
                          @"3036":@"农合",
                          @"3040":@"外资",
                          @"3045":@"村镇",
                          @"3046":@"财务",
                          @"3050":@"无",
                          @"3060":@"保兑",
                          @"3065":@"保贴",
                          @"3070":@"其他"
                          };
//    bankName = [dic objectForKey:bankType];
//    return bankName;
    
    return [Utils getResult:dic text:bankType];
}

+ (NSString *)getQuoteAcceptType:(NSString *)acceptName{
//    NSString *type;
    if (IsEmpty(acceptName)) {
        return @"";
    }
    NSDictionary *dic = @{@"国有":@"3010",
                          @"股份":@"3015",
                          @"城商":@"3020",
                          @"农商":@"3030",
                          @"农信":@"3035",
                          @"农合":@"3036",
                          @"外资":@"3040",
                          @"村镇":@"3045",
                          @"无保兑":@"3050",
                          @"财务":@"3046",
                          @"国股行背书":@"3055",
                          @"国股行保兑":@"3060",
                          @"其他":@"3070",
                          @"不限":@"3080",
                          @"保兑":@"3081",
                          @"保贴":@"3082",
                          @"无":@"3083"
                          };
    
//    type = [dic objectForKey:acceptName];
    return [Utils getResult:dic text:acceptName];
}

+ (NSString *)getQuoteBankName:(NSString *)bankType{
//    NSString *bankName;
    if (IsEmpty(bankType)) {
        return @"";
    }
    NSDictionary *dic = @{
                          @"3010":@"国有",
                          @"3015":@"股份",
                          @"3020":@"城商",
                          @"3030":@"农商",
                          @"3035":@"农信",
                          @"3036":@"农合",
                          @"3040":@"外资",
                          @"3045":@"村镇",
                          @"3046":@"财务",
                          @"3055":@"国股行背书",
                          @"3060":@"国股行保兑",
                          @"3050":@"无保兑",
                          @"3070":@"其他",
                          @"3080":@"不限",
                          @"3081":@"保兑",
                          @"3082":@"保贴",
                          @"3083":@"无"
                          };
//    bankName = [dic objectForKey:bankType];
    return [Utils getResult:dic text:bankType];
}

+ (NSString *)getQuitReasonCode:(NSString *)reason{
//    NSString *code;
    NSDictionary *dic = @{
                          @"价格":@"1001",
                          @"票面":@"1002",
                          @"模式":@"1003",
                          @"回款时间":@"1004",
                          @"票类":@"1005",
                          @"未出票":@"1006",
                          @"其他":@"1007"
                          };
//    code = dic[reason];
//    return code;
    
    return [Utils getResult:dic text:reason];
}

/**
 全部：不传；国债:1001；央票：1010；地方债：1002；金融债：1003；短融：1004；中票：1005；企业债：1006；公司债：1007；ABS：1011；NCD：1012；其他：1008和1009
 */
+ (NSString *)getBondProductListArrayStr:(NSArray *)array{
    NSString *codeStr;
    if (IsEmpty(array)) {
        codeStr = @"";
    }else{
        if ([array containsObject:@"全部"]) {
            codeStr = @"";
        }else{
            NSDictionary *dic = @{@"国债":@"1001",
                                  @"央票":@"1010",
                                  @"地方债":@"1002",
                                  @"金融债":@"1003",
                                  @"短融":@"1004",
                                  @"中票":@"1005",
                                  @"企业债":@"1006",
                                  @"公司债":@"1007",
                                  @"ABS":@"1011",
                                  @"NCD":@"1012",
                                  @"其他":@"1008,1009"};
            NSMutableArray *codeArray = [NSMutableArray arrayWithCapacity:1];
            for (NSString *str in array) {
                [codeArray addObject:[Utils getResult:dic text:str]];
            }
            codeStr = [codeArray componentsJoinedByString:@","];
            codeStr = [NSString stringWithFormat:@"[%@]",codeStr];
        }
    }
    return codeStr;
}

/**mainRatingList ”：[1]；对应规则如下：全部：不传；AAA+：1；AAA：2；AAA-:3；AA+：4；AA：5；AA-：6；A+：7；其他：8*/
+ (NSString *)getBondMainRatingListArrayStr:(NSArray *)array{
    NSString *codeStr;
    if (IsEmpty(array)) {
        codeStr = @"";
    }else{
        if ([array containsObject:@"全部"]) {
            codeStr = @"";
        }else{
            NSDictionary *dic = @{@"AAA+":@"1",
                                  @"AAA":@"2",
                                  @"AAA-":@"3",
                                  @"AA+":@"4",
                                  @"AA":@"5",
                                  @"AA-":@"6",
                                  @"A+":@"7",
                                  @"其他":@"8"};
            NSMutableArray *codeArray = [NSMutableArray arrayWithCapacity:1];
            for (NSString *str in array) {
                [codeArray addObject:[Utils getResult:dic text:str]];
            }
            codeStr = [codeArray componentsJoinedByString:@","];
            codeStr = [NSString stringWithFormat:@"[%@]",codeStr];
        }
    }
    return codeStr;
}
/**1M：1；3M：2；6M:3；9M：4； 1Y：5；3Y：6；5Y：7；7Y：8 10Y：9  >10Y：10*/
+ (NSString *)getBondPeriodListArrayStr:(NSArray *)array{
    
    NSString *codeStr;
    if (IsEmpty(array)) {
        codeStr = @"";
    }else{
        if ([array containsObject:@"全部"]) {
            codeStr = @"";
        }else{
            NSDictionary *dic = @{@"1M":@"1",
                                  @"3M":@"2",
                                  @"6M":@"3",
                                  @"9M":@"4",
                                  @"1Y":@"5",
                                  @"3Y":@"6",
                                  @"5Y":@"7",
                                  @"7Y":@"8",
                                  @"10Y":@"9",
                                  @">10Y":@"10"};
            NSMutableArray *codeArray = [NSMutableArray arrayWithCapacity:1];
            for (NSString *str in array) {
                [codeArray addObject:[Utils getResult:dic text:str]];
            }
            codeStr = [codeArray componentsJoinedByString:@","];
            codeStr = [NSString stringWithFormat:@"[%@]",codeStr];
        }
    }
    return codeStr;
}
@end
