//
//  NSArray+Sort.m
//  XWEncapsulation
//
//  Created by wangxiangwei on 17/2/7.
//  Copyright © 2017年 purang. All rights reserved.
//

#import "NSArray+Sort.h"

@implementation NSArray (Sort)

- (NSArray *)sortedNumberArrayOrderedAscending{
    NSComparator sort = ^(id string1,id string2){
        if ([string1 floatValue] > [string2 floatValue]) {
            return (NSComparisonResult)NSOrderedDescending;
        }else if ([string1 floatValue] < [string2 floatValue]){
            return (NSComparisonResult)NSOrderedAscending;
        }
        else
            return (NSComparisonResult)NSOrderedSame;
    };
    return [self sortedArrayUsingComparator:sort];
}

- (NSArray *)sortedNumberArrayOrderedDescending{
    NSArray *asc = [self sortedNumberArrayOrderedAscending];
    return  [[asc reverseObjectEnumerator] allObjects];
}

- (NSArray *)sortedObjectArrayOrderedAscending{
    NSStringCompareOptions comparisonOptions = NSCaseInsensitiveSearch|NSNumericSearch|NSWidthInsensitiveSearch|NSForcedOrderingSearch;
    NSComparator sort = ^(NSString *obj1,NSString *obj2){
        NSRange range = NSMakeRange(0,obj1.length);
        return [obj1 compare:obj2 options:comparisonOptions range:range];
    };
    return [self sortedArrayUsingComparator:sort];
}

- (NSArray *)sortedObjectArrayOrderedDescending{
    NSArray *asc = [self sortedObjectArrayOrderedAscending];
    return [[asc reverseObjectEnumerator] allObjects];
}

- (NSArray *)sortedDictionaryArrayOrderedAscending{
    NSComparator sort = ^NSComparisonResult(id obj1,id obj2){
        NSNumber *number1 = [[obj1 allKeys] objectAtIndex:0];
        NSNumber *number2 = [[obj2 allKeys] objectAtIndex:0];
        NSComparisonResult result = [number1 compare:number2];
        return result == NSOrderedDescending;
    };
    return [self sortedArrayUsingComparator:sort];
}

- (NSArray *)sortedDictionaryArrayOrderedDescending{
    NSArray *asc = [self sortedDictionaryArrayOrderedDescending];
    return [[asc reverseObjectEnumerator] allObjects];
}

- (NSArray *)sortedModelArrayOrderedDescriptors:(NSArray<NSSortDescriptor *> *)sortDescriptors{
    return [self sortedArrayUsingDescriptors:sortDescriptors];
}

- (NSString *)getMaxValueFromNumberArray{
    /** 方法一 */
    return [NSString stringWithFormat:@"%@",[[self sortedNumberArrayOrderedAscending] lastObject]];
    
    /** 方法二  方法一运算速度大于方法二 */
    //    return [self valueForKeyPath:@"@max.floatValue"];
}

- (NSString *)getMinValueFromNumberArray{
    /** 方法一 */
    return [NSString stringWithFormat:@"%@",[[self sortedNumberArrayOrderedAscending] firstObject]];
    
    /** 方法二  方法一运算速度大于方法二 */
    //    return [self valueForKeyPath:@"@min.floatValue"];
}

@end
