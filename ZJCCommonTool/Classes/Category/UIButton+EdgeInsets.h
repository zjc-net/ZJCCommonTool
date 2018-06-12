//
//  UIButton+EdgeInsets.h
//  XWEncapsulation
//
//  Created by wangxiangwei on 16/12/14.
//  Copyright © 2016年 purang. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, XWImagePositionType) {
    XWImagePositionTypeLeft,   //图片在左，标题在右，默认风格
    XWImagePositionTypeRight,  //图片在右，标题在左
    XWImagePositionTypeTop,    //图片在上，标题在下
    XWImagePositionTypeBottom  //图片在下，标题在上
};

typedef NS_ENUM(NSInteger, XWEdgeInsetsType) {
    XWEdgeInsetsTypeTitle,//标题
    XWEdgeInsetsTypeImage//图片
};

typedef NS_ENUM(NSInteger, XWMarginType) {
    XWMarginTypeTop         ,
    XWMarginTypeBottom      ,
    XWMarginTypeLeft        ,
    XWMarginTypeRight       ,
    XWMarginTypeTopLeft     ,
    XWMarginTypeTopRight    ,
    XWMarginTypeBottomLeft  ,
    XWMarginTypeBottomRight
};

/**
 默认情况下，imageEdgeInsets和titleEdgeInsets都是0。先不考虑height,
 
 if (button.width小于imageView上image的width){图像会被压缩，文字不显示}
 
 if (button.width < imageView.width + label.width){图像正常显示，文字显示不全}
 
 if (button.width >＝ imageView.width + label.width){图像和文字都居中显示，imageView在左，label在右，中间没有空隙}
 */

@interface UIButton (EdgeInsets)
/**
 *  利用UIButton的titleEdgeInsets和imageEdgeInsets来实现图片和标题的自由排布
 *  注意：1.该方法需在设置图片和标题之后才调用;
 2.图片和标题改变后需再次调用以重新计算titleEdgeInsets和imageEdgeInsets
 *
 *  @param type    图片位置类型
 *  @param spacing 图片和标题之间的间隙
 *  @param state button的图片文字取自哪种state状态
 */
-(void)setImagePositionWithType:(XWImagePositionType)type spacing:(CGFloat)spacing state:(UIControlState)state;
/**
 *  利用UIButton的titleEdgeInsets和imageEdgeInsets来实现图片和标题的自由排布
 *  注意：1.该方法需在设置图片和标题之后才调用;
 2.图片和标题改变后需再次调用以重新计算titleEdgeInsets和imageEdgeInsets
 *
 *  @param type    图片位置类型
 *  @param spacing 图片和标题之间的间隙
 */
- (void)setImagePositionWithType:(XWImagePositionType)type spacing:(CGFloat)spacing;

/**
 *  按钮只设置了title or image，该方法可以改变它们的位置
 *
 */
- (void)setEdgeInsetsWithType:(XWEdgeInsetsType)edgeInsetsType marginType:(XWMarginType)marginType margin:(CGFloat)margin;

/**
 *  按钮点击响应区域
 *
 */
- (void)setEnlargeEdgeWithTop:(CGFloat)top right:(CGFloat)right bottom:(CGFloat)bottom left:(CGFloat)left;
@end
