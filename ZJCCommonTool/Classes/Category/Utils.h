//
//  Utils.h
//  PurangFinanceVillage
//
//  Created by purang\daichen on 2017/4/11.
//  Copyright © 2017年 ___PURANG___. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Utils : NSObject


//校验身份证格式是否正确
+ (BOOL)validateIDCardNumber:(NSString *)value;
//根据身份证号获取性别
+(NSString *)getIdentityCardSex:(NSString *)numberStr;
//根据身份证号获取年龄
+(NSString *)getIdentityCardAge:(NSString *)numberStr;
//根据身份证号获取生日
+(NSString *)birthdayStrFromIdentityCard:(NSString *)numberStr;
//校验手机格式是否正确
+ (BOOL)valiMobile:(NSString *)mobile;
//校验输入的是否是电话
+(BOOL)checkPhoneNumInput:(NSString *)phoneNum;
//校验邮箱格式是否正确
+ (BOOL)checkEmailInput:(NSString *)email;
/**
 * 功能:获取指定范围的字符串
 * 参数:字符串的开始下标
 * 参数:字符串的截取长度
 */
+ (NSString *)getStringWithRange:(NSString *)str startValue:(NSInteger)startValue length:(NSInteger )length;
/**
 * 功能:判断是否在地区码内
 * 参数:地区码
 **/
+ (BOOL)areaCode:(NSString *)code;
+ (BOOL)checkIdentityCard:(NSString *)IDCard;
+ (BOOL) isBlankString:(NSString *)string;
+ (NSString*)changeToCurrencyString:(NSString *)string;
//将字符串md5加密处理
+ (NSString *)md5:(NSString *)string;
//将json字符串处理成字典
+ (NSDictionary *)json_StringToDictionary:(NSString *)jsonString;

//转换颜色值为RGB
+ (UIColor *)colorFromHexCode:(NSString *)hexString;
//颜色转换图片
+ (UIImage *)createImageWithColor:(UIColor *)color;

+ (BOOL)image:(UIImage *)image isEqualToAnotherImage:(UIImage *)anotherImage;
//获取设备iOS系统版本
+ (NSString *)getDeviceVersion;
//获取设备号UUID
+ (NSString *)getDeviceID;
//获取app版本号
+ (NSString *)getClientVersion;

#pragma mark ---- 时间处理
+(NSDate*)addMonthDate:(NSDate*) now withMonths:(NSInteger) months;
+(NSDate *)addDayDate:(NSDate *)now withDays:(NSInteger)days;
//获取当前年份
+(NSString *)getCurrentyear;
//获取当前月份
+(NSString *)getCurrentMonth;
//获取当前时区时间 格式yyyyMMdd
+(NSString *)getCurrentDateString ;
+ (NSDate *)getNowDateFromatAnDate:(NSDate *)anyDate;
//获取当前时区时间 格式format
+(NSString *)getCurrentDateStringWithDateFormat:(NSString *)format ;
//获取yyyy-MM-dd时间
+(NSString *)formatDateString :(NSDate*)date;
//获取dateFormat格式时间
+(NSString *)strformatDateString :(NSDate*)date dateFormat:(NSString *)dateFormat;
+(NSDate *)dateformatDateString :(NSString*)dateStr dateFormat:(NSString *)dateFormat;
//endDate - beginDate 天数
+ (NSInteger) calcDaysFromBegin:(NSDate *)beginDate end:(NSDate *)endDate;
/**获取今天的零点的date*/
+(NSDate*)getTodayDate;

/**将format1格式的dateString转换成format2格式的字符*/
+ (NSString *)getTimeStr:(NSString *)dateString format1:(NSString *)formart1 format2:(NSString *)formart2;

/**比较day1和day2大小  1—>day1大 -1->day2大 0->相同*/
+ (NSInteger)compareOneDay:(NSDate *)oneDay withAnotherDay:(NSDate *)anotherDay;

/**判断数组转成的字符串A中是否包含字符串B*/
+(BOOL)bigString:(NSString *)bigString containString:(NSString *)string;
//图文混排
+ (NSMutableAttributedString *)getLabelWithStr:(NSString *)titleStr unitStr:(NSString *)unitStr titleColor:(UIColor *)titleColor unitColor:(UIColor *)unitColor titleFont:(NSInteger)titleFont unitFont:(NSInteger)unitFont;



+ (NSMutableAttributedString *)getLabelWithStr:(NSString *)titleStr titleColor:(UIColor *)titleColor unitFont:(NSInteger)unitFont imageName:(NSString *)imageName frame:(CGRect)frame location:(NSInteger)location;

//小数点后的图文混排

+ (NSMutableAttributedString *)getLabelWithStr:(NSString *)titleStr title:(NSString *)title titleColor:(NSString *)titleColor titleFont:(NSInteger)titleFont unitFont:(NSInteger)unitFont;

+ (NSMutableAttributedString *)getLabelWithFontStr:(NSString *)titleStr title:(NSString *)title titleColor:(NSString *)titleColor titleFont:(UIFont *)titleFont unitFont:(UIFont *)unitFont;

/**数字加千位符号*/
+ (NSString *)separatedDigitStringWithStr:(NSString *)digitString;
/**label右对齐但有10的距离*/
+ (void)setAttributeStringForPriceLabel:(UILabel *)label text:(NSString *)text;
/**字符串取位数四舍五入*/
+ (NSString *)getNumberStr:(NSString*)numberStr RangeIntValue:(NSInteger)rangIntValue;
/**移除字符串最后一位的小数点和0*/
+(NSString*)removeFloatAllZero:(NSString*)string;

+ (NSString *)getResult:(NSDictionary *)dic text:(NSString *)text;
//限制输入表情
+ (NSString *)disable_emoji:(NSString *)text;
//后取周数据
+ (NSString *)getWeekTimeWith:(NSInteger)index;
//获取设备剩余存储空间
+ (NSString *)freeDiskSpaceInByt;
//计算超大数字之和
+(NSString *)addTwoNumberWithOneNumStr:(NSString *)one anotherNumStr:(NSString *)another;
//获取url中的数据
+(NSMutableDictionary*)getURLParametersWith:(NSString *)url;
+ (UIImage *)compressedImageFiles:(UIImage *)image
                       imageKB:(CGFloat)fImageKBytes;

//隐藏手机号中间四位
+(NSString *)numberSuitScanf:(NSString*)number;


+(UIButton *)establishBtnWith:(CGRect)frame title:(NSString *)title font:(NSInteger)font color:(UIColor *)color image:(NSString *)image type:(UIButtonType)type;
//画虚线
+ (UIImage *)drawLineOfDashByImageView:(UIImageView *)imageView color:(UIColor *)color;
//获取当前最上层控制器
+ (UIViewController *)getTopViewController;
//字典转json
+(NSString *)convertToJsonData:(NSDictionary *)dict;

//获取当前最上层控制器
+ (UIViewController *)getTopViewController;
//字典转json
+(NSString *)convertToJsonData:(NSDictionary *)dict;

+(UIViewController *)getCurrentVC;

+ (NSString *)getToken;

@end
