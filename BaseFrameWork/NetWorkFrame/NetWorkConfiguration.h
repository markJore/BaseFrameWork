//
//  NetWorkConfiguration.h
//  BaseFrameWork
//
//  Created by Eleven on 2017/12/11.
//  Copyright © 2017年 Eleven. All rights reserved.
//

#ifndef NetWorkConfiguration_h
#define NetWorkConfiguration_h

#endif /* NetWorkConfiguration_h */

typedef NS_ENUM(NSUInteger, SFAppEnviromentOptions){
    EnumSFAppEnviromentDevelop = 0,
    EnumSFAppEnviromentTest,
    EnumSFAppEnviromentProduction,
};

/*! @brief app运行环境*/
static SFAppEnviromentOptions KAppEnviroment = EnumSFAppEnviromentTest;

static NSString *KSFNetworkAppkey = @"";

static NSString *KSFNetworkAppSecret = @"";

static NSString *KSFNetworkRequestUrlForDevelop = @"";

static NSString *KSFNetworkRequestForTest = @"";

static NSString *KSFNetworkRequestUrlForProduction = @"";

/*! @brief 网络连接超时时间*/
static NSTimeInterval KSFNetworkingTimeoutSeconds = 60.0f;

static NSString *SFKeychainServiceName = @"";

static NSString *SFUDIDName = @"";

static NSString *SFUUIDName = @"";

static NSString *SFPasteboardType = @"";

static BOOL kSFShouldCache = NO;

static NSTimeInterval KSFCacheOutdateTimeSeconds = 300;// 5分钟的cache过期时间

static NSUInteger kSFCacheCountLimit = 50; // 最多50条cache

