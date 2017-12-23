//
//  APIProxy.m
//  BaseFrameWork
//
//  Created by Eleven on 2017/12/11.
//  Copyright © 2017年 Eleven. All rights reserved.
//

#import "APIProxy.h"
#import "NetWorkConfiguration.h"
#import "AFNetworking.h"
#import "NSArray+SFNetworkingMethods.h"
#import "NSDictionary+SFNetworkingMethods.h"
#import "NSString+SFNetworkingMethods.h"

#define TYPESECURITYCHECK(x,y) x&&((NSNull *)x!=[NSNull null])&&[x isKindOfClass:y]

@implementation APIProxy

+ (instancetype)shareInstance{
    static dispatch_once_t onceToken;
    static APIProxy *sharedInstance = nil;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[APIProxy alloc] init];
    });
    return sharedInstance;
}
#pragma mark  基本框架 Get 请求
- (NSURLSessionDataTask *)getRequestWithUrl:(NSString *)urlString params:(NSDictionary *)params responseBlock:(Callback)responseBlock{
    Callback responseBlockCopy = responseBlock;

    NSMutableDictionary *paramDic = [[NSMutableDictionary alloc] initWithDictionary:params];
    NSURL *url = [NSURL URLWithString:urlString];

    // 请求管理者
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", @"text/plain", nil];

    AFJSONRequestSerializer *requestSerializer = [AFJSONRequestSerializer serializer];
    requestSerializer.timeoutInterval = KSFNetworkingTimeoutSeconds;
    manager.requestSerializer = requestSerializer;

    if ([urlString hasPrefix:@"https://"]) {
        manager.securityPolicy = [self customSecurityPolicy];
    }

    __block UIApplication *weekApp = [UIApplication sharedApplication];
    weekApp.networkActivityIndicatorVisible = YES;

    NSURLSessionDataTask *task = [manager GET:url.absoluteString parameters:paramDic progress:^(NSProgress * _Nonnull downloadProgress) {

    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dicResponse = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"asssf %@", dicResponse);
        responseBlockCopy(dicResponse, EnumURLResponseStatusSuccess);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {

    }];
    return task;

}

#pragma mark 基本框架Post请求
- (NSURLSessionDataTask *)postRequestWithUrl:(NSString *)urlString params:(NSDictionary *)params serversigns:(BOOL)isSign responseBlock:(Callback)responseBlock{

    Callback responseBlockCopy = responseBlock;

    NSMutableDictionary *paramDic = [[NSMutableDictionary alloc] initWithDictionary:params];
    // 是否需要业务签名
    if (isSign) {
        // 签名业务参数
        NSMutableArray *signArray = [[NSMutableArray alloc] initWithArray:[params SF_transformedUrlParamsArraySignature:YES]];
        [signArray addObject:[NSString stringWithFormat:@"app_secret=%@",@""]];
        // 生成签名
        NSString *sign = [[signArray SF_paramsString] SF_md5];
        // 请求参数拼接签名
        [paramDic setValue:sign forKey:@"sign"];
    }

    NSURL *url = [NSURL URLWithString:urlString];

    // 请求管理者
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", @"text/plain", nil];

    AFJSONRequestSerializer *requestSerializer = [AFJSONRequestSerializer serializer];
    requestSerializer.timeoutInterval = KSFNetworkingTimeoutSeconds;
    manager.requestSerializer = requestSerializer;

    if ([urlString hasPrefix:@"https://"]) {
        manager.securityPolicy = [self customSecurityPolicy];
    }

    __block UIApplication *weekApp = [UIApplication sharedApplication];
    weekApp.networkActivityIndicatorVisible = YES;

    NSURLSessionDataTask *task = [manager POST:url.absoluteString parameters:paramDic progress:^(NSProgress * _Nonnull uploadProgress) {

    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        weekApp.networkActivityIndicatorVisible = NO;

        if (!TYPESECURITYCHECK(responseObject, [NSData class])) {
            NSLog(@"数据格式不正确");
            responseBlockCopy(nil, EnumURLResponseStatusErrorFormatError);
            return;
        }

        NSDictionary *dicResponse = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        responseBlockCopy(dicResponse, EnumURLResponseStatusSuccess);

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        weekApp.networkActivityIndicatorVisible = NO;
        NSLog(@"请求失败:%@", error.localizedDescription);
        // 1.未能连接到服务器 2.似乎已断开与互联网的链接 3. 请求超时 4. 请求取消
        if ([error.localizedDescription rangeOfString:@"已取消"].length != 0 || [error.localizedDescription rangeOfString:@"cancel"].length != 0) {
            responseBlockCopy(nil, EnumURLResponseStatusErrorCancell);
        }else if ([error.localizedDescription rangeOfString:@"请求超时"].length != 0 || [error.localizedDescription rangeOfString:@"time out"].length != 0){
            responseBlockCopy(nil, EnumURLResponseStatusErrorTimeout);
        }else if ([error.localizedDescription rangeOfString:@"未能连接到服务器"].length != 0 || [error.localizedDescription rangeOfString:@"hostname could not be found"].length != 0){
            responseBlockCopy(nil, EnumURLResponseStatusErrorNoConnect);
        }else{
            responseBlockCopy(nil, EnumURLResponseStatusErrorNoNetwork);
        }
    }];
    return task;

}

#pragma mark -- 上传文件信息到服务端
- (NSURLSessionDataTask *)postRequestWithUrl:(NSString *)urlString params:(NSDictionary *)params uploadInfo:(NSArray *)uploadInfo responseBlock:(Callback)responseBlock loadType:(UpLoadType)loadType{
    Callback responseBlockCopy = responseBlock;
    // 签名业务参数
    NSMutableArray *signArray = [[NSMutableArray alloc] initWithArray:[params SF_transformedUrlParamsArraySignature:YES]];
    [signArray addObject:[NSString stringWithFormat:@"app_secret=%@",@""]];

    // 生成签名
    NSString *sign = [[signArray SF_paramsString] SF_md5];
    // 请求参数拼接签名
    NSMutableDictionary *paramDic = [[NSMutableDictionary alloc] initWithDictionary:params];
    [paramDic setObject:sign forKey:@"sign"];

    NSURL *url = [NSURL URLWithString:urlString];

    // 请求管理者
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];

    manager.requestSerializer.timeoutInterval = KSFNetworkingTimeoutSeconds;

    if ([urlString hasPrefix:@"https://"]) {
        manager.securityPolicy = [self customSecurityPolicy];
    }

    __block UIApplication *weekApp = [UIApplication sharedApplication];
    weekApp.networkActivityIndicatorVisible = YES;

    NSURLSessionDataTask *task = [manager POST:url.absoluteString parameters:paramDic constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        if (TYPESECURITYCHECK(uploadInfo, [NSArray class]) && uploadInfo.count > 0) {
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            formatter.dateFormat = @"yyyyMMddHHmmss";

            if (loadType == EnumURLImageType) {
                for (NSData *imageData in uploadInfo) {
                    NSString *str = [formatter stringFromDate:[NSDate date]];
                    NSString *fileName = [NSString stringWithFormat:@"%@.jpg", str];

                    // 上传的参数(上传图片, 以文件流的格式)
                    [formData appendPartWithFileData:imageData name:@"images" fileName:fileName mimeType:@"image/jpeg"];
                }
            }else if (loadType == EnumURLLogType){
                // 上传日志文件
                for (NSDictionary *dic in uploadInfo) {
                    NSData *logData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:nil];
                    NSString *str = [formatter stringFromDate:[NSDate date]];
                    NSString *fileName = [NSString stringWithFormat:@"%@.txt", str];
                    // 上传log
                    [formData appendPartWithFileData:logData name:@"crashLogs" fileName:fileName mimeType:@"text/plain"];
                }
            }
        }else{
            [formData appendPartWithFileData:[NSData data] name:@"images" fileName:@"" mimeType:@"application/octet-stream"];
        }
    } progress:^(NSProgress * _Nonnull uploadProgress) {

    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {

    }];
    return task;
}

#pragma mark --配置证书
- (AFSecurityPolicy *)customSecurityPolicy{
    // 先导入证书
    NSString *cerPath = [[NSBundle mainBundle] pathForResource:@"serverdevelop" ofType:@"cer"];
    if (EnumSFAppEnviromentProduction) {
        cerPath = [[NSBundle mainBundle] pathForResource:@"severProduction" ofType:@"cer"];
    }
    NSData *cerData = [NSData dataWithContentsOfFile:cerPath];
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy defaultPolicy];

    // 如果是需要验证自建证书, 需要设置为YES
    securityPolicy.allowInvalidCertificates = YES;
    securityPolicy.validatesDomainName = NO;

    // 若需要规避证书 注释下面一句代码 即可
//    securityPolicy.pinnedCertificates = [NSSet setWithArray:@[cerData]];

    return securityPolicy;
}

#pragma mark -- 取消网络任务
- (void)cancelRequestWithTask:(NSURLSessionDataTask *)task{
    TYPESECURITYCHECK(task, [NSURLSessionDataTask class]);

    if (task.state != NSURLSessionTaskStateCompleted) {
        [task cancel];
        NSLog(@"request clearDelegatesAndCancel\n");
    }else{
        NSLog(@"request has finished\n");
    }

}

@end





