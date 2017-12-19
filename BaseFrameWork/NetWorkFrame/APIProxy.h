//
//  APIProxy.h
//  BaseFrameWork
//
//  Created by Eleven on 2017/12/11.
//  Copyright © 2017年 Eleven. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, URLResponseStatus){
    EnumURLResponseStatusSuccess, // 作为底层, 请求是否成功只考虑是否成功收到服务器反馈
    EnumURLResponseStatusErrorTimeout, // 未收到服务器反馈, 网络连接超时错误
    EnumURLResponseStatusErrorNoNetwork, // 无网络错误
    EnumURLResponseStatusErrorNoConnect, // 未能连接到服务器
    EnumURLResponseStatusErrorFormatError,// 数据请求格式错误
    EnumURLResponseStatusErrorCancell, // 请求取消
};

typedef NS_ENUM(NSUInteger, UpLoadType) {
    EnumURLImageType,
    EnumURLLogType,
    EnumURLOtherType,
};

typedef void (^Callback)(NSDictionary *resonseDic, URLResponseStatus status);

@interface APIProxy : NSObject

+ (instancetype)shareInstance;
/*! @brief 基本*/
- (NSURLSessionDataTask *)postRequestWithUrl:(NSString *)urlString
                                      params:(NSDictionary *)params
                                 serversigns:(BOOL)isSign
                               responseBlock:(Callback)responseBlock;
- (NSURLSessionDataTask *)getRequestWithUrl:(NSString *)urlString
                                     params:(NSDictionary *)params
                              responseBlock:(Callback)responseBlock;

/*! @brief 文件上传*/
- (NSURLSessionDataTask *)postRequestWithUrl:(NSString *)urlString
                                      params:(NSDictionary *)params
                                  uploadInfo:(NSArray *)uploadInfo
                               responseBlock:(Callback)responseBlock
                                    loadType:(UpLoadType)loadType;

/*! @brief 取消网络任务*/
- (void)cancelRequestWithTask:(NSURLSessionDataTask *)task;


@end

