//
//  PRBaseRequest.m
//  PurangFinanceVillage
//
//  Created by zhoujunchun on 2018/6/8.
//  Copyright © 2018年 ___PURANG___. All rights reserved.
//

#import "PRBaseRequest.h"
#import "YTKNetworkAgent.h"

#import "Header.h"
#import "Utils.h"
#import "PFVDictionaryMgr.h"

@implementation PRBaseRequest
#pragma mark - override Getters
-(instancetype)initWithURL:(NSString *)URLStr dic:(NSDictionary *)dic{
    self = [super init];
    if (self) {
        _urlStr = URLStr;
        _dic = [NSDictionary dictionaryWithDictionary:dic];
    }
    return self;
}

- (NSDictionary *)requestHeaderFieldValueDictionary{
    NSString *app_Version = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    NSString *token = IsEmpty([Utils getToken])?@"":[Utils getToken];
    NSDictionary *dicts = @{@"mobileModel":@"ios",@"mobileVersion":app_Version,@"token":token};
    return dicts;
}

- (NSTimeInterval)requestTimeoutInterval{
    return 15;
}

- (YTKRequestMethod)requestMethod{
    return YTKRequestMethodPOST;
}

- (YTKRequestSerializerType)requestSerializerType{
    return YTKRequestSerializerTypeHTTP;
}

- (NSString *)formatMessage:(PRRequestStatus)statusCode{
    return @"";
}

/// (封装层) 解析，把服务器返回数据转换想要的数据
//默认返回原 data
//通常解析body内数据
- (id)formatResponseObject:(id)responseObject{
    return responseObject;
}

#pragma mark - override Methods
-(NSString *)requestUrl{
    return self.urlStr;
}

- (id)requestArgument{
    return self.dic;
}

- (void)startRequest:(PRRequestBlock)PRRequestBlock{
    NSLog(@"\n%@\n%@\n",[[YTKNetworkAgent sharedAgent] buildRequestUrl:self],self.requestArgument);
    
    [self startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
        
        NSData *jsonData = [request.responseString dataUsingEncoding:NSUTF8StringEncoding];
        NSError *err;
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                            options:NSJSONReadingMutableContainers
                                                              error:&err];
        
        [self handleSuccess:PRRequestBlock
             responseObject:dic
            responseHeaders:request.responseHeaders];
        
    } failure:^(YTKBaseRequest *request) {
        
        [self handleFailure:PRRequestBlock
                      error:request.error
            responseHeaders:request.responseHeaders];
    }];
}

- (void)handleSuccess:(PRRequestBlock)requestBlock
       responseObject:(id)responseObject
      responseHeaders:(NSDictionary *)responseHeaders{
    
    
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self printResponseData];
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            
            PRRequestStatus status = [responseObject[@"responseCode"] integerValue];
            
            // 返回错误时, 需要解析message。服务器返回的错误没有用, 因为客户端需要显示中文。
            NSString *message = @"";
            NSString* success = responseObject[@"success"];
            if ([success boolValue] == YES ) {
                status = PRRequestStatusSuccess;
            }
            if ( [[NSString stringWithFormat:@"%@",success] isEqualToString:@"true"]) {
                status = PRRequestStatusSuccess;
            }

            if (!IsEmpty(responseObject[@"message"])) {
                message = responseObject[@"message"];
            }else if (!IsEmpty(responseObject[@"errorMsg"])){
                message = responseObject[@"errorMsg"];
            }else if (!IsEmpty(responseObject[@"errorMessage"])){
                message = responseObject[@"errorMessage"];
            }else{
                message = [PFVDictionaryMgr getErrorMessageByResponseCode:status];
            }
            if ([responseObject[@"data"] isKindOfClass:[NSDictionary class]]||[responseObject[@"data"] isMemberOfClass:[NSDictionary class]]) {
                if(!IsEmpty(responseObject[@"data"][@"errorMessage"])){
                    message = responseObject[@"data"][@"errorMessage"];
                }
                else if(!IsEmpty(responseObject[@"data"][@"errorMsg"])){
                    message = responseObject[@"data"][@"errorMsg"];
                }
            }
            id object = [self formatResponseObject:responseObject];
            if (requestBlock) {
                requestBlock(status, message, object);
            }
        }
    });
}


- (void)handleFailure:(PRRequestBlock)requestBlock error:(NSError *)error responseHeaders:(NSDictionary *)responseHeaders{
    dispatch_async(dispatch_get_main_queue(), ^{
        if (requestBlock) {
            NSLog(@"\n error: \n %@", error);
            // 判断session是否过期
            
            if ([error.localizedDescription containsString:@"401"]){
                
               
            }
            else if ([error.localizedDescription containsString:@"409"]){
                
                
            }else{
                
                NSString *msg;
                switch (error.code) {
                    case -1000:
                    case -1002:
                        msg = @"系统异常，请稍后再试";
                        break;
                    case -1001:
                        msg = @"请求超时，请检查您的网络!";
                        break;
                    case -1005:
                    case -1006:
                    case -1009:
                        msg = @"网络异常，请检查您的网络!";
                        break;
                        
                    default:
                        msg = @"服务器异常，请稍候再试!";
                        break;
                }
                requestBlock(error.code, msg, nil);
            }
        }
    });
}


#pragma mark ----- private methods

- (void)printResponseData{
    NSData *jsonData;
    if (self.responseJSONObject) {
        jsonData = [NSJSONSerialization dataWithJSONObject:self.responseJSONObject options:NSJSONWritingPrettyPrinted error:nil];
    }
    
    NSString *jsonString;
    if (jsonData) {
        jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    }else {
        jsonString = self.responseString;
    }
    NSLog(@"\n%@\n%@",self.responseHeaders,jsonString);
}

@end
