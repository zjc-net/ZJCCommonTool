//
//  Utils.m
//  PurangFinanceVillage
//
//  Created by purang\daichen on 2017/4/11.
//  Copyright © 2017年 ___PURANG___. All rights reserved.
//

#import "Utils.h"
#import <CommonCrypto/CommonDigest.h>
#include <sys/param.h>
#include <sys/mount.h>
#import "Header.h"
#import "UIFont+PFVCommon.h"
#import "UIColor+HexCode.h"
#import "SSKeychain.h"

@implementation Utils

//校验身份证格式是否正确
+ (BOOL)validateIDCardNumber:(NSString *)value {
    value = [value stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSInteger length = 0;
    if (!value) {
        return NO;
    }else {
        length = value.length;
        
        if (length !=15 && length !=18) {
            return NO;
        }
    }
    // 省份代码
    NSArray *areasArray =@[@"11",@"12", @"13",@"14", @"15",@"21", @"22",@"23", @"31",@"32", @"33",@"34", @"35",@"36", @"37",@"41", @"42",@"43", @"44",@"45", @"46",@"50", @"51",@"52", @"53",@"54", @"61",@"62", @"63",@"64", @"65",@"71", @"81",@"82", @"91"];
    NSString *valueStart2 = [value substringToIndex:2];
    BOOL areaFlag = NO;
    for (NSString *areaCode in areasArray) {
        if ([areaCode isEqualToString:valueStart2]) {
            areaFlag =YES;
            break;
        }
    }
    if (!areaFlag) {
        return false;
    }
    NSRegularExpression *regularExpression;
    NSUInteger numberofMatch;
    
    int year =0;
    switch (length) {
        case 15:
            year = [value substringWithRange:NSMakeRange(6,2)].intValue +1900;
            if (year %4 ==0 || (year %100 ==0 && year %4 ==0)) {
                regularExpression = [[NSRegularExpression alloc]initWithPattern:@"^[1-9][0-9]{5}[0-9]{2}((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|[1-2][0-9]))[0-9]{3}$"options:NSRegularExpressionCaseInsensitive error:nil];//测试出生日期的合法性
            }else {
                regularExpression = [[NSRegularExpression alloc]initWithPattern:@"^[1-9][0-9]{5}[0-9]{2}((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|1[0-9]|2[0-8]))[0-9]{3}$" options:NSRegularExpressionCaseInsensitive error:nil];//测试出生日期的合法性
            }
            numberofMatch = [regularExpression numberOfMatchesInString:value options:NSMatchingReportProgress range:NSMakeRange(0, value.length)];
            //        [regularExpression release];
            if(numberofMatch >0) {
                return YES;
            }else {
                return NO;
            }
        case 18:year = [value substringWithRange:NSMakeRange(6,4)].intValue;
            if (year %4 ==0 || (year %100 ==0 && year %4 ==0)) {
                regularExpression = [[NSRegularExpression alloc]initWithPattern:@"^[1-9][0-9]{5}19[0-9]{2}((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|[1-2][0-9]))[0-9]{3}[0-9Xx]$" options:NSRegularExpressionCaseInsensitive error:nil];//测试出生日期的合法性
            }else {
                regularExpression = [[NSRegularExpression alloc]initWithPattern:@"^[1-9][0-9]{5}19[0-9]{2}((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|1[0-9]|2[0-8]))[0-9]{3}[0-9Xx]$"options:NSRegularExpressionCaseInsensitive error:nil];//测试出生日期的合法性
            }
            numberofMatch = [regularExpression numberOfMatchesInString:value options:NSMatchingReportProgress range:NSMakeRange(0, value.length)];
            
            //            [regularExpressionrelease];
            if(numberofMatch >0) {
                int S = ([value substringWithRange:NSMakeRange(0,1)].intValue + [value substringWithRange:NSMakeRange(10,1)].intValue) *7 + ([value substringWithRange:NSMakeRange(1,1)].intValue + [value substringWithRange:NSMakeRange(11,1)].intValue) *9 + ([value substringWithRange:NSMakeRange(2,1)].intValue + [value substringWithRange:NSMakeRange(12,1)].intValue) *10 + ([value substringWithRange:NSMakeRange(3,1)].intValue + [value substringWithRange:NSMakeRange(13,1)].intValue) *5 + ([value substringWithRange:NSMakeRange(4,1)].intValue + [value substringWithRange:NSMakeRange(14,1)].intValue) *8 + ([value substringWithRange:NSMakeRange(5,1)].intValue + [value substringWithRange:NSMakeRange(15,1)].intValue) *4 + ([value substringWithRange:NSMakeRange(6,1)].intValue + [value substringWithRange:NSMakeRange(16,1)].intValue) *2 + [value substringWithRange:NSMakeRange(7,1)].intValue *1 + [value substringWithRange:NSMakeRange(8,1)].intValue *6 + [value substringWithRange:NSMakeRange(9,1)].intValue *3;
                int Y = S %11;
                NSString *M =@"F";
                NSString *JYM =@"10X98765432";
                M = [JYM substringWithRange:NSMakeRange(Y,1)];// 判断校验位
                if ([M isEqualToString:[value substringWithRange:NSMakeRange(17,1)]]) {
                    return YES;// 检测ID的校验位
                }else {
                    return NO;
                }
            }else {
                return NO;
            }
        default:
            return false;
    }
}

//根据身份证号获取性别
+(NSString *)getIdentityCardSex:(NSString *)numberStr{
    int sexInt=[[numberStr substringWithRange:NSMakeRange(16,1)] intValue];
    
    if(sexInt%2!=0){
        return @"1";
    }
    else{
        return @"0";
    }
}

//根据身份证号获取年龄
+(NSString *)getIdentityCardAge:(NSString *)numberStr{
    
    NSDateFormatter *formatterTow = [[NSDateFormatter alloc]init];
    [formatterTow setDateFormat:@"yyyy-MM-dd"];
    NSDate *bsyDate = [formatterTow dateFromString:[self birthdayStrFromIdentityCard:numberStr]];
    NSTimeInterval dateDiff = [bsyDate timeIntervalSinceNow];
    int age = trunc(dateDiff/(60*60*24))/365;
    return [NSString stringWithFormat:@"%d",-age];
}

//根据身份证号获取生日
+(NSString *)birthdayStrFromIdentityCard:(NSString *)numberStr{
    NSMutableString *result = [NSMutableString stringWithCapacity:0];
    NSString *year = nil;
    NSString *month = nil;
    
    BOOL isAllNumber = YES;
    
    NSString *day = nil;
    if([numberStr length]<14)
        return result;
    
    //**截取前14位
    NSString *fontNumer = [numberStr substringWithRange:NSMakeRange(0, 14)];
    
    //**检测前14位否全都是数字;
    const char *str = [fontNumer UTF8String];
    const char *p = str;
    while (*p!='\0') {
        if(!(*p>='0'&&*p<='9'))
            isAllNumber = NO;
        p++;
    }
    if(!isAllNumber)
        return result;
    
    year = [numberStr substringWithRange:NSMakeRange(6, 4)];
    month = [numberStr substringWithRange:NSMakeRange(10, 2)];
    day = [numberStr substringWithRange:NSMakeRange(12,2)];
    
    [result appendString:year];
    [result appendString:@"-"];
    [result appendString:month];
    [result appendString:@"-"];
    [result appendString:day];
    return result;
}

//校验手机格式是否正确
+ (BOOL)valiMobile:(NSString *)mobile{
    if (mobile.length < 11)
    {
        return NO;
    }else{
        /**
         * 移动号段正则表达式
         */
        NSString *CM_NUM = @"^((13[4-9])|(147)|(15[0-2,7-9])|(178)|(18[2-4,7-8]))\\d{8}|(1705)\\d{7}$";
        /**
         * 联通号段正则表达式
         */
        NSString *CU_NUM = @"^((13[0-2])|(145)|(15[5-6])|(176)|(18[5,6]))\\d{8}|(1709)\\d{7}$";
        /**
         * 电信号段正则表达式
         */
        NSString *CT_NUM = @"^((133)|(153)|(177)|(18[0,1,9]))\\d{8}$";
        NSPredicate *pred1 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM_NUM];
        BOOL isMatch1 = [pred1 evaluateWithObject:mobile];
        NSPredicate *pred2 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU_NUM];
        BOOL isMatch2 = [pred2 evaluateWithObject:mobile];
        NSPredicate *pred3 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT_NUM];
        BOOL isMatch3 = [pred3 evaluateWithObject:mobile];
        
        if (isMatch1 || isMatch2 || isMatch3) {
            return YES;
        }else{
            return NO;
        }
    }
}

//校验输入的是否是电话
+ (BOOL)checkPhoneNumInput:(NSString *)phoneNum{
    if (IsEmpty(phoneNum)) {
        return NO;
    }
    if (phoneNum.length != 11){
        return NO;
    }
    else{
        return YES;
    }
}

//校验邮箱格式是否正确
+ (BOOL)checkEmailInput:(NSString *)email{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}

/**
 * 功能:获取指定范围的字符串
 * 参数:字符串的开始下标
 * 参数:字符串的截取长度
 */
+ (NSString *)getStringWithRange:(NSString *)str startValue:(NSInteger)startValue length:(NSInteger )length{
    return [str substringWithRange:NSMakeRange(startValue,length)];
    
}

/**
 * 功能:判断是否在地区码内
 * 参数:地区码
 **/
+ (BOOL)areaCode:(NSString *)code{
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

+ (BOOL)checkIdentityCard:(NSString *)IDCard
{
    //判断位数
    if ([IDCard length] != 15 && [IDCard length] != 18) {
        return NO;
    }
    NSString *carid = IDCard;
    long lSumQT =0;
    //加权因子
    NSInteger R[] ={7, 9, 10, 5, 8, 4, 2, 1, 6, 3, 7, 9, 10, 5, 8, 4, 2 };
    //校验码
    unsigned char sChecker[11]={'1','0','X', '9', '8', '7', '6', '5', '4', '3', '2'};
    //将15位身份证号转换成18位
    NSMutableString *mString = [NSMutableString stringWithString:IDCard];
    if ([IDCard length] == 15)
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
    if (![self areaCode:sProvince]){
        return NO;
    }
    //判断年月日是否有效
    //年份
    NSInteger strYear = [[self getStringWithRange:carid startValue:6 length:4]intValue];
    //月份
    NSInteger strMonth = [[self getStringWithRange:carid startValue:10 length:2] intValue];
    //日
    NSInteger strDay = [[self getStringWithRange:carid startValue:12 length:2] intValue];
    NSTimeZone *localZone = [NSTimeZone localTimeZone];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
    [dateFormatter setTimeStyle:NSDateFormatterNoStyle];
    [dateFormatter setTimeZone:localZone];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *date=[dateFormatter dateFromString:[NSString stringWithFormat:@"%ld-%ld-%ld 12:01:01",(long)strYear,(long)strMonth,(long)strDay]];
    if (date == nil){
        return NO;
    }
    const char *PaperId  = [carid UTF8String];
    //检验长度
    if( 18 != strlen(PaperId)) return -1;
    //校验数字
    for (NSInteger i=0; i<18; i++){
        if ( !isdigit(PaperId[i]) && !(('X' == PaperId[i] || 'x' == PaperId[i]) && 17 == i) ){
            return NO;
        }
    }
    //验证最末的校验码
    for (NSInteger i=0; i<=16; i++){
        lSumQT += (PaperId[i]-48) * R[i];
    }
    if (sChecker[lSumQT%11] != PaperId[17] ){
        return NO;
    }
    return YES;
}

+ (BOOL) isBlankString:(NSString *)string {
    if (string == nil || string == NULL) {
        return YES;
    }
    if ([string isKindOfClass:[NSNull class]]) {
        return YES;
    }
    if ([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0) {
        return YES;
    }
    return NO;
}

+ (NSString*)changeToCurrencyString:(NSString *)string{
    NSNumberFormatter *formatter= [[NSNumberFormatter alloc]init];
    formatter.numberStyle = NSNumberFormatterDecimalStyle;
    NSNumber* number = [formatter numberFromString:string];
    if (number) {
        NSString* newString = [formatter stringFromNumber:number];
        return newString;
    }
    return string;
}

//将字符串md5加密处理
+ (NSString *)md5:(NSString *)string{
    const char *cStr = [string UTF8String];//转换成utf-8
    unsigned char result[16];//开辟一个16字节（128位：md5加密出来就是128位/bit）的空间（一个字节=8字位=8个二进制数）
    CC_MD5( cStr, (int)strlen(cStr), result);
    /*
     extern unsigned char *CC_MD5(const void *data, CC_LONG len, unsigned char *md)官方封装好的加密方法
     把cStr字符串转换成了32位的16进制数列（这个过程不可逆转） 存储到了result这个空间中
     */
    return [NSString stringWithFormat:
            @"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ];
    /*
     x表示十六进制，%02X  意思是不足两位将用0补齐，如果多余两位则不影响
     NSLog("%02X", 0x888);  //888
     NSLog("%02X", 0x4); //04
     */
}

//将json字符串转换成字典
+ (NSDictionary *)json_StringToDictionary:(NSString *)jsonString {
    NSError *error;
    NSData *objectData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:objectData options:NSJSONReadingMutableContainers error:&error];
    return (!json ? nil : json);
}

//转换颜色值为RGB
+ (UIColor *)colorFromHexCode:(NSString *)hexString
{
    NSString *cleanString = [hexString stringByReplacingOccurrencesOfString:@"#" withString:@""];
    if([cleanString length] == 3)
    {
        cleanString = [NSString stringWithFormat:@"%@%@%@%@%@%@",
                       [cleanString substringWithRange:NSMakeRange(0, 1)],[cleanString substringWithRange:NSMakeRange(0, 1)],
                       [cleanString substringWithRange:NSMakeRange(1, 1)],[cleanString substringWithRange:NSMakeRange(1, 1)],
                       [cleanString substringWithRange:NSMakeRange(2, 1)],[cleanString substringWithRange:NSMakeRange(2, 1)]];
    }
    
    if([cleanString length] == 6)
    {
        cleanString = [cleanString stringByAppendingString:@"ff"];
    }
    
    unsigned int baseValue;
    [[NSScanner scannerWithString:cleanString] scanHexInt:&baseValue];
    
    CGFloat red = ((baseValue >> 24) & 0xFF)/255.0f;
    CGFloat green = ((baseValue >> 16) & 0xFF)/255.0f;
    CGFloat blue = ((baseValue >> 8) & 0xFF)/255.0f;
    CGFloat alpha = ((baseValue >> 0) & 0xFF)/255.0f;
    
    return [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
}

//获取设备iOS系统版本
+ (NSString *)getDeviceVersion{
    return [[UIDevice currentDevice] systemVersion];
}

//获取设备号UUID
+ (NSString *)getDeviceID{
    return [[UIDevice currentDevice].identifierForVendor UUIDString];
}

//获取app版本号
+ (NSString *)getClientVersion{
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
}
//颜色转换图片
+ (UIImage *)createImageWithColor:(UIColor *)color
{
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}

+ (BOOL)image:(UIImage *)image isEqualToAnotherImage:(UIImage *)anotherImage{
    NSData *data = UIImagePNGRepresentation(image);
    NSData *data1 = UIImagePNGRepresentation(anotherImage);
    if ([data isEqual:data1]) {
        return YES;
    }
    return NO;
}

#pragma mark ------ 时间处理

+(NSDate *)addMonthDate:(NSDate *)now withMonths:(NSInteger)months {
    NSDateComponents *monthBeforeDateComponents = [[NSDateComponents alloc] init];
    monthBeforeDateComponents.month = months;
    NSDate *rsDate = [[NSCalendar currentCalendar]dateByAddingComponents:monthBeforeDateComponents toDate:now options:0];
    return rsDate;
}


+(NSDate *)addDayDate:(NSDate *)now withDays:(NSInteger)days {
    NSDateComponents *dayBeforeDateComponents = [[NSDateComponents alloc] init];
    dayBeforeDateComponents.day = days;
    NSDate *rsDate = [[NSCalendar currentCalendar]dateByAddingComponents:dayBeforeDateComponents toDate:now options:0];
    return rsDate;
}

+(NSString *)getCurrentyear {
    NSDate *date = [NSDate date];
    NSTimeZone *zone = [NSTimeZone timeZoneForSecondsFromGMT:8 * 3600];//[NSTimeZone systemTimeZone];
    NSInteger interval = [zone secondsFromGMTForDate: date];
    NSDate *localDate = [date  dateByAddingTimeInterval: interval];
    NSDateFormatter *dateFormatter =[[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"YYYY"];
    NSString *dateString = [dateFormatter stringFromDate:localDate];
    return dateString;
}

+(NSString *)getCurrentMonth {
    NSDate *date = [NSDate date];
    NSTimeZone *zone = [NSTimeZone timeZoneForSecondsFromGMT:8 * 3600];//[NSTimeZone systemTimeZone];
    NSInteger interval = [zone secondsFromGMTForDate: date];
    NSDate *localDate = [date  dateByAddingTimeInterval: interval];
    NSDateFormatter *dateFormatter =[[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"MM"];
    NSString *dateString = [dateFormatter stringFromDate:localDate];
    return dateString;
}

+(NSString *)getCurrentDateString {
    NSDate *now = [NSDate date];//根据当前系统的时区产生当前的时间，绝对时间，所以同为中午12点，不同的时区，这个时间是不同的。
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    df.timeZone = [NSTimeZone timeZoneForSecondsFromGMT:8 * 3600];//[NSTimeZone systemTimeZone];//系统所在时区
    df.dateFormat = @"yyyyMMdd";
    NSString *systemTimeZoneStr =  [df stringFromDate:now];
    return systemTimeZoneStr;
}

+ (NSDate *)getNowDateFromatAnDate:(NSDate *)anyDate
{
    //设置源日期时区
    NSTimeZone* sourceTimeZone = [NSTimeZone timeZoneWithAbbreviation:@"UTC"];//或GMT
    //设置转换后的目标日期时区
    NSTimeZone* destinationTimeZone = [NSTimeZone localTimeZone];
    //得到源日期与世界标准时间的偏移量
    NSInteger sourceGMTOffset = [sourceTimeZone secondsFromGMTForDate:anyDate];
    //目标日期与本地时区的偏移量
    NSInteger destinationGMTOffset = [destinationTimeZone secondsFromGMTForDate:anyDate];
    //得到时间偏移量的差值
    NSTimeInterval interval = destinationGMTOffset - sourceGMTOffset;
    //转为现在时间
    NSDate* destinationDateNow = [[NSDate alloc] initWithTimeInterval:interval sinceDate:anyDate];
    return destinationDateNow;
}

+(NSString *)getCurrentDateStringWithDateFormat:(NSString *)format {
    NSDate *now = [NSDate date];//根据当前系统的时区产生当前的时间，绝对时间，所以同为中午12点，不同的时区，这个时间是不同的。
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    df.timeZone = [NSTimeZone timeZoneForSecondsFromGMT:8 * 3600];//[NSTimeZone systemTimeZone];//系统所在时区
    df.dateFormat = format;
    NSString *systemTimeZoneStr =  [df stringFromDate:now];
    return systemTimeZoneStr;
}

+(NSString *)formatDateString :(NSDate*)date{
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    df.timeZone = [NSTimeZone timeZoneForSecondsFromGMT:8 * 3600];//[NSTimeZone timeZoneWithAbbreviation:@"UTC"];
    df.dateFormat = @"yyyy-MM-dd";
    NSString *systemTimeZoneStr =  [df stringFromDate:date];
    return systemTimeZoneStr;
}

+(NSString *)strformatDateString :(NSDate*)date dateFormat:(NSString *)dateFormat{
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    df.timeZone = [NSTimeZone timeZoneForSecondsFromGMT:8 * 3600];//[NSTimeZone systemTimeZone];//系统所在时区
    df.dateFormat = dateFormat;
    NSString *systemTimeZoneStr =  [df stringFromDate:date];
    return systemTimeZoneStr;
}

+(NSDate *)dateformatDateString :(NSString*)dateStr dateFormat:(NSString *)dateFormat{
    
    dateStr = [dateStr stringByReplacingOccurrencesOfString:@":" withString:@""];
    dateStr = [dateStr stringByReplacingOccurrencesOfString:@"/" withString:@""];
    dateStr = [dateStr stringByReplacingOccurrencesOfString:@"-" withString:@""];
    
    dateFormat = [dateFormat stringByReplacingOccurrencesOfString:@":" withString:@""];
    dateFormat = [dateFormat stringByReplacingOccurrencesOfString:@"/" withString:@""];
    dateFormat = [dateFormat stringByReplacingOccurrencesOfString:@"-" withString:@""];
    NSDateFormatter* dateFormater = [[NSDateFormatter alloc] init];
    [dateFormater setDateFormat:dateFormat];
    [dateFormater setTimeZone:[NSTimeZone timeZoneWithName:@"Asia/Shanghai"]];
    NSDate *date =[dateFormater dateFromString:dateStr];
    return date;
}

+(NSString*)removeFloatAllZero:(NSString*)string{
    NSString * s = nil;
    NSInteger offset = string.length - 1;
    while (offset){
        if ([string containsString:@"."]) {
            s = [string substringWithRange:NSMakeRange(offset, 1)];
            if ([s isEqualToString:@"0"] || [s isEqualToString:@"."]){
                offset--;
                string = [string substringToIndex:offset+1];
            } else{
                break;
            }
        }else{
            break;
        }
    }
    NSString * outNumber = [string substringToIndex:offset+1];
    if ([outNumber isEqualToString:@"0"]) {
        return @"";
    }
    return outNumber;
}

+ (NSInteger) calcDaysFromBegin:(NSDate *)beginDate end:(NSDate *)endDate{
    //创建日期格式化对象
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    //取两个日期对象的时间间隔：
    //这里的NSTimeInterval 并不是对象，是基本型，其实是double类型，是由c定义的:typedef double NSTimeInterval;
    NSTimeInterval time=[endDate timeIntervalSinceDate:beginDate];
    int days=(time)/(3600*24);
    return days;
}

/**将format1格式的dateString转换成format2格式的字符*/
+ (NSString *)getTimeStr:(NSString *)dateString format1:(NSString *)formart1 format2:(NSString *)formart2{
    if (IsEmpty(dateString)) {
        return @"";
    }
    NSDateFormatter* dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:formart1];
    [dateFormat setTimeZone:[NSTimeZone timeZoneWithName:@"Asia/Shanghai"]];
    NSDate *date =[dateFormat dateFromString:dateString];
    if (date == nil) {
        return @"";
    }
    NSDateFormatter* dateFormat2 = [[NSDateFormatter alloc] init];
    [dateFormat2 setDateFormat:formart2];
    [dateFormat2 setTimeZone:[NSTimeZone timeZoneWithName:@"Asia/Shanghai"]];
    NSString *publishtimeStr = [dateFormat2 stringFromDate:date ];
    
    return publishtimeStr;
}


+(NSDate*)getTodayDate{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDate *now = [NSDate date];
    NSDateComponents *components = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:now];
    NSDate *startDate = [calendar dateFromComponents:components];
    return startDate;
    
}

+ (NSInteger)compareOneDay:(NSDate *)oneDay withAnotherDay:(NSDate *)anotherDay
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd-MM-yyyy-HHmmss"];
    NSString *oneDayStr = [dateFormatter stringFromDate:oneDay];
    NSString *anotherDayStr = [dateFormatter stringFromDate:anotherDay];
    NSDate *dateA = [dateFormatter dateFromString:oneDayStr];
    NSDate *dateB = [dateFormatter dateFromString:anotherDayStr];
    NSComparisonResult result = [dateA compare:dateB];
//    NSLog(@"date1 : %@, date2 : %@", oneDay, anotherDay);
    if (result == NSOrderedDescending) {
        //NSLog(@"Date1  is in the future");
        return 1;
    }
    else if (result == NSOrderedAscending){
        //NSLog(@"Date1 is in the past");
        return -1;
    }
    //NSLog(@"Both dates are the same");
    return 0;
    
}

+(BOOL)bigString:(NSString *)bigString containString:(NSString *)string{
    NSArray  *array = [bigString componentsSeparatedByString:@","];//--分隔符
    for (NSString *str in array) {
        if ([str isEqualToString:string]) {
            return YES;
        }
    }
    return NO;
}


+ (NSMutableAttributedString *)getLabelWithStr:(NSString *)titleStr unitStr:(NSString *)unitStr titleColor:(UIColor *)titleColor unitColor:(UIColor *)unitColor titleFont:(NSInteger)titleFont unitFont:(NSInteger)unitFont{//图文混排
    
    titleStr = IsEmpty(titleStr)?@"":titleStr;
    unitStr = IsEmpty(unitStr)?@"":unitStr;
    NSMutableAttributedString *startString = [[NSMutableAttributedString alloc] initWithString:titleStr];
    [startString addAttributes:@{
                                 NSForegroundColorAttributeName: titleColor,
                                 NSFontAttributeName:[UIFont fontWithFontName:FontNamePingFangRegular size:titleFont]
                                                      } range:NSMakeRange(0, titleStr.length)];
    
    NSMutableAttributedString *endString = [[NSMutableAttributedString alloc] initWithString:unitStr];
    [endString addAttributes:@{
                                 NSForegroundColorAttributeName: unitColor,
                                 NSFontAttributeName:[UIFont fontWithFontName:FontNamePingFangRegular size:unitFont]
                                 } range:NSMakeRange(0, unitStr.length)];
    
    
    [startString appendAttributedString:endString];
    return startString;
}
+ (NSMutableAttributedString *)getLabelWithStr:(NSString *)titleStr titleColor:(UIColor *)titleColor unitFont:(NSInteger)unitFont imageName:(NSString *)imageName frame:(CGRect)frame location:(NSInteger)location{//图文混排带图片
    
    NSMutableAttributedString * attri = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@",titleStr]];
    
    [attri addAttribute:NSForegroundColorAttributeName value:titleColor range:NSMakeRange(0, titleStr.length)];
    // 添加表情
    NSTextAttachment *attch = [[NSTextAttachment alloc] init];
    // 表情图片
    attch.image = [UIImage imageNamed:imageName];
    // 设置图片大小
    attch.bounds = frame;
    
    // 创建带有图片的富文本
    NSAttributedString *string = [NSAttributedString attributedStringWithAttachment:attch];
    
    [attri insertAttributedString:string atIndex:location];
    
    [attri appendAttributedString:string];
    
    return attri;
}
+ (NSString *)separatedDigitStringWithStr:(NSString *)digitString {
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc]init];
    [numberFormatter setFormatterBehavior:NSNumberFormatterBehavior10_4];
    [numberFormatter setNumberStyle:NSNumberFormatterDecimalStyle];
    NSString *numberString = [numberFormatter stringFromNumber:[NSNumber numberWithDouble:[digitString doubleValue]]];
    return numberString;
}

+ (void)setAttributeStringForPriceLabel:(UILabel *)label text:(NSString *)text
{
    NSMutableAttributedString *attrString = [[NSMutableAttributedString
                                              alloc] initWithString:text];
    NSUInteger length = [text length];
    NSMutableParagraphStyle *
    style = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
    style.tailIndent = -10; //设置与尾部的距离
    style.alignment = NSTextAlignmentRight;//靠右显示
    [attrString addAttribute:NSParagraphStyleAttributeName value:style
                       range:NSMakeRange(0, length)];
    label.attributedText = attrString;
}

+ (NSString *)getNumberStr:(NSString*)numberStr RangeIntValue:(NSInteger)rangIntValue{

    NSDecimalNumberHandler *roundingBehavior = [NSDecimalNumberHandler decimalNumberHandlerWithRoundingMode:NSRoundPlain
                                                scale:rangIntValue
                                                raiseOnExactness:NO
                                                raiseOnOverflow:NO
                                                raiseOnUnderflow:NO
                                                raiseOnDivideByZero:NO];
    
//    NSNumber *numberS = [NSNumber numberWithDouble:[numberStr doubleValue]];
    NSDecimalNumber *numberDec = [NSDecimalNumber decimalNumberWithString:numberStr];
    NSString *tempStr =[[numberDec decimalNumberByRoundingAccordingToBehavior:roundingBehavior] stringValue];
    NSLog(@"NSDecimalNumber method  rounding = %@",tempStr);
    return tempStr;
}




+ (NSString *)getResult:(NSDictionary *)dic text:(NSString *)text{
    NSArray *keys = [dic allKeys];
    NSString *result = @"";
    for (NSString *str in keys) {
        if ([text isEqualToString:str]) {
            result = dic[str];
            break;
        }
    }
    return result;
}

+ (NSString *)disable_emoji:(NSString *)text{
    //限制输入表情
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"[^\\u0020-\\u007E\\u00A0-\\u00BE\\u2E80-\\uA4CF\\uF900-\\uFAFF\\uFE30-\\uFE4F\\uFF00-\\uFFEF\\u0080-\\u009F\\u2000-\\u201f\r\n]" options:NSRegularExpressionCaseInsensitive error:nil];
    NSString *modifiedString = [regex stringByReplacingMatchesInString:text
                                                               options:0
                                                                 range:NSMakeRange(0, [text length])
                                                          withTemplate:@""];
    [modifiedString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    [modifiedString stringByReplacingOccurrencesOfString:@"\r" withString:@""];
    [modifiedString stringByReplacingOccurrencesOfString:@" " withString:@""];
    return modifiedString;
}

+ (NSString *)getWeekTimeWith:(NSInteger)index
{
    
    
    NSDate *nowDate = [NSDate date];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *comp = [calendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitWeekday | NSCalendarUnitDay fromDate:nowDate];
    // 获取今天是周几
    NSInteger weekDay = [comp weekday];
    // 获取几天是几号
    NSInteger day = [comp day];
    
    // 计算当前日期和本周的星期一和星期天相差天数
    long firstDiff,lastDiff;
    //    weekDay = 1;
    if (weekDay == 1)
    {
        firstDiff = -6+index*7;
        lastDiff = 0;
    }
    else
    {
        firstDiff = [calendar firstWeekday] - weekDay + 1+index*7;
        lastDiff = 8 - weekDay+index*7;
    }
    NSLog(@"firstDiff: %ld   lastDiff: %ld",firstDiff,lastDiff);
    
    // 在当前日期(去掉时分秒)基础上加上差的天数
    NSDateComponents *firstDayComp = [calendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay  fromDate:nowDate];
    [firstDayComp setDay:day + firstDiff];
    NSDate *firstDayOfWeek = [calendar dateFromComponents:firstDayComp];
    
    NSDateComponents *lastDayComp = [calendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay   fromDate:nowDate];
    [lastDayComp setDay:day + lastDiff];
    NSDate *lastDayOfWeek = [calendar dateFromComponents:lastDayComp];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"YYYY-MM-dd"];
    NSString *firstDay = [formatter stringFromDate:firstDayOfWeek];
    NSString *lastDay = [formatter stringFromDate:lastDayOfWeek];
    
    NSString *dateStr = [NSString stringWithFormat:@"%@~%@",firstDay,lastDay];
    
    return dateStr;
    
}

+ (NSMutableAttributedString *)getLabelWithStr:(NSString *)titleStr title:(NSString *)title titleColor:(NSString *)titleColor titleFont:(NSInteger)titleFont unitFont:(NSInteger)unitFont
{//图文混排
    
    NSRange range1 = [titleStr rangeOfString:@"."];
    
    if (range1.location == NSNotFound) {
        NSMutableAttributedString * attri = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@",titleStr]];
        [attri addAttribute:NSForegroundColorAttributeName value:[UIColor colorFromHexCode:titleColor] range:NSMakeRange(0, title.length)];
        [attri addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:titleFont] range:NSMakeRange(0, title.length)];
        
        [attri addAttribute:NSForegroundColorAttributeName value:[UIColor colorFromHexCode:titleColor] range:NSMakeRange(title.length, titleStr.length-title.length)];
        [attri addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:unitFont] range:NSMakeRange(title.length, titleStr.length-title.length)];
        return attri;
    }else{
        
        NSMutableAttributedString * attri = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@",titleStr]];
        [attri addAttribute:NSForegroundColorAttributeName value:[UIColor colorFromHexCode:titleColor] range:NSMakeRange(0, range1.location)];
        [attri addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:titleFont] range:NSMakeRange(0, range1.location)];
        
        [attri addAttribute:NSForegroundColorAttributeName value:[UIColor colorFromHexCode:titleColor] range:NSMakeRange(range1.location, titleStr.length-range1.location)];
        [attri addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:unitFont] range:NSMakeRange(range1.location, titleStr.length-range1.location)];
        return attri;
        
        
    }
    
}


+ (NSMutableAttributedString *)getLabelWithFontStr:(NSString *)titleStr title:(NSString *)title titleColor:(NSString *)titleColor titleFont:(UIFont *)titleFont unitFont:(UIFont *)unitFont
{
    NSRange range1 = [titleStr rangeOfString:@"."];
    
    if (range1.location == NSNotFound) {
        NSMutableAttributedString * attri = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@",titleStr]];
        [attri addAttribute:NSForegroundColorAttributeName value:[UIColor colorFromHexCode:titleColor] range:NSMakeRange(0, title.length)];
        [attri addAttribute:NSFontAttributeName value:titleFont range:NSMakeRange(0, title.length)];
        
        [attri addAttribute:NSForegroundColorAttributeName value:[UIColor colorFromHexCode:titleColor] range:NSMakeRange(title.length, titleStr.length-title.length)];
        [attri addAttribute:NSFontAttributeName value:unitFont range:NSMakeRange(title.length, titleStr.length-title.length)];
        return attri;
    }else{
        
        NSMutableAttributedString * attri = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@",titleStr]];
        [attri addAttribute:NSForegroundColorAttributeName value:[UIColor colorFromHexCode:titleColor] range:NSMakeRange(0, range1.location)];
        [attri addAttribute:NSFontAttributeName value:titleFont range:NSMakeRange(0, range1.location)];
        
        [attri addAttribute:NSForegroundColorAttributeName value:[UIColor colorFromHexCode:titleColor] range:NSMakeRange(range1.location, titleStr.length-range1.location)];
        [attri addAttribute:NSFontAttributeName value:unitFont range:NSMakeRange(range1.location, titleStr.length-range1.location)];
        return attri;
        
        
    }
}

+ (NSString *)freeDiskSpaceInByt{//获取设备剩余存储空间
    struct statfs buf;
    long long freespace = -1;
    if(statfs("/var", &buf) >= 0){
        freespace = (long long)(buf.f_bsize * buf.f_bfree);
    }
    
    if (freespace>1024*1024*1024){
        return [NSString stringWithFormat:@"%.1qiG",freespace/1024/1024/1024];//大于1G，则转化成G单位的字符串
    }
    else if(freespace<1024*1024*1024&&freespace>=1024*1024)//大于1M，则转化成M单位的字符串
    {
        return [NSString stringWithFormat:@"%.1qiM",freespace/1024/1024];
    }
    else if(freespace>=1024&&freespace<1024*1024) //不到1M,但是超过了1KB，则转化成KB单位
    {
        return [NSString stringWithFormat:@"%.1qiK",freespace/1024];
    }
    else//剩下的都是小于1K的，则转化成B单位
    {
        return [NSString stringWithFormat:@"%.1qiB",freespace];
    }
    
}
+(NSString *)addTwoNumberWithOneNumStr:(NSString *)one anotherNumStr:(NSString *)another
{
    int i = 0;
    int j = 0;
    int maxLength = 0;
    int sum = 0;
    int overflow = 0;
    int carryBit = 0;
    NSString *temp1 = @"";
    NSString *temp2 = @"";
    NSString *sums = @"";
    NSString *tempSum = @"";
    int length1 = (int)one.length;
    int length2 = (int)another.length;
    //1.反转字符串
    for (i = length1 - 1; i >= 0 ; i--) {
        NSRange range = NSMakeRange(i, 1);
        temp1 = [temp1 stringByAppendingString:[one substringWithRange:range]];
        NSLog(@"%@",temp1);
    }
    for (j = length2 - 1; j >= 0; j--) {
        NSRange range = NSMakeRange(j, 1);
        temp2 = [temp2 stringByAppendingString:[another substringWithRange:range]];
        NSLog(@"%@",temp2);
    }
    
    //2.补全缺少位数为0
    maxLength = length1 > length2 ? length1 : length2;
    if (maxLength == length1) {
        for (i = length2; i < length1; i++) {
            temp2 = [temp2 stringByAppendingString:@"0"];
            NSLog(@"i = %d --%@",i,temp2);
        }
    }else{
        for (j = length1; j < length2; j++) {
            temp1 = [temp1 stringByAppendingString:@"0"];
            NSLog(@"j = %d --%@",j,temp1);
        }
    }
    //3.取数做加法
    for (i = 0; i < maxLength; i++) {
        NSRange range = NSMakeRange(i, 1);
        int a = [temp1 substringWithRange:range].intValue;
        int b = [temp2 substringWithRange:range].intValue;
        sum = a + b + carryBit;
        if (sum > 9) {
            if (i == maxLength -1) {
                overflow = 1;
            }
            carryBit = 1;
            sum -= 10;
        }else{
            carryBit = 0;
        }
        tempSum = [tempSum stringByAppendingString:[NSString stringWithFormat:@"%d",sum]];
    }
    if (overflow == 1) {
        tempSum = [tempSum stringByAppendingString:@"1"];
    }
    int sumlength = (int)tempSum.length;
    for (i = sumlength - 1; i >= 0 ; i--) {
        NSRange range = NSMakeRange(i, 1);
        sums = [sums stringByAppendingString:[tempSum substringWithRange:range]];
    }
    NSLog(@"sums = %@",sums);
    return sums;
}

+(NSMutableDictionary*)getURLParametersWith:(NSString *)url {
    
    NSRange  range = [url rangeOfString:@"?"];
    
    if(range.location==NSNotFound) {
        
        return  nil;
        
    }
    
    NSMutableDictionary  *params = [NSMutableDictionary   dictionary];
    
    NSString  *parametersString = [url substringFromIndex:range.location+1];
    
    if([parametersString   containsString:@"&"]) {
        
        NSArray  *urlComponents = [parametersString   componentsSeparatedByString:@"&"];
        
        for(NSString *keyValuePair in urlComponents) {
            
            //生成key/value
            
            NSArray *pairComponents = [keyValuePair  componentsSeparatedByString:@"="];
            
            NSString *key;
            NSString*value;
            if (pairComponents.count != 2) {

                NSRange range = [keyValuePair rangeOfString:@"="];
                key = [keyValuePair substringToIndex:range.location];
                value = [keyValuePair substringFromIndex:range.location+1];
                
            }else{
                key = [pairComponents.firstObject  stringByRemovingPercentEncoding];
                value = [pairComponents.lastObject  stringByRemovingPercentEncoding];
            }
            
            
            //key不能为nil
            
            if(key==nil|| value ==nil) {
                
                continue;
                
            }
            
            id existValue = [params valueForKey:key];
            
            if(existValue !=nil) {
                
                //已存在的值，生成数组。
                
                if([existValue  isKindOfClass:[NSArray  class]]) {
                    
                    //已存在的值生成数组
                    
                    NSMutableArray*items = [NSMutableArray arrayWithArray:existValue];
                    
                    [items addObject:value];
                    
                    [params setValue:items forKey:key];
                    
                }else{
                    
                    //非数组
                    
                    [params setValue:@[existValue,value]forKey:key];
                    
                }
                
            }else{
                
                //设置值
                
                [params setValue:value forKey:key];
                
            }
            
        }
        
    }else{
        
        //单个参数生成key/value
        
        NSArray *pairComponents = [parametersString  componentsSeparatedByString:@"="];
        
        if(pairComponents.count==1) {
            
            return nil;
            
        }
        
        //分隔值
        NSString *key;
        NSString *value;
        
        if (pairComponents.count==2) {
            key = [pairComponents.firstObject  stringByRemovingPercentEncoding];
            
            value = [pairComponents.lastObject  stringByRemovingPercentEncoding];
        }else{
            
            key = [pairComponents.firstObject  stringByRemovingPercentEncoding];
            
//            NSRange range=[parametersString rangeOfString:@"="];
//            
//            value=[parametersString substringFromIndex:range.location+1];
            
            value = [parametersString  stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"%@=",key] withString:@""];
            
        }
        
        
        
        //key不能为nil
        
        if(key ==nil|| value ==nil) {
            
            return nil;
            
        }
        
        //设置值
        
        [params setValue:value forKey:key];
        
    }
    
    return params;
    
}
+ (UIImage *)compressedImageFiles:(UIImage *)image
                          imageKB:(CGFloat)fImageKBytes{
    
    __block UIImage *imageCope = image;
    CGFloat fImageBytes = fImageKBytes * 1024;//需要压缩的字节Byte
    
    __block NSData *uploadImageData = nil;
    
    uploadImageData = UIImagePNGRepresentation(imageCope);
    NSLog(@"图片压前缩成 %fKB",uploadImageData.length/1024.0);
    CGSize size = imageCope.size;
    CGFloat imageWidth = size.width;
    CGFloat imageHeight = size.height;
    
    if (uploadImageData.length > fImageBytes && fImageBytes >0) {
        
        /* 宽高的比例 **/
        CGFloat ratioOfWH = imageWidth/imageHeight;
        /* 压缩率 **/
        CGFloat compressionRatio = fImageBytes/uploadImageData.length;
        /* 宽度或者高度的压缩率 **/
        CGFloat widthOrHeightCompressionRatio = sqrt(compressionRatio);
        
        CGFloat dWidth   = imageWidth *widthOrHeightCompressionRatio;
        CGFloat dHeight  = imageHeight*widthOrHeightCompressionRatio;
        if (ratioOfWH >0) { /* 宽 > 高,说明宽度的压缩相对来说更大些 **/
            dHeight = dWidth/ratioOfWH;
        }else {
            dWidth  = dHeight*ratioOfWH;
        }
        
        imageCope = [self drawWithWithImage:imageCope width:dWidth height:dHeight];
        uploadImageData = UIImagePNGRepresentation(imageCope);
        
        NSLog(@"当前的图片已经压缩成 %fKB",uploadImageData.length/1024.0);
        //微调
        NSInteger compressCount = 0;
        /* 控制在 10M 以内**/
        while (fabs(uploadImageData.length - fImageBytes) > 10) {
            /* 再次压缩的比例**/
            CGFloat nextCompressionRatio = 0.9;
            
            if (uploadImageData.length > fImageBytes) {
                dWidth = dWidth*nextCompressionRatio;
                dHeight= dHeight*nextCompressionRatio;
            }else {
                dWidth = dWidth/nextCompressionRatio;
                dHeight= dHeight/nextCompressionRatio;
            }
            
            imageCope = [self drawWithWithImage:imageCope width:dWidth height:dHeight];
            uploadImageData = UIImagePNGRepresentation(imageCope);
            
            /*防止进入死循环**/
            compressCount ++;
            if (compressCount == 20) {
                break;
            }
            
        }
        
        NSLog(@"图片已经压缩成 %fKB",uploadImageData.length/1024.0);
        imageCope = [[UIImage alloc] initWithData:uploadImageData];
        return imageCope;
    }
    else
    {
        return imageCope;
    }
}




/* 根据 dWidth dHeight 返回一个新的image**/
+ (UIImage *)drawWithWithImage:(UIImage *)imageCope width:(CGFloat)dWidth height:(CGFloat)dHeight{
    
    UIGraphicsBeginImageContext(CGSizeMake(dWidth, dHeight));
    [imageCope drawInRect:CGRectMake(0, 0, dWidth, dHeight)];
    imageCope = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return imageCope;
    
}
//隐藏手机号中间四位
+(NSString *)numberSuitScanf:(NSString*)number{
    
//    //首先验证是不是手机号码
//
//    NSString *MOBILE = @"^1(3[0-9]|4[57]|5[0-35-9]|8[0-9]|7[06-8])\\\\d{8}$";
//
//    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
//
    BOOL isOk = [Utils valiMobile:number];
    
    if (isOk) {//如果是手机号码的话
        
        NSString *numberString = [number stringByReplacingCharactersInRange:NSMakeRange(3, 4) withString:@"****"];
        
        return numberString;
        
    }
    
    return number;
    
}

+(UIButton *)establishBtnWith:(CGRect)frame title:(NSString *)title font:(NSInteger)font color:(UIColor *)color image:(NSString *)image type:(UIButtonType)type
{
    UIButton * btn = [UIButton buttonWithType:type];
    btn.frame = frame;
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:color forState:UIControlStateNormal];
    if (!IsEmpty(image)) {
       [btn setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    }
    btn.titleLabel.font = SYSTEMFONT(font);
    return btn;
}

+ (UIImage *)drawLineOfDashByImageView:(UIImageView *)imageView color:(UIColor *)color{
    // 开始划线 划线的frame
    UIGraphicsBeginImageContext(imageView.frame.size);
    
    [imageView.image drawInRect:CGRectMake(0, 0, imageView.frame.size.width, imageView.frame.size.height)];
    
    // 获取上下文
    CGContextRef line = UIGraphicsGetCurrentContext();
    
    // 设置线条终点的形状
    CGContextSetLineCap(line, kCGLineCapRound);
    // 设置虚线的长度 和 间距
    CGFloat lengths[] = {5,5};
    
    CGContextSetStrokeColorWithColor(line, color.CGColor);
    // 开始绘制虚线
    CGContextSetLineDash(line, 0, lengths, 2);
    
    CGContextMoveToPoint(line, 0.0, 2.0);
    
    CGContextAddLineToPoint(line, 300, 2.0);
    
    CGContextStrokePath(line);
    
    // UIGraphicsGetImageFromCurrentImageContext()返回的就是image
    return UIGraphicsGetImageFromCurrentImageContext();
}

+ (UIViewController *)getTopViewController{
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    if (window.windowLevel != UIWindowLevelNormal){
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow * tmpWin in windows){
            if (tmpWin.windowLevel == UIWindowLevelNormal){
                window = tmpWin;
                break;
            }
        }
    }
    UIViewController *vc = window.rootViewController;
    while (vc.presentedViewController) {
        vc = vc.presentedViewController;
        if ([vc isKindOfClass:[UIAlertController class]]) {
            vc = vc.parentViewController;
        }
    }
    if ([vc isKindOfClass:[UITabBarController class]]) {
        vc = [(UITabBarController *)vc selectedViewController];
    }
    if ([vc isKindOfClass:[UINavigationController class]]) {
        vc = [(UINavigationController *)vc topViewController];
    }
    return vc;
}

+(NSString *)convertToJsonData:(NSDictionary *)dict

{
    
    NSError *error;
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:&error];
    
    NSString *jsonString;
    
    if (!jsonData) {
        
        NSLog(@"%@",error);
        
    }else{
        
        jsonString = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
        
    }
    
    NSMutableString *mutStr = [NSMutableString stringWithString:jsonString];
    
    NSRange range = {0,jsonString.length};
    
    //去掉字符串中的空格
    
    [mutStr replaceOccurrencesOfString:@" " withString:@"" options:NSLiteralSearch range:range];
    
    NSRange range2 = {0,mutStr.length};
    
    //去掉字符串中的换行符
    
    [mutStr replaceOccurrencesOfString:@"\n" withString:@"" options:NSLiteralSearch range:range2];
    
    return mutStr;
    
}

+(UIViewController *)getCurrentVC {
    
    UIWindow *window = [[UIApplication sharedApplication].windows firstObject];
    if (!window) {
        return nil;
    }
    UIView *tempView;
    for (UIView *subview in window.subviews) {
        if ([[subview.classForCoder description] isEqualToString:@"UILayoutContainerView"]) {
            tempView = subview;
            break;
        }
    }
    if (!tempView) {
        tempView = [window.subviews lastObject];
    }
    
    id nextResponder = [tempView nextResponder];
    while (![nextResponder isKindOfClass:[UIViewController class]] || [nextResponder isKindOfClass:[UINavigationController class]] || [nextResponder isKindOfClass:[UITabBarController class]]) {
        tempView =  [tempView.subviews firstObject];
        
        if (!tempView) {
            return nil;
        }
        nextResponder = [tempView nextResponder];
    }
    return  (UIViewController *)nextResponder;
}

+ (NSString *)getToken{
    NSError * error = nil;
    NSString * token = [SSKeychain passwordForService:@"com.purang" account:@"token" error:&error];
    if ([error code] == SSKeychainErrorNotFound) {
        CFUUIDRef uuid = CFUUIDCreate(NULL);
        assert(uuid != NULL);
        CFStringRef uuidStr = CFUUIDCreateString(NULL, uuid);
        
        [SSKeychain setPassword: [NSString stringWithFormat:@"%@", uuidStr]
                     forService:@"com.purang"account:@"token"];
        NSString *retrieveuuid = [SSKeychain passwordForService:@"com.purang"account:@"token"];
        token = retrieveuuid;
    }
    return token;
}

@end
