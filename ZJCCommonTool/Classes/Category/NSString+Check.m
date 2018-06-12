//
//  NSString+Check.m
//  Shake
//
//  Created by liumingkui on 14-8-8.
//  Copyright (c) 2014年 ___PURANG___. All rights reserved.
//

#import "NSString+Check.h"
#import "UIFont+PFVCommon.h"
#import "Header.h"

@implementation NSString(Check)
//
//- (BOOL)checkPhoneNumInput
//{
//    NSString * MOBILE = @"^1(3[0-9]|5[0-35-9]|8[025-9])\\d{8}$";
//    NSString * CM = @"^1(34[0-8]|(3[5-9]|5[017-9]|8[278])\\d)\\d{7}$";
//    NSString * CU = @"^1(3[0-2]|5[256]|8[56])\\d{8}$";
//    NSString * CT = @"^1((33|53|8[09])[0-9]|349)\\d{7}$";
//    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
//    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
//    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
//    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
//    BOOL res1 = [regextestmobile evaluateWithObject:self];
//    BOOL res2 = [regextestcm evaluateWithObject:self];
//    BOOL res3 = [regextestcu evaluateWithObject:self];
//    BOOL res4 = [regextestct evaluateWithObject:self];
//    if (res1 || res2 || res3 || res4 )
//    {
//        return YES;
//    }
//    else
//    {
//        return NO;
//    }
//}

- (BOOL)checkPhoneNumInput{
    if (self.length != 11){
        return NO;
    }
    else{
        return YES;
    }
}

- (BOOL)checkEmailInput
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:self];
}


/**
 
 * 功能:获取指定范围的字符串
 
 * 参数:字符串的开始小标
 
 * 参数:字符串的结束下标
 
 */

- (NSString *)getStringWithRange:(NSString *)str Value1:(NSInteger)value1 Value2:(NSInteger )value2;
{
    return [str substringWithRange:NSMakeRange(value1,value2)];
}

/**
 * 功能:判断是否在地区码内
 * 参数:地区码
 **/

- (BOOL)areaCode:(NSString *)code
{
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setObject:@"北京" forKey:@"11"];
    [dic setObject:@"天津" forKey:@"12"];
    [dic setObject:@"河北" forKey:@"13"];
    [dic setObject:@"山西" forKey:@"14"];
    [dic setObject:@"内蒙古" forKey:@"15"];
    [dic setObject:@"辽宁" forKey:@"21"];
    [dic setObject:@"吉林" forKey:@"22"];
    [dic setObject:@"黑龙江" forKey:@"23"];
    [dic setObject:@"上海" forKey:@"31"];
    [dic setObject:@"江苏" forKey:@"32"];
    [dic setObject:@"浙江" forKey:@"33"];
    [dic setObject:@"安徽" forKey:@"34"];
    [dic setObject:@"福建" forKey:@"35"];
    [dic setObject:@"江西" forKey:@"36"];
    [dic setObject:@"山东" forKey:@"37"];
    [dic setObject:@"河南" forKey:@"41"];
    [dic setObject:@"湖北" forKey:@"42"];
    [dic setObject:@"湖南" forKey:@"43"];
    [dic setObject:@"广东" forKey:@"44"];
    [dic setObject:@"广西" forKey:@"45"];
    [dic setObject:@"海南" forKey:@"46"];
    [dic setObject:@"重庆" forKey:@"50"];
    [dic setObject:@"四川" forKey:@"51"];
    [dic setObject:@"贵州" forKey:@"52"];
    [dic setObject:@"云南" forKey:@"53"];
    [dic setObject:@"西藏" forKey:@"54"];
    [dic setObject:@"陕西" forKey:@"61"];
    [dic setObject:@"甘肃" forKey:@"62"];
    [dic setObject:@"青海" forKey:@"63"];
    [dic setObject:@"宁夏" forKey:@"64"];
    [dic setObject:@"新疆" forKey:@"65"];
    [dic setObject:@"台湾" forKey:@"71"];
    [dic setObject:@"香港" forKey:@"81"];
    [dic setObject:@"澳门" forKey:@"82"];
    [dic setObject:@"国外" forKey:@"91"];
    if ([dic objectForKey:code] == nil)
    {
        return NO;
    }
    return YES;
}

- (BOOL)checkIdentityCard
{
    //判断位数
    if ([self length] != 15 && [self length] != 18) {
        return NO;
    }
    NSString *carid = self;
    long lSumQT =0;
    //加权因子
    NSInteger R[] ={7, 9, 10, 5, 8, 4, 2, 1, 6, 3, 7, 9, 10, 5, 8, 4, 2 };
    //校验码
    unsigned char sChecker[11]={'1','0','X', '9', '8', '7', '6', '5', '4', '3', '2'};
    //将15位身份证号转换成18位
    NSMutableString *mString = [NSMutableString stringWithString:self];
    if ([self length] == 15)
    {
        [mString insertString:@"19" atIndex:6];
        long p = 0;
        const char *pid = [mString UTF8String];
        for (NSInteger i=0; i<=16; i++)
        {
            p += (pid[i]-48) * R[i];
        }
        NSInteger o = p%11;
        NSString *string_content = [NSString stringWithFormat:@"%c",sChecker[o]];
        [mString insertString:string_content atIndex:[mString length]];
        carid = mString;
    }
    //判断地区码
    NSString * sProvince = [carid substringToIndex:2];
    if (![self areaCode:sProvince])
    {
        return NO;
    }
    //判断年月日是否有效
    //年份
    NSInteger strYear = [[self getStringWithRange:carid Value1:6 Value2:4] intValue];
    //月份
    NSInteger strMonth = [[self getStringWithRange:carid Value1:10 Value2:2] intValue];
    //日
    NSInteger strDay = [[self getStringWithRange:carid Value1:12 Value2:2] intValue];
    NSTimeZone *localZone = [NSTimeZone localTimeZone];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
    [dateFormatter setTimeStyle:NSDateFormatterNoStyle];
    [dateFormatter setTimeZone:localZone];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *date=[dateFormatter dateFromString:[NSString stringWithFormat:@"%ld-%ld-%ld 12:01:01",(long)strYear,(long)strMonth,(long)strDay]];
    if (date == nil)
    {
        return NO;
    }
    const char *PaperId  = [carid UTF8String];
    //检验长度
    if( 18 != strlen(PaperId)) return -1;
    //校验数字
    for (NSInteger i=0; i<18; i++)
    {
        if ( !isdigit(PaperId[i]) && !(('X' == PaperId[i] || 'x' == PaperId[i]) && 17 == i) )
        {
            return NO;
        }
    }
    //验证最末的校验码
    for (NSInteger i=0; i<=16; i++)
    {
        lSumQT += (PaperId[i]-48) * R[i];
    }
    if (sChecker[lSumQT%11] != PaperId[17] )
    {
        return NO;
    }
    return YES;
}

- (BOOL) isBlankString {
    if (self == nil || self == NULL) {
        return YES;
    }
    if ([self isKindOfClass:[NSNull class]]) {
        return YES;
    }
    if ([[self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0) {
        return YES;
    }
    return NO;
}

+ (NSString *)checkEmptyFromThing:(id)thing{
    NSString *string = nil;
    if (IsEmpty(thing)) {
        string = @"--";
    }else{
        string = [NSString stringWithFormat:@"%@",thing];
    }
    return string;
}

- (NSString *)pr_checkEmpty{

    return [self pr_checkEmptyReplaceString:@""];
}
- (NSString *)pr_checkEmptyWithPlaceholder{
    return [self pr_checkEmptyReplaceString:@"--"];
}

- (NSString *)pr_checkEmptyReplaceString:(NSString *)replace{
    
    if (IsEmpty(self)) {
        return replace;
    }else{
        if (self == nil) {
            return replace;
        }
        return [NSString stringWithFormat:@"%@",self];
    }
}

+ (NSString *)checkEmptyNoneFromThing:(id)thing{
    NSString *string = nil;
    if (IsEmpty(thing)) {
        string = @"";
    }else{
        string = [NSString stringWithFormat:@"%@",thing];
    }
    return string;
}

+ (NSString *)checkEmptyZeroFromThing:(id)thing{
    NSString *string = nil;
    if (IsEmpty(thing)) {
        string = @"0";
    }else{
        string = [NSString stringWithFormat:@"%@",thing];
    }
    return string;
}

+ (NSString *)checkDateFromThing:(id)thing{
    if (IsEmpty(thing)) {
        return @"";
    }
    NSString *string = [NSString stringWithFormat:@"%@",thing];
    NSMutableArray *temp = [[NSMutableArray alloc]init];
    NSInteger count = (string.length+1)/2;
    for (int i = 0; i < count;i++) {
        NSString *sec = [string substringToIndex:2];
        [temp addObject:sec];
        string = [string substringFromIndex:2];
    }
    if (temp.count < 5) {
        return string;
    }
    return [NSString stringWithFormat:@"%@-%@ %@:%@",temp[1],temp[2],temp[3],temp[4]];
}

+ (NSString*)valueCombinedFromThing:(id)thing{
    NSString *string = nil;
    if (IsEmpty(thing)) {
        string = @"";
    }else{
        double value = 0;
        NSString *tempStr = [NSString stringWithFormat:@"%@",thing];
        NSArray *tempArr = [tempStr componentsSeparatedByString:@"+"];
        for (NSString *dou in tempArr) {
            value += [dou doubleValue];
        }
        string = [NSString stringWithFormat:@"%lf",value];
    }
    return string;
}

+ (NSString*)removeFloatAllZero:(NSString*)string{
    NSString *testNumber = string;
    NSString *outNumber = [NSString stringWithFormat:@"%@",@(testNumber.floatValue)];
    return outNumber;
}

+ (NSString*)removeSecondFloatAllZero:(NSString*)string{
    if (IsEmpty(string)) {
        return @"--";
    }else{
        NSString *newStr = [NSString stringWithFormat:@"%.2lf",[string doubleValue]];
        return [self removeFloatAllZero:newStr];
    }
}

+ (NSString*)addSpaceMarkWithDateStr:(NSString*)string{
    if (string.length != 8) return string;
    
    NSMutableString *mutStr = [[NSMutableString alloc]initWithString:string];
    [mutStr insertString:@"-" atIndex:4];
    [mutStr insertString:@"-" atIndex:7];
    return mutStr;
}

+ (NSString*)searchYearMonthDayString:(NSString*)string{
    if (IsEmpty(string)) {
        return @"--";
    }
    NSArray *temp = [string componentsSeparatedByString:@" "];
    return [temp firstObject];
}

+ (NSString*)searchHourMinSecString:(NSString*)string{
    if (IsEmpty(string)) {
        return @"--";
    }
    NSArray *temp = [string componentsSeparatedByString:@" "];
    return [temp lastObject];
}

+ (NSString *)lastCharFromString:(NSString*)string{
    if ((![string isKindOfClass:[NSString class]] && IsEmpty(string)) || string.length == 0) {
        return @"";
    }
    return [string substringFromIndex:string.length-1];
}

/* 拿到字符串第一位 */
+ (NSString *)firstCharFromString:(NSString *)string{
    if ((![string isKindOfClass:[NSString class]] && IsEmpty(string)) || string.length == 0) {
        return @"";
    }
    
    return [string substringToIndex:1];
}


- (NSString *)getCharsFromHead:(NSInteger)headIndex toFoot:(NSInteger )footIndex{
    if (IsEmpty(self)) {
        return @"";
    }
    if (![self isKindOfClass:[NSString class]] || headIndex >= footIndex) {
        return @"";
    }
    NSRange range = NSMakeRange(headIndex, footIndex-headIndex);
    return [self substringWithRange:range];
}

- (NSString *)lastChar{
    return [NSString lastCharFromString:self];
}

- (NSString *)firstChar{
    return [NSString firstCharFromString:self];
}
/**
 * 手机号码:
 * 13[0-9], 14[5,7], 15[0, 1, 2, 3, 5, 6, 7, 8, 9], 17[6, 7, 8], 18[0-9], 170[0-9]
 * 移动号段: 134,135,136,137,138,139,150,151,152,157,158,159,182,183,184,187,188,147,178,1705
 * 联通号段: 130,131,132,155,156,185,186,145,176,1709
 * 电信号段: 133,153,180,181,189,177
 * 虚拟运营商: 1700
 */
+ (BOOL)isMobilePhone:(NSString *)phoneNum{
    NSString *MP = @"^1(3[0-9]|4[57]|5[0-35-9]|8[0-9]|7[06-8])\\d{8}$";
    NSPredicate *pre = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MP];
    return [pre evaluateWithObject:phoneNum];
}

+ (BOOL)isTelephoneNo:(NSString *)phoneNum{
    NSString *TEL = @"^(\\d{3,4}-)\\d{7,8}$";
    NSPredicate *pre = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", TEL];
    return [pre evaluateWithObject:phoneNum];
}

+ (BOOL)isChinaMobile:(NSString *)phoneNum{
    NSString *CM = @"(^1(3[4-9]|4[7]|5[0-27-9]|7[8]|8[2-478])\\d{8}$)|(^1705\\d{7}$)";
    NSPredicate *pre = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    return [pre evaluateWithObject:phoneNum];
}

+ (BOOL)isChinaUnicom:(NSString *)phoneNum{
    NSString *CU = @"(^1(3[0-2]|4[5]|5[56]|7[6]|8[56])\\d{8}$)|(^1709\\d{7}$)";
    NSPredicate *pre = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    return [pre evaluateWithObject:phoneNum];
}

+ (BOOL)isChinaTelecom:(NSString *)phoneNum{
    NSString *CT = @"(^1(33|53|77|8[019])\\d{8}$)|(^1700\\d{7}$)";
    NSPredicate *pre = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    return [pre evaluateWithObject:phoneNum];
}

+ (NSString *)getMobilePhoneServiceProvider:(NSString *)phoneNum{
    return [self isChinaMobile:phoneNum] ? @"中国移动" : ([self isChinaUnicom:phoneNum] ? @"中国联通" : ([self isChinaTelecom:phoneNum] ? @"中国电信" : @"未知"));
}

+ (BOOL)isPassword:(NSString *)password{
    NSString *pattern = @"^(?![0-9]+$)(?![a-zA-Z]+$)[a-zA-Z0-9]{6,18}";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",pattern];
    return [pred evaluateWithObject:password];
}

+ (BOOL)isUserName:(NSString *)userName{
    NSString *pattern = @"^[a-zA-Z\u4E00-\u9FA5]{1,20}";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",pattern];
    return [pred evaluateWithObject:userName];
}

+ (BOOL)isUserIdCard:(NSString *)idCard{
    NSString *pattern = @"(^[0-9]{15}$)|([0-9]{17}([0-9]|X)$)";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",pattern];
    return [pred evaluateWithObject:idCard];
}

+ (BOOL)isEmail:(NSString *)email{
    NSString *EM = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate* pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",EM];
    return [pred evaluateWithObject:email];
}

+ (BOOL)isFloatingPointNumbers:(NSString *)numbers{
    NSString *EM = @"^[0-9]+(\\.[0-9]{1,2})?$";
    NSPredicate* pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",EM];
    return [pred evaluateWithObject:numbers];
}


/** 银行卡号有效性问题Luhn算法
 *  现行 16 位银联卡现行卡号开头 6 位是 622126～622925 之间的，7 到 15 位是银行自定义的，
 *  可能是发卡分行，发卡网点，发卡序号，第 16 位是校验码。
 *  16 位卡号校验位采用 Luhm 校验方法计算：
 *  1，将未带校验位的 15 位卡号从右依次编号 1 到 15，位于奇数位号上的数字乘以 2
 *  2，将奇位乘积的个十位全部相加，再加上所有偶数位上的数字
 *  3，将加法和加上校验位能被 10 整除。
 */
+ (BOOL)isBankCardNumber:(NSString *)bankNumber{
    NSString * lastNum = [[bankNumber substringFromIndex:(bankNumber.length-1)] copy];//取出最后一位
    NSString * forwardNum = [[bankNumber substringToIndex:(bankNumber.length -1)] copy];//前15或18位
    
    NSMutableArray * forwardArr = [[NSMutableArray alloc] initWithCapacity:0];
    for (int i=0; i<forwardNum.length; i++) {
        NSString * subStr = [forwardNum substringWithRange:NSMakeRange(i, 1)];
        [forwardArr addObject:subStr];
    }
    NSMutableArray * forwardDescArr = [[NSMutableArray alloc] initWithCapacity:0];
    for (int i = (int)(forwardArr.count-1); i> -1; i--) {//前15位或者前18位倒序存进数组
        [forwardDescArr addObject:forwardArr[i]];
    }
    NSMutableArray * arrOddNum = [[NSMutableArray alloc] initWithCapacity:0];//奇数位*2的积 < 9
    NSMutableArray * arrOddNum2 = [[NSMutableArray alloc] initWithCapacity:0];//奇数位*2的积 > 9
    NSMutableArray * arrEvenNum = [[NSMutableArray alloc] initWithCapacity:0];//偶数位数组
    for (int i=0; i< forwardDescArr.count; i++) {
        NSInteger num = [forwardDescArr[i] intValue];
        if (i%2) {//偶数位
            [arrEvenNum addObject:[NSNumber numberWithInteger:num]];
        }else{//奇数位
            if (num * 2 < 9) {
                [arrOddNum addObject:[NSNumber numberWithInteger:num * 2]];
            }else{
                NSInteger decadeNum = (num * 2) / 10;
                NSInteger unitNum = (num * 2) % 10;
                [arrOddNum2 addObject:[NSNumber numberWithInteger:unitNum]];
                [arrOddNum2 addObject:[NSNumber numberWithInteger:decadeNum]];
            }
        }
    }
    __block  NSInteger sumOddNumTotal = 0;
    [arrOddNum enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        sumOddNumTotal += [obj integerValue];
    }];
    __block NSInteger sumOddNum2Total = 0;
    [arrOddNum2 enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        sumOddNum2Total += [obj integerValue];
    }];
    __block NSInteger sumEvenNumTotal = 0 ;
    [arrEvenNum enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        sumEvenNumTotal += [obj integerValue];
    }];
    NSInteger lastNumber = [lastNum integerValue];
    NSInteger luhmTotal = lastNumber + sumEvenNumTotal + sumOddNum2Total + sumOddNumTotal;
    return (luhmTotal%10 ==0)?YES:NO;
}

+ (BOOL)isFloatPointNumbers:(NSString *)numbers{
    NSString *EM = @"^[0-9]+(\\.[0-9]{1,2})?$";
    NSPredicate* pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",EM];
    return [pred evaluateWithObject:numbers];
}

+ (BOOL)isFloatPointNumbers:(NSString *)numbers decimal:(NSUInteger)decimal{
    NSString *EM = [NSString stringWithFormat:@"^[0-9]+(\\.[0-9]{1,%zd})?$",decimal];
    NSPredicate* pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",EM];
    return [pred evaluateWithObject:numbers];
}

- (NSMutableDictionary *)getURLParameters {
    
    // 查找参数
    NSRange range = [self rangeOfString:@"?"];
    if (range.location == NSNotFound) {
        return nil;
    }
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    // 截取参数
    NSString *parametersString = [self substringFromIndex:range.location + 1];
    
    // 判断参数是单个参数还是多个参数
    if ([parametersString containsString:@"&"]) {
        
        // 多个参数，分割参数
        NSArray *urlComponents = [parametersString componentsSeparatedByString:@"&"];
        
        for (NSString *keyValuePair in urlComponents) {
            // 生成Key/Value
            NSArray *pairComponents = [keyValuePair componentsSeparatedByString:@"="];
            NSString *key = [pairComponents.firstObject stringByRemovingPercentEncoding];
            NSString *value = [pairComponents.lastObject stringByRemovingPercentEncoding];
            
            // Key不能为nil
            if (key == nil || value == nil) {
                continue;
            }
            
            id existValue = [params valueForKey:key];
            
            if (existValue != nil) {
                
                // 已存在的值，生成数组
                if ([existValue isKindOfClass:[NSArray class]]) {
                    // 已存在的值生成数组
                    NSMutableArray *items = [NSMutableArray arrayWithArray:existValue];
                    [items addObject:value];
                    
                    [params setValue:items forKey:key];
                } else {
                    
                    // 非数组
                    [params setValue:@[existValue, value] forKey:key];
                }
                
            } else {
                
                // 设置值
                [params setValue:value forKey:key];
            }
        }
    } else {
        // 单个参数
        
        // 生成Key/Value
        NSArray *pairComponents = [parametersString componentsSeparatedByString:@"="];
        
        // 只有一个参数，没有值
        if (pairComponents.count == 1) {
            return nil;
        }
        
        // 分隔值
        NSString *key = [pairComponents.firstObject stringByRemovingPercentEncoding];
        NSString *value = [pairComponents.lastObject stringByRemovingPercentEncoding];
        
        // Key不能为nil
        if (key == nil || value == nil) {
            return nil;
        }
        
        // 设置值
        [params setValue:value forKey:key];
    }
    
    return params;
}

+ (NSMutableAttributedString *)getAttributeStringWithStringArray:(NSArray *)stringArray colorArray:(NSArray <UIColor *>*)colorArray fontArray:(NSArray *)fontArray{
    
    UIColor *defultColor = [UIColor whiteColor];
    UIFont  *defultFont  = [UIFont systemFontOfSize:14];
    CGFloat fontSize = 14;
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] init];
    for (int i = 0;i < stringArray.count;i++) {
        
        if (colorArray.count > i) {
            defultColor = colorArray[i];
        }
        if (fontArray.count > i) {
            if ([fontArray[i] isKindOfClass:[UIFont class]]) {
                defultFont = fontArray[i];
            }else if ([fontArray[i] floatValue] > 0){
                fontSize = [fontArray[i] floatValue]-1;
                defultFont = [UIFont systemFontOfSize:[fontArray[i] floatValue]];
            }
        }
        
        if ([stringArray[i] isKindOfClass:[NSString class]]) {
            NSString *string = stringArray[i];
            NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc] initWithString:string];
            [attrString addAttributes:@{
            NSForegroundColorAttributeName: defultColor,
            NSFontAttributeName: defultFont
                                        } range:NSMakeRange(0, string.length)];
            [attributedString appendAttributedString:attrString];
        }else if ([stringArray[i] isKindOfClass:[UIImage class]]){
            NSTextAttachment *textAttachment = [[NSTextAttachment alloc]init];
            textAttachment.image = stringArray[i];
            textAttachment.bounds = CGRectMake(0, 0, fontSize, fontSize);
            NSAttributedString * imageStr = [NSAttributedString attributedStringWithAttachment:textAttachment];
            [attributedString appendAttributedString:imageStr];
        }
        
    }
    return attributedString;
}
- (NSAttributedString *)getAttributedStringFontSize1:(CGFloat)fontSize fontSize2:(CGFloat)fontSize2 fontSize3:(CGFloat)fontSize3 Color:(UIColor *)Color1 Color2:(UIColor *)Color2 Color3:(UIColor *)Color3{
    
    NSMutableAttributedString * attri = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@",self]];
    
    NSString *pureNumbers = [[self componentsSeparatedByCharactersInSet:[[NSCharacterSet characterSetWithCharactersInString:@"0123456789.-"] invertedSet]] componentsJoinedByString:@""];
    
    [attri addAttribute:NSForegroundColorAttributeName value:Color3 range:NSMakeRange(0, self.length)];
    [attri addAttribute:NSFontAttributeName value:[UIFont fontWithFontName:FontNamePingFangRegular size:fontSize3] range:NSMakeRange(0, self.length)];
    
    ///数字的range
    NSRange pureNumbersRange = [self rangeOfString:pureNumbers];
    if (pureNumbersRange.location != NSNotFound) {
        [attri addAttribute:NSForegroundColorAttributeName value:Color1 range:pureNumbersRange];
        [attri addAttribute:NSFontAttributeName value:[UIFont fontWithFontName:FontNamePingFangRegular size:fontSize] range:pureNumbersRange];
        ///小数点位置范围
        NSRange range1 = [pureNumbers rangeOfString:@"."];
        if (range1.location != NSNotFound) {
            ///小数点后面的数字位置范围
            NSRange range2 = NSMakeRange(pureNumbersRange.location+range1.location, pureNumbersRange.length- range1.location);
            [attri addAttribute:NSForegroundColorAttributeName value:Color2 range:range2];
            [attri addAttribute:NSFontAttributeName value:[UIFont fontWithFontName:FontNamePingFangRegular size:fontSize2] range:range2];
        }
    }
    
    return attri;
}



- (NSAttributedString *)getAttributedString:(NSString *)str1 FontSize1:(CGFloat)fontSize fontSize1:(CGFloat)fontSize1  Color:(UIColor *)Color Color1:(UIColor *)Color1 {
    
    NSMutableAttributedString * attri = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@",self]];
    
    [attri addAttribute:NSForegroundColorAttributeName value:Color range:NSMakeRange(0, self.length)];
    [attri addAttribute:NSFontAttributeName value:[UIFont fontWithFontName:FontNamePingFangRegular size:fontSize] range:NSMakeRange(0, self.length)];
    
    NSRange range = [self rangeOfString:str1];
    if (range.location != NSNotFound) {
        [attri addAttribute:NSForegroundColorAttributeName value:Color1 range:range];
        [attri addAttribute:NSFontAttributeName value:[UIFont fontWithFontName:FontNamePingFangRegular size:fontSize1] range:range];
    }
    
    return attri;
}
@end
