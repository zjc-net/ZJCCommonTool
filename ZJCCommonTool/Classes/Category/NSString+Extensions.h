//
//  NSString+Extensions.h
//  PurangFinanceVillage-Bank
//
//  Created by wangyilu on 16/1/27.
//  Copyright © 2016年 ___PURANG___. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Extensions)

- (BOOL)checkPhoneNumInput;
- (BOOL)checkEmailInput;
- (BOOL)checkIdentityCard;
- (BOOL)isBlankString;

- (NSString*)changeToCurrencyString;

- (NSString *)md5;

- (NSDictionary *)json_StringToDictionary;

+ (NSString *)convertArrayToString:(NSArray *)array;
@end
