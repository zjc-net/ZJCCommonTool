//
//  Header.h
//  普兰金融
//
//  Created by liumingkui on 15/4/14.
//  Copyright (c) 2015年 ___PURANG___. All rights reserved.
//

#ifndef _____Header_h
#define _____Header_h

#define kWeakSelf(type)   __weak typeof(type) weak##type = type;
#define kStrongSelf(type) __strong typeof(type) type = weak##type;
//com.sina.weibo.SNWeiboSDKDemo
#define kAppKey         @"4235357454"
#define kRedirectURI    @"http://www.sina.com"
#define KWEBANKID @"W2864437"

#define Format(string) [NSString stringWithFormat:@"%@",string]

//重写NSLog,Debug模式下打印日志和当前行数
#if DEBUG
#define NSLog(FORMAT, ...) fprintf(stderr,"\nfunction:%s line:%d content:%s\n", __FUNCTION__, __LINE__, [[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String]);
#else
#define NSLog(FORMAT, ...) nil
#endif

#if DEBUG
#define DLog( s, ... ) NSLog( @"<%p %@:(%d)> %@", self, [[NSString stringWithUTF8String:__FILE__] lastPathComponent], __LINE__, [NSString stringWithFormat:(s), ##__VA_ARGS__] )
#else
#define DLog( s, ... )
#endif

/* ********************获取frame大小********************* */
#define XOf(v)                    (v).frame.origin.x
#define YOf(v)                    (v).frame.origin.y
#define WIDTHOf(v)                (v).frame.size.width
#define HEIGHTOf(v)               (v).frame.size.height

#define MinX(v)                 CGRectGetMinX((v).frame)
#define MinY(v)                 CGRectGetMinY((v).frame)

#define MidX(v)                 CGRectGetMidX((v).frame)
#define MidY(v)                 CGRectGetMidY((v).frame)

#define MaxX(v)                 CGRectGetMaxX((v).frame)
#define MaxY(v)                 CGRectGetMaxY((v).frame)

// 屏幕高度
#define SCREEN_HEIGHT         [[UIScreen mainScreen] bounds].size.height
//比例高度
#define SCREEN_HEIGHT_iPhoneX        (iPhoneX ? 667 : SCREEN_HEIGHT)
// 屏幕宽度
#define SCREEN_WIDTH          [[UIScreen mainScreen] bounds].size.width
#define SCALEW(x)  ([[UIScreen mainScreen] bounds].size.width*(x)/375.0)
#define WIDTH [UIDevice width]
#define HEIGHT [UIDevice height]

// Status bar height.
#define  StatusBarHeight      (iPhoneX ? 44.f : 20.f)
// Navigation bar height.
#define  NavigationBarHeight  44.f
// Tabbar height.
#define  TabbarHeight         (iPhoneX ? (49.f+34.f) : 49.f)
// Tabbar safe bottom margin.
#define  TabbarSafeBottomMargin         (iPhoneX ? 34.f : 0.f)
// Status bar & navigation bar height.
#define  StatusBarAndNavigationBarHeight  (iPhoneX ? 88.f : 64.f)
// Keyboard height
#define  KStatusBottomBarHeight      (iPhoneX ? 70.f : 0.f)

#define ViewSafeAreInsets(view) ({UIEdgeInsets insets; if(@available(iOS 11.0, *)) {insets = view.safeAreaInsets;} else {insets = UIEdgeInsetsZero;} insets;})

/**********正则表达式**********/
//直贴买入金额限制 区间0.000001-999999.999999，最多6位小数
#define NoteStraBuySumLimit @"(([0]|(0[.]\\d{0,6}))|([1-9]\\d{0,5}(([.]\\d{0,6})?)))?"
//直贴买入利率限制 0.01-49.99
#define NoteStraBuyRateLimit @"[1-4]?\\d([.]\\d{0,2})?"
//转贴天数限制  0~400,(0~400)-(0~400)
#define NoteQuoteDaysLimit @"((([1-3]\\d)|[1-9])\\d{0,1}|400)(-((([1-3]\\d)|[1-9])\\d{0,1}|400)?)?"
#define NoteQuoteSumLimit @"(([0]|(0[.]\\d{0,4}))|([1-9]\\d{0,3}(([.]\\d{0,4})?)))?"
#define NoteQuoteRateLimit @"[1-4]?\\d([.]\\d{0,4})?"
//同业理财金额9999.9999
#define FinancialSumLimit1 @"(([0]|(0[.]\\d{0,4}))|([1-9]\\d{0,3}(([.]\\d{0,4})?)))?"
//企业理财金额999999.9999
#define FinancialSumLimit2 @"(([0]|(0[.]\\d{0,6}))|([1-9]\\d{0,5}(([.]\\d{0,4})?)))?"
//理财 期限99999
#define FinancialDayLimit @"([1-9]\\d{0,4})?"
//理财 收益率 50.00
#define FinancialRateLimit @"(([1-4]?\\d([.]\\d{0,2})?)|50)?"

#define SYSTEMFONT(FONTSIZE)    [UIFont systemFontOfSize:FONTSIZE]
// rgb颜色转换（16进制->10进制）
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
/** 定义颜色宏或颜色常量 */
#define kRandomColor  [UIColor colorWithRed:arc4random_uniform(256)/255.0 green:arc4random_uniform(256)/255.0 blue:arc4random_uniform(256)/255.0 alpha:1.0]
#define RGBHexAlpha(rgbValue,a) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:(a)]
#define RGBHex(rgbValue) RGBHexAlpha(rgbValue,1.0f)

//带有RGBA的颜色设置
#define COLORRGBA(R, G, B, A) [UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:A]
#define COLORRGB(r,g,b) COLORRGBA(r,g,b,1.0f)

#define LightGraryColor COLORRGB(153,153,153)
#define DarkGrayColor COLORRGB(51,51,51)
#define CellLabelColor COLORRGB(116,116,116)
#define KLineViewColor COLORRGB(57, 61, 73)
#define KCellLableColor1 COLORRGB(108,109,109)
#define KBtnColor1 COLORRGB(40,149,225)
#define KBtnColor2 COLORRGB(255,59,48)

#define KPlaceHolderColor [UIColor colorFromHexCode:@"D2D2D2"]
#define KColor1 COLORRGB(230, 243, 248)
#define KColor2 COLORRGB(205, 231, 240)
#define KColor3 COLORRGB(238, 95, 81)//红
#define KColor4 COLORRGB(152, 152, 152)//灰色
#define KColor5 COLORRGB(102, 102, 102)//灰色
#define KColor6 COLORRGB(60, 138, 197)//蓝色
#define KColor7 COLORRGB(77, 76, 75)//9999会员中心黑灰色
#define KColor8 COLORRGB(244, 224, 145)//9999会员中心黄色
#define KColor9 COLORRGB(54, 54, 57)//9999会员中心黑色
#define KColor10 COLORRGB(156, 155, 155)//9999会员中心文字黑灰色
#define KColor11 COLORRGB(92, 92, 92)//9999会员中心文字黑灰色
#define KColor12 COLORRGB(83, 83, 83)//9999会员cell分割线黑灰色
#define KColor13 COLORRGB(255, 79, 79)//9999会员订单必填项


#define COLOR3 [UIColor colorFromHexCode:@"#333333"]
#define COLOR9 [UIColor colorFromHexCode:@"#999999"]

#define color33 [UIColor colorFromHexCode:@"333333"]
#define colorc7 [UIColor colorFromHexCode:@"c7c7cd"]

//获取Image
#define IMG(NAME) [UIImage imageNamed:(NAME)]
#define OrigIMG(a) [IMG(a) imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]

//获得SB的vc  SB的name和vc的id
#define SBVC(name,vcId) [[UIStoryboard storyboardWithName:name bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:vcId];

// block self
#define WEAKSELF typeof(self) __weak weakSelf = self;
#define STRONGSELF typeof(weakSelf) __strong strongSelf = weakSelf;

// View 圆角和加边框
#define ViewBorderRadius(View, Radius, Width, Color)\
\
[View.layer setCornerRadius:(Radius)];\
[View.layer setMasksToBounds:YES];\
[View.layer setBorderWidth:(Width)];\
[View.layer setBorderColor:[Color CGColor]]

// View 圆角
#define ViewRadius(View, Radius)\
\
[View.layer setCornerRadius:(Radius)];\
[View.layer setMasksToBounds:YES]

//----------------------系统----------------------------

//App版本号
#define PFVAPP_VERSION [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]
//App名称
#define PFVAppName [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleName"]

//获取系统版本
#define kSystemVersion [[UIDevice currentDevice] systemVersion]

//获取当前语言
#define PFVCurrentLanguage ([[NSLocale preferredLanguages] objectAtIndex:0])

//判断是否 Retina屏、设备是否%fhone 5、是否是iPad
#define isRetina ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) : NO)
#define iPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)
#define isPad (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
#define iPhone4S [[UIScreen mainScreen] bounds].size.height >= 480.0f && [[UIScreen mainScreen] bounds].size.height < 568.0f

#define iPhone6OrLater ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? ([[UIScreen mainScreen] currentMode].size.width > 640) : NO)

#define iPhone6 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(750, 1334), [[UIScreen mainScreen] currentMode].size) : NO)
#define iPhone6P ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2208), [[UIScreen mainScreen] currentMode].size) : NO)
#define iPhoneX ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)
#define IOS11_OR_LATER ([[NSProcessInfo processInfo] operatingSystemVersion].majorVersion >= 11)

#define kStringIsEmpty(str) ([str isKindOfClass:[NSNull class]] || [str isEqualToString:@"NULL"] || [str isEqualToString:@"(null)"] || [str isEqualToString:@"<null>"] || [str length] < 1 ? YES : NO )

static inline BOOL IsEmpty(id thing) {
    return thing == nil || [thing isEqual:[NSNull null]]
    || ([thing respondsToSelector:@selector(length)]
        && [(NSData *)thing length] == 0)
    || ([thing respondsToSelector:@selector(count)]
        && [(NSArray *)thing count] == 0);
}

#define  adjustsScrollViewInsets_NO(scrollView,vc)\
do { \
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Warc-performSelector-leaks\"") \
if ([UIScrollView instancesRespondToSelector:NSSelectorFromString(@"setContentInsetAdjustmentBehavior:")]) {\
[scrollView   performSelector:NSSelectorFromString(@"setContentInsetAdjustmentBehavior:") withObject:@(2)];\
} else {\
vc.automaticallyAdjustsScrollViewInsets = NO;\
}\
_Pragma("clang diagnostic pop") \
} while (0)

#endif
