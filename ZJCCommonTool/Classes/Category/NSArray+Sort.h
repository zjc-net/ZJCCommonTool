//
//  NSArray+Sort.h
//  XWEncapsulation
//
//  Created by wangxiangwei on 17/2/7.
//  Copyright © 2017年 purang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (Sort)

/**************************** 数组排序 ****************************/

/**
 *  return 数字数组的升序
 */
- (NSArray *)sortedNumberArrayOrderedAscending;

/**
 *  return 数字数组的降序
 */
- (NSArray *)sortedNumberArrayOrderedDescending;

/**
 *  return 对象数组的升序
 */
- (NSArray *)sortedObjectArrayOrderedAscending;

/**
 *  return 对象数组的降序
 */
- (NSArray *)sortedObjectArrayOrderedDescending;

/**
 *  return 字典数组的升序（根据key值排序）
 */
- (NSArray *)sortedDictionaryArrayOrderedAscending;

/**
 *  return 字典数组的降序（根据key值排序）
 */
- (NSArray *)sortedDictionaryArrayOrderedDescending;

/**
 *  return 模型数组的排序
 *  Des    [NSSortDescriptor sortDescriptorWithKey:@"key" ascending:YES];
 *         按数组【0】key值排序，再按sort数组地址指针顺序排序
 */
- (NSArray *)sortedModelArrayOrderedDescriptors:(NSArray<NSSortDescriptor *> *)sortDescriptors;



/**************************** 数组最值 ****************************/

/**
 *  最大值
 *
 *  @return 最大NSString
 */
- (NSString *)getMaxValueFromNumberArray;

/**
 *  最小值
 *
 *  @return 最小NSString
 */
- (NSString *)getMinValueFromNumberArray;

@end
