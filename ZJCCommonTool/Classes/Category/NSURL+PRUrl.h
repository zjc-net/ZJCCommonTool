//
//  NSURL+PRUrl.h
//  BrightSunnySky
//
//  Created by wangyilu on 2017/4/26.
//  Copyright © 2017年 PURANG. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSURL (PRUrl)

-(NSString *)parameterForKey:(NSString *)key;
-(NSDictionary *)parameters;

@end
