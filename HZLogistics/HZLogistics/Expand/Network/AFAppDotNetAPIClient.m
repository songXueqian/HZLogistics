// AFAppDotNetAPIClient.h
//
// Copyright (c) 2012 Mattt Thompson (http://mattt.me/)
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

#import "AFAppDotNetAPIClient.h"
#import "Type.h"
#import "NetworkHelper.h"
#import "Reachability.h"
#import "FileManagerHelper.h"
#import "JSONHelper.h"

#import "NSString+MD5.h"

#define RetKeyStatus @"status"
#define RetKeyDescri @"description"
#define RetKeyInfo   @"info"

@implementation AFAppDotNetAPIClient

+ (instancetype)sharedClient {
    
    static AFAppDotNetAPIClient *_sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedClient = [[AFAppDotNetAPIClient alloc] initWithBaseURL:[NSURL URLWithString:@""]];
        _sharedClient.protalurl = @"";
    });
    
    return _sharedClient;
}

#pragma -mark api

-(void)portal:(void (^)(id result_data, ApiStatus result_status))result {
    
    if ([_protalurl isEqualToString:@""])
    {
        //        [NetworkHelper isNetWorkReachable:^(AFNetworkReachabilityStatus result_ntwk_status) {
        //            if (AFNetworkReachabilityStatusNotReachable == result_ntwk_status)
        //            {
        //                result(nil,ApiStatusNetworkNotReachable);
        //            } else {
        
        //        Reachability *r = [Reachability reachabilityWithHostName:@"www.baidu.com"];
        //
        //        NetworkStatus status = [r currentReachabilityStatus];
        
        //        if (status == NotReachable) {
        //            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"不好意思" message:@"您的网络连接失败" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        //            [alertView show];
        //        }
        
        self.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/plain"];//设置相应内容类型
        self.requestSerializer = [AFHTTPRequestSerializer serializer];
        self.responseSerializer = [AFHTTPResponseSerializer serializer];
        [self GET:PortalURL parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
            id json = [[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
            if (json == nil || [json isEqualToString:@""] || [json isEqual:[NSNull null]] || ![json isKindOfClass:[NSString class]])
            {
                result(nil,ApiStatusFail);
            }
            else
            {
                _protalurl = json;
                result(_protalurl,ApiStatusSuccess);
            }
            
            
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
            result(error,ApiStatusError);
            
        }];
        
        
    }
    //        }];
    //    }
    else
    {
        result(_protalurl,ApiStatusSuccess);
    }
}

-(void)uploadFile:(NSString *)function Files:(NSArray *)files Dat:(id)dat Result:(void (^)(id result_data, ApiStatus result_status))result Progress:(void (^)(CGFloat progress))progress {
 
#if TARGET_TEST_SERVER
    
    NSLog(@"每个接口不同入参Dat ======= %@", dat);
#else
    
    
#endif
    
    NSMutableDictionary *datDic = [NSMutableDictionary dictionary];
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    
    
    //每个接口不同入参
    dic = [NSMutableDictionary dictionaryWithDictionary:dat];
    
    //每个接口必入参
    [dic setObject:@"Index" forKey:@"c"];
    [dic setObject:@"apis" forKey:@"m"];
    [dic setObject:ApiVersion forKey:ParametersKeyVer];
    [dic setObject:function forKey:ParametersKeyFun];


    //user_id 缓存没有，入 @"0"
    NSString *user_id = [[NSUserDefaults standardUserDefaults] objectForKey:@"user_id"];
    
    if (user_id == nil || [user_id isEqualToString:@""]) {
        [dic setObject:@"0" forKey:@"user_id"];
    }
    else {
        [dic setObject:user_id forKey:@"user_id"];
        
    }
    
    
    
    //转成字符串格式
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:nil];
    NSString *jsonStr = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
    [datDic setObject:jsonStr forKey:@"data"];
    
    NSLog(@"全部入参Dat ======= %@", datDic);
    
    [NetworkHelper isNetWorkReachable:^(AFNetworkReachabilityStatus result_ntwk_status) {
        if (AFNetworkReachabilityStatusNotReachable == result_ntwk_status)
        {
            NSDictionary *userInfo = [NSDictionary dictionaryWithObject:NSLocalizedString(@"Please check your network connection is correct", @"请检查您的网络连接是否正确") forKey:NSLocalizedDescriptionKey];
            NSError *error = [NSError errorWithDomain:JsonErrorDomain code:eJsonNil userInfo:userInfo];
            result(error,ApiStatusNetworkNotReachable);
        } else {
            
            [[AFAppDotNetAPIClient sharedClient] portal:^(id result_data, ApiStatus result_status) {
                NSString *portal = (NSString *)result_data;
                if (nil == portal)
                {
                    NSDictionary *userInfo = [NSDictionary dictionaryWithObject:NSLocalizedString(@"Please check your network connection is correct", @"请检查您的网络连接是否正确") forKey:NSLocalizedDescriptionKey];
                    NSError *error = [NSError errorWithDomain:JsonErrorDomain code:eJsonNil userInfo:userInfo];
                    result(error,ApiStatusNetworkNotReachable);
                }
                else
                {
                    
                    
                    [self POST:APIName parameters:datDic constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
                        
                        NSString *sti = APIName;
                        NSLog(@"APIName ========= %@", sti);
                        NSLog(@"datDic ========= %@", datDic);

                        
                        [files enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                            // NSDictionary *fileDic = (NSDictionary *)obj;
                            // NSString *defaultPath = [[NSBundle mainBundle] pathForResource:@"nodata" ofType:@"png"];
                            // NSString *name = [NetworkHelper makeModelValueWithKey:@"filename" Model:fileDic Null:@"nodata"];
                            // NSString *path = [NetworkHelper makeModelValueWithKey:@"filepath" Model:fileDic Null:defaultPath];
                            NSString *path = (NSString *)obj;
                            NSURL *filePathUrl = [NSURL fileURLWithPath:path];
                            [formData appendPartWithFileURL:filePathUrl name:[NSString stringWithFormat:@"photo%lu.png",(unsigned long)idx] error:nil];
                        }];
                        
                    }  progress:^(NSProgress * _Nonnull uploadProgress) {
                        
                    }  success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                        
                        NSError *error = nil;
                        id json = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:&error];
                        
                        NSDictionary *data = (NSDictionary *)json;
                        
                        NSInteger status = [[NetworkHelper makeModelValueWithKey:ParametersKeyRet Model:json Null:@"0"] integerValue];
                        if (error!=nil)
                        {
                            result(error,ApiStatusError);
                        }
                        else if (json==nil)
                        {
                            NSDictionary *userInfo = [NSDictionary dictionaryWithObject:NSLocalizedString(@"Data analysis failed", @"数据解析失败") forKey:NSLocalizedDescriptionKey];
                            error = [NSError errorWithDomain:JsonErrorDomain code:eJsonNil userInfo:userInfo];
                            result(error,ApiStatusError);
                        }
                        else if ([json isEqual:[NSNull null]])
                        {
                            NSDictionary *userInfo = [NSDictionary dictionaryWithObject:NSLocalizedString(@"Data analysis failed", @"数据解析失败") forKey:NSLocalizedDescriptionKey];
                            error = [NSError errorWithDomain:JsonErrorDomain code:eJsonNil userInfo:userInfo];
                            result(error,ApiStatusError);
                        }
                        else if (![json isKindOfClass:[NSDictionary class]])
                        {
                            NSDictionary *userInfo = [NSDictionary dictionaryWithObject:NSLocalizedString(@"Data analysis failed", @"数据解析失败") forKey:NSLocalizedDescriptionKey];
                            error = [NSError errorWithDomain:JsonErrorDomain code:eJsonNil userInfo:userInfo];
                            result(error,ApiStatusError);
                        }
                        else
                        {
                            if (1 == status) {
                                NSMutableArray *modelArr = [NSMutableArray arrayWithCapacity:0];
                                @try {
                                    id Data = [NetworkHelper makeModelValueWithKey:ParametersKeyDat Model:json Null:@[]];
                                    ApiEnum api = ApiEnumNone;
                                    //                                    NSString *orderMsg=@"";
                                    
                                    if ([function isEqualToString:ApiNameUploadAvatar]){
                                        api = ApiEnumUploadAvatar;
                                    } else if ([function isEqualToString:ApiNameUploadListenPhoto]) {
                                        api = ApiEnumUploadListenPhoto;
                                    } else {
                                        
                                    }
                                    
                                    [Data enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                                        
                                        NSDictionary *modelDic = (NSDictionary *)obj;
                                        
#if TARGET_TEST_SERVER
                                        
                                        NSLog(@"返参=========%@", modelDic);
#else
                                        
#endif
                                        id modelObject = [JSONHelper jsonToModel:modelDic Api:api Idx:idx ImageURL:APIImageName];
                                        if (modelObject==nil) {
                                            *stop = YES;
                                        }
                                        else {
                                            if ([modelObject isKindOfClass:[NSArray class]]) {
                                                [modelArr addObjectsFromArray:modelObject];
                                            } else {
                                                
                                                
                                                [modelArr addObject:modelObject];
                                            }
                                        }
                                    }];
                                }
                                @catch (NSException *exception) {
                                    NSDictionary *userInfo = [NSDictionary dictionaryWithObject:exception.description forKey:NSLocalizedDescriptionKey];
                                    error = [NSError errorWithDomain:JsonErrorDomain code:eJsonNil userInfo:userInfo];
                                    result(error,ApiStatusException);
                                }
                                @finally {
                                    if (modelArr!=nil) {
                                        result(modelArr,ApiStatusSuccess);
                                    }
                                    else {
                                        NSDictionary *userInfo = [NSDictionary dictionaryWithObject:NSLocalizedString(@"Data analysis failed", @"数据解析失败") forKey:NSLocalizedDescriptionKey];
                                        error = [NSError errorWithDomain:JsonErrorDomain code:eJsonNil userInfo:userInfo];
                                        result(error,ApiStatusError);
                                    }
                                    
                                }
                                
                            } else {
                                NSString *apiExceptionMessage = [NetworkHelper makeModelValueWithKey:ParametersKeyMsg Model:[data objectForKey:@"status"] Null:@""];
                                NSDictionary *userInfo = [NSDictionary dictionaryWithObject:apiExceptionMessage forKey:NSLocalizedDescriptionKey];
                                error = [NSError errorWithDomain:JsonErrorDomain code:eJsonNil userInfo:userInfo];
                                result(error,ApiStatusFail);
                            }
                        }
                        //result(responseObject,ApiStatusSuccess);
                        
                    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                        
                        result(error,ApiStatusError);
                        
                    }];
                    
                }
            }];
        }
    }];
}

-(void)downloadFile:(NSString *)function Dat:(id)dat FileName:(NSString *)filename Result:(void (^)(id result_data, ApiStatus result_status))result Progress:(void (^)(CGFloat progress))progress {
    
    [NetworkHelper isNetWorkReachable:^(AFNetworkReachabilityStatus result_ntwk_status) {
        if (AFNetworkReachabilityStatusNotReachable == result_ntwk_status)
        {
            NSDictionary *userInfo = [NSDictionary dictionaryWithObject:NSLocalizedString(@"Please check your network connection is correct", @"请检查您的网络连接是否正确") forKey:NSLocalizedDescriptionKey];
            NSError *error = [NSError errorWithDomain:JsonErrorDomain code:eJsonNil userInfo:userInfo];
            result(error,ApiStatusNetworkNotReachable);
        } else {
            
            [[AFAppDotNetAPIClient sharedClient] portal:^(id result_data, ApiStatus result_status) {
                NSString *portal = (NSString *)result_data;
                if (nil == portal)
                {
                    NSDictionary *userInfo = [NSDictionary dictionaryWithObject:NSLocalizedString(@"Please check your network connection is correct", @"请检查您的网络连接是否正确") forKey:NSLocalizedDescriptionKey];
                    NSError *error = [NSError errorWithDomain:JsonErrorDomain code:eJsonNil userInfo:userInfo];
                    result(error,ApiStatusNetworkNotReachable);
                }
                else
                {
                    NSURLSessionDataTask *operation = [self GET:APIName parameters:@{ParametersKeyFun: function,ParametersKeyVer: ApiVersion,ParametersKeyDat: dat} progress:^(NSProgress * _Nonnull downloadProgress) {
                        
                        
                        
                    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                        
                        NSError *error = nil;
                        id json = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:&error];
                        NSInteger status = [[NetworkHelper makeModelValueWithKey:ParametersKeyRet Model:json Null:@"0"] integerValue];
                        if (error!=nil)
                        {
                            result(error,ApiStatusError);
                        }
                        else if (json==nil)
                        {
                            NSDictionary *userInfo = [NSDictionary dictionaryWithObject:NSLocalizedString(@"Data analysis failed", @"数据解析失败") forKey:NSLocalizedDescriptionKey];
                            error = [NSError errorWithDomain:JsonErrorDomain code:eJsonNil userInfo:userInfo];
                            result(error,ApiStatusError);
                        }
                        else if ([json isEqual:[NSNull null]])
                        {
                            NSDictionary *userInfo = [NSDictionary dictionaryWithObject:NSLocalizedString(@"Data analysis failed", @"数据解析失败") forKey:NSLocalizedDescriptionKey];
                            error = [NSError errorWithDomain:JsonErrorDomain code:eJsonNil userInfo:userInfo];
                            result(error,ApiStatusError);
                        }
                        else if (![json isKindOfClass:[NSArray class]])
                        {
                            NSDictionary *userInfo = [NSDictionary dictionaryWithObject:NSLocalizedString(@"Data analysis failed", @"数据解析失败") forKey:NSLocalizedDescriptionKey];
                            error = [NSError errorWithDomain:JsonErrorDomain code:eJsonNil userInfo:userInfo];
                            result(error,ApiStatusError);
                        }
                        else
                        {
                            if (1 == status) {
                                result(nil,ApiStatusSuccess);
                            } else {
                                NSString *apiExceptionMessage = [NetworkHelper makeModelValueWithKey:ParametersKeyMsg Model:json Null:@""];
                                result(apiExceptionMessage,ApiStatusFail);
                            }
                        }
                        result(responseObject,ApiStatusSuccess);
                        
                        
                    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                        
                        result(error,ApiStatusError);
                        
                    }];
                    
                    [operation resume];
                    
                    // 指定文件保存路径，将文件保存在沙盒中
                    [FileManagerHelper CreatFilePath:DownloadPath];
                    NSString *path = [NSString stringWithFormat:@"%@/%@/%@",pathDocuments,DownloadPath,filename];
                    [NSOutputStream outputStreamToFileAtPath:path append:NO];
                }
            }];
        }
    }];
}


- (void)apiPost:(NSString *)function Dat:(id)dat Result:(void (^)(id result_data, ApiStatus result_status, NSString *api))result {
#if TARGET_TEST_SERVER
    
    NSLog(@"每个接口不同入参Dat ======= %@", dat);
#else
    
    
#endif
    
    NSMutableDictionary *datDic = [NSMutableDictionary dictionary];
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    
    //每个接口不同入参
    dic = [NSMutableDictionary dictionaryWithDictionary:dat];
    //每个接口必入参
    [dic setObject:@"Index" forKey:@"c"];
    [dic setObject:@"apis" forKey:@"m"];
    [dic setObject:ApiVersion forKey:ParametersKeyVer];
    [dic setObject:function forKey:ParametersKeyFun];
    //user_id 缓存没有，入 @"0"
    NSString *user_id = [[NSUserDefaults standardUserDefaults] objectForKey:@"user_id"];
    
    if (user_id == nil || [user_id isEqualToString:@""]) {
        [dic setObject:@"0" forKey:@"user_id"];
    }
    else {
        [dic setObject:user_id forKey:@"user_id"];

    }
    
    NSLog(@"全部入参Dat ======= %@", dic);

    //转成字符串格式
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:nil];
    //生成的json数据格式化输出
    NSString *jsonStr = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
    [datDic setObject:jsonStr forKey:@"data"];
    

    [[AFAppDotNetAPIClient sharedClient] portal:^(id result_data, ApiStatus result_status) {
        
        NSString *portal = (NSString *)result_data;
        
        if (nil == portal)
        {
            NSDictionary *userInfo = [NSDictionary dictionaryWithObject:NSLocalizedString(@"Please check your network connection is correct", @"请检查您的网络连接是否正确") forKey:NSLocalizedDescriptionKey];
            NSError *error = [NSError errorWithDomain:JsonErrorDomain code:eJsonNil userInfo:userInfo];
            result(error,ApiStatusNetworkNotReachable,function);
        }
        else
        {
            [self POST:APIName parameters:datDic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                
                NSString *sti = APIName;
                NSLog(@"APIName ========= %@", sti);
                NSLog(@"datDic ========= %@", datDic);

                NSError *error = nil;
                

                id json = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:&error];
                
                NSInteger status = [[NetworkHelper makeModelValueWithKey:ParametersKeyRet Model:json Null:@"0"] integerValue];
                
                if (error!=nil)
                {
                    result(error,ApiStatusError,function);
                }
                else if (json==nil)
                {
                    NSDictionary *userInfo = [NSDictionary dictionaryWithObject:NSLocalizedString(@"Data analysis failed", @"数据解析失败") forKey:NSLocalizedDescriptionKey];
                    error = [NSError errorWithDomain:JsonErrorDomain code:eJsonNil userInfo:userInfo];
                    result(error,ApiStatusError,function);
                }
                else if ([json isEqual:[NSNull null]])
                {
                    NSDictionary *userInfo = [NSDictionary dictionaryWithObject:NSLocalizedString(@"Data analysis failed", @"数据解析失败") forKey:NSLocalizedDescriptionKey];
                    error = [NSError errorWithDomain:JsonErrorDomain code:eJsonNil userInfo:userInfo];
                    result(error,ApiStatusError,function);
                }
                else if (![json isKindOfClass:[NSDictionary class]])
                {
                    NSDictionary *userInfo = [NSDictionary dictionaryWithObject:NSLocalizedString(@"Data analysis failed", @"数据解析失败") forKey:NSLocalizedDescriptionKey];
                    error = [NSError errorWithDomain:JsonErrorDomain code:eJsonNil userInfo:userInfo];
                    result(error,ApiStatusError,function);
                }
                else
                {
                    if (1 == status) {
                        NSMutableArray *modelArr = [NSMutableArray arrayWithCapacity:0];
                        @try {
                            NSArray *Data = [NetworkHelper makeModelValueWithKey:ParametersKeyDat Model:json Null:@[]];
                            ApiEnum api = ApiEnumNone;
                            //                                    NSString *orderMsg=@"";
                            
                            
                            
                            if ([function isEqualToString:ApiNameRegistUser]) {
                                api = ApiEnumRegistUser;
                            } else if ([function isEqualToString:ApiNameGetBackPwd]) {
                                api = ApiEnumGetBackPwd;
                            } else if ([function isEqualToString:ApiNameLogin]) {
                                api = ApiEnumLogin;
                            } else if ([function isEqualToString:ApiNameGetUserInfo]) {
                                api = ApiEnumGetUserInfo;
                            } else if ([function isEqualToString:ApiNameGetSysMsgList]) {
                                api = ApiEnumSysMsgList;
                            } else if ([function isEqualToString:ApiNameGetSysMsgInfo]) {
                                api = ApiEnumGetSysMsgInfo;
                            } else if ([function isEqualToString:ApiNameDeleteMsg]) {
                                api = ApiEnumDeleteMsg;
                            } else if ([function isEqualToString:ApiNameUploadListenPhoto]) {
                                api = ApiEnumUploadListenPhoto;
                            } else if ([function isEqualToString:ApiNameCreateNewCompany]) {
                                api = ApiEnumCreateNewCompany;
                            } else if ([function isEqualToString:ApiNameGetCompanyInfo]) {
                                api = ApiEnumGetCompanyInfo;
                            } else if ([function isEqualToString:ApiNameGetPortsList]) {
                                api = ApiEnumPortsList;
                            } else if ([function isEqualToString:ApiNamePayTypeList]) {
                                api = ApiEnumPayTypeList;
                            } else if ([function isEqualToString:ApiNameSubOrder]) {
                                api = ApiEnumSubOrder;
                            } else if ([function isEqualToString:ApiNameGetOrdersList]) {
                                api = ApiEnumGetOrdersList;
                            } else if ([function isEqualToString:ApiNameGetOrderInfo]) {
                                api = ApiEnumGetOrderInfo;
                            } else if ([function isEqualToString:ApiNameOrderComplete]) {
                                api = ApiEnumorderComplete;
                            } else if ([function isEqualToString:ApiNameoOrderStatusList]) {
                                api = ApiEnumOrderStatusList;
                            } else if ([function isEqualToString:ApiNameOrderSelects]) {
                                api = ApiEnumOrderSelects;
                            } else if ([function isEqualToString:ApiNameSaveChannelId]) {
                                api = ApiEnumSaveChannelId;

                            }

                            
                            
                            
                            else {
                                api = ApiEnumNone;
                            }
                            
                            
                            [Data enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                                
                                NSDictionary *modelDic = (NSDictionary *)obj;
                                
#if TARGET_TEST_SERVER
                                
                                NSLog(@"%@", modelDic);
#else
                                
#endif
                                id modelObject = [JSONHelper jsonToModel:modelDic Api:api Idx:idx ImageURL:APIImageName];
                                
                                if (modelObject==nil) {
                                    *stop = YES;
                                }
                                else {
                                    if ([modelObject isKindOfClass:[NSArray class]]) {
                                        [modelArr addObjectsFromArray:modelObject];
                                    } else {
                                        
                                        
                                        [modelArr addObject:modelObject];
                                    }
                                }
                            }];
                            
                            
                        }
                        
                        @catch (NSException *exception) {
                            NSDictionary *userInfo = [NSDictionary dictionaryWithObject:exception.description forKey:NSLocalizedDescriptionKey];
                            error = [NSError errorWithDomain:JsonErrorDomain code:eJsonNil userInfo:userInfo];
                            result(error,ApiStatusException,function);
                        }
                        
                        @finally {
                            if (modelArr!=nil) {
                                result(modelArr,ApiStatusSuccess,function);
                            }
                            else {
                                NSDictionary *userInfo = [NSDictionary dictionaryWithObject:NSLocalizedString(@"Data analysis failed", @"数据解析失败") forKey:NSLocalizedDescriptionKey];
                                error = [NSError errorWithDomain:JsonErrorDomain code:eJsonNil userInfo:userInfo];
                                result(error,ApiStatusError,function);
                            }
                        }
                        
                        
                    } else {
                        
                        NSString *apiExceptionMessage = [NetworkHelper makeModelValueWithKey:ParametersKeyMsg Model:json Null:@""];
                        NSDictionary *userInfo = [NSDictionary dictionaryWithObject:apiExceptionMessage forKey:NSLocalizedDescriptionKey];
                        error = [NSError errorWithDomain:JsonErrorDomain code:eJsonNil userInfo:userInfo];
                        result(error,ApiStatusFail,function);
                    }
                }
                
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                
                result(error,ApiStatusError,function);
                
            }];
            //                }
            //            }];
        }
    }];
}

-(void)apiGet:(NSString *)function Dat:(id)dat Result:(void (^)(id result_data, ApiStatus result_status, NSString *api))result {
    
    NSMutableDictionary *datDic = [NSMutableDictionary dictionaryWithDictionary:dat];
    //    if (_login_model==nil ||
    //        _login_model.user_id==nil) {
    //        [datDic setObject:@"0" forKey:@"user_id"];
    //    }
    //    else {
    //        [datDic setObject:_login_model.user_id forKey:@"user_id"];
    //    }
//    [datDic setObject:ApiVersion forKey:@"version"];
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"Index", @"c", function, @"f_name", @"apis", @"m", @"1.0", @"v", nil];
    
    NSString *user_id = [[NSUserDefaults standardUserDefaults] objectForKey:@"user_id"];
    
    if (user_id == nil || [user_id isEqualToString:@""]) {
        [dic setObject:@"16" forKey:@"user_id"];
    }
    else {
        [dic setObject:user_id forKey:@"user_id"];
        
    }
    
    [datDic setObject:dic forKey:@"data"];
    
    [NetworkHelper isNetWorkReachable:^(AFNetworkReachabilityStatus result_ntwk_status) {
        if (AFNetworkReachabilityStatusNotReachable == result_ntwk_status)
        {
            NSDictionary *userInfo = [NSDictionary dictionaryWithObject:NSLocalizedString(@"Please check your network connection is correct", @"请检查您的网络连接是否正确") forKey:NSLocalizedDescriptionKey];
            NSError *error = [NSError errorWithDomain:JsonErrorDomain code:eJsonNil userInfo:userInfo];
            result(error,ApiStatusNetworkNotReachable,function);
        } else {
            
            [[AFAppDotNetAPIClient sharedClient] portal:^(id result_data, ApiStatus result_status) {
                NSString *portal = (NSString *)result_data;
                if (nil == portal)
                {
                    NSDictionary *userInfo = [NSDictionary dictionaryWithObject:NSLocalizedString(@"Please check your network connection is correct", @"请检查您的网络连接是否正确") forKey:NSLocalizedDescriptionKey];
                    NSError *error = [NSError errorWithDomain:JsonErrorDomain code:eJsonNil userInfo:userInfo];
                    result(error,ApiStatusNetworkNotReachable,function);
                }
                else
                {
                    NSURLSessionDataTask *operation = [self GET:APIName parameters:@{ParametersKeyFun: function,ParametersKeyVer: ApiVersion,ParametersKeyDat: datDic} progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                        
                        
                        NSString *sti = APIName;
                        NSLog(@"APIName ========= %@", sti);
                        NSLog(@"datDic ========= %@", datDic);
                        
                        NSError *error = nil;
                        id json = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:&error];
                        NSInteger status = [[NetworkHelper makeModelValueWithKey:ParametersKeyRet Model:json Null:@"0"] integerValue];
                        if (error!=nil)
                        {
                            result(error,ApiStatusError,function);
                        }
                        else if (json==nil)
                        {
                            NSDictionary *userInfo = [NSDictionary dictionaryWithObject:NSLocalizedString(@"Data analysis failed", @"数据解析失败") forKey:NSLocalizedDescriptionKey];
                            error = [NSError errorWithDomain:JsonErrorDomain code:eJsonNil userInfo:userInfo];
                            result(error,ApiStatusError,function);
                        }
                        else if ([json isEqual:[NSNull null]])
                        {
                            NSDictionary *userInfo = [NSDictionary dictionaryWithObject:NSLocalizedString(@"Data analysis failed", @"数据解析失败") forKey:NSLocalizedDescriptionKey];
                            error = [NSError errorWithDomain:JsonErrorDomain code:eJsonNil userInfo:userInfo];
                            result(error,ApiStatusError,function);
                        }
                        else if (![json isKindOfClass:[NSDictionary class]])
                        {
                            NSDictionary *userInfo = [NSDictionary dictionaryWithObject:NSLocalizedString(@"Data analysis failed", @"数据解析失败") forKey:NSLocalizedDescriptionKey];
                            error = [NSError errorWithDomain:JsonErrorDomain code:eJsonNil userInfo:userInfo];
                            result(error,ApiStatusError,function);
                        }
                        else
                        {
                            if (1 == status) {
                                NSMutableArray *modelArr = [NSMutableArray arrayWithCapacity:0];
                                @try {
                                    NSArray *Data = [NetworkHelper makeModelValueWithKey:ParametersKeyDat Model:json Null:@[]];
                                    
                                    [Data enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                                        NSDictionary *modelDic = (NSDictionary *)obj;
                                        //用function(NSString)参数if判断以确定ApiName枚举
                                        id modelObject = [JSONHelper jsonToModel:modelDic Api:ApiEnumNone Idx:idx ImageURL:APIImageName];
                                        if (modelArr!=nil) {
                                            *stop = YES;
                                        }
                                        else {
                                            if ([modelObject isKindOfClass:[NSArray class]]) {
                                                [modelArr addObjectsFromArray:modelObject];
                                            } else {
                                                [modelArr addObject:modelObject];
                                            }
                                        }
                                    }];
                                }
                                @catch (NSException *exception) {
                                    NSDictionary *userInfo = [NSDictionary dictionaryWithObject:exception.description forKey:NSLocalizedDescriptionKey];
                                    error = [NSError errorWithDomain:JsonErrorDomain code:eJsonNil userInfo:userInfo];
                                    result(error,ApiStatusException,function);
                                }
                                @finally {
                                    if (modelArr==nil &&
                                        modelArr.count>0) {
                                        result(modelArr,ApiStatusSuccess,function);
                                    }
                                    else {
                                        NSDictionary *userInfo = [NSDictionary dictionaryWithObject:NSLocalizedString(@"Data analysis failed", @"数据解析失败") forKey:NSLocalizedDescriptionKey];
                                        error = [NSError errorWithDomain:JsonErrorDomain code:eJsonNil userInfo:userInfo];
                                        result(error,ApiStatusError,function);
                                    }
                                }
                            } else {
                                NSString *apiExceptionMessage = [NetworkHelper makeModelValueWithKey:ParametersKeyMsg Model:json Null:@""];
                                NSDictionary *userInfo = [NSDictionary dictionaryWithObject:apiExceptionMessage forKey:NSLocalizedDescriptionKey];
                                error = [NSError errorWithDomain:JsonErrorDomain code:eJsonNil userInfo:userInfo];
                                result(error,ApiStatusFail,function);
                            }
                        }
                        
                    }failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                        
                        result(error,ApiStatusError,function);
                        
                    }];
                    
                    [operation resume];
                }
            }];
        }
    }];
}





@end
