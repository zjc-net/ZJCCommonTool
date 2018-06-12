//
//  PRBaseRequest.h
//  PurangFinanceVillage
//
//  Created by zhoujunchun on 2018/6/8.
//  Copyright © 2018年 ___PURANG___. All rights reserved.
//

#import "YTKRequest.h"
#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger ,PRRequestStatus) {
    /*来自服务器定义*/
    //正常
   PRRequestStatusSuccess                   = 200,
   PRRequestStatusLoginUserNotFound         = 404,
   PRRequestStatusLoginUserPasswordNotRight = 501,
   PRRequestStatusLoginInOtherDevice        = 409,     //账号在其他设备登录90004
    
    /*本地定义*/
    //网络失败
   PRRequestStatusFailure,
   PRRequestStatusAccessTokenExpired = 401//失效
};
//使用此类时,ZLRequestBlock始终被传递
typedef void (^PRRequestBlock)(PRRequestStatus requestStatus, NSString *message, id responseObject);
@interface PRBaseRequest : YTKRequest
/// (封装层) 发起请求, 返回自定义对象时需要子类调用
// 子类可重写该方法, 实现对参数的逻辑判断
// 只要调用本方法, requestBlock必须传递
- (void)startRequest:(PRRequestBlock)requestBlock;

/// (封装层) 解析, 根据statusCode解析message
// 默认返回@""
// 因为服务器返回的是英文信息, 客户端需要转成中文
- (NSString *)formatMessage:(PRRequestStatus)statusCode;

/// (封装层) 解析，把服务器返回数据转换想要的数据
//默认返回原 data
//通常解析body内数据
- (id)formatResponseObject:(id)responseObject;
- (void)printResponseData;
- (void)handleSuccess:(PRRequestBlock)requestBlock
responseObject:(id)responseObject
responseHeaders:(NSDictionary *)responseHeaders;
- (void)handleFailure:(PRRequestBlock)requestBlock error:(NSError *)error responseHeaders:(NSDictionary *)responseHeaders;
@property (nonatomic ,copy)NSString *urlStr;
@property (nonatomic, strong)NSDictionary *dic;

-(instancetype)initWithURL:(NSString *)URLStr dic:(NSDictionary *)dic;


@end
