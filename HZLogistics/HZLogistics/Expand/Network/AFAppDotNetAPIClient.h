// AFAppDotNetAPIClient.h
// Copyright (c) 2012 Mattt Thompson (http://mattt.me/)
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

//注：
//1，所有的返参默认为string类型；其它类型会另行标注；（除了string，还需要使用int类型）
//2，所有的入参，均不限类型；
//3，所有的id参数，按照int传递；
//4，所有的返回值ret，按照int传递；
//5，所有的返参中，涉及数量的，按照int传递

#import <Foundation/Foundation.h>

#import "AFHTTPSessionManager.h"
//#import "LoginModel.h"

////////////////////////////////
////////////////////////////////

//Jason 20150629
//打开注释，测试环境193服务器
//注释掉，生产环境218服务器

#define TARGET_TEST_SERVER     1

//Jason 20150629
//打开注释，打开版本更新，发布企业版本
//注释掉，关闭版本更新，发布applestore

#define AppleStore 1

////////////////////////////////////////////////////////////////

typedef enum : NSUInteger {
    eJsonDefault,
    eJsonNil,
    eJsonNull,
    eJsonNotDictionary
} CustomErrorFailed;

typedef enum : NSUInteger {
    ApiStatusSuccess,
    ApiStatusFail,
    ApiStatusError,
    ApiStatusException,
    ApiStatusNetworkNotReachable,
    ApiStatusAppNoUse
} ApiStatus;

#define appCurVersion [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]

#define appCurVersionNum [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"]

#define JsonErrorDomain @"com.Houses.json"

#define DownloadPath @"Download"

#define PortalURL @"http://58.215.78.118/1709/ip.txt"

//开发：101.200.181.193
//生产：101.200.158.218
#if TARGET_TEST_SERVER
    //测试环境地址
    #define BASE_URL @"http://101.200.181.193"

#else
    //生产环境地
//      #define BASE_URL @"http://101.200.158.218"
    #define BASE_URL @"http://www.meilaoban.com"

#endif

#define APIName BASE_URL"/jiyun/index.php/Apis/Index/apiAutoLoad/"

#define APIImageName BASE_URL"/jiyun"


//Api Value Key
#define ParametersKeyRet @"ret"
#define ParametersKeyMsg @"msg"
#define ParametersKeyFun @"f_name"
#define ParametersKeyVer @"v"
#define ParametersKeyDat @"dat"
//API Version
//每次更新API接口版本的时候，需要修改该值
#define ApiVersion @"1.0"

#define ServerVersionURL    BASE_URL @"/coalboss/m/coaldriver_version.json"

//用户
#define ApiNameRegistUser @"registUser"//注册
#define ApiNameGetBackPwd @"getBackPwd"//找回
#define ApiNameLogin @"login"//登陆(含自动登陆)
#define ApiNameGetUserInfo @"getUserInfo"//个人信息
#define ApiNameUploadAvatar @"uploadAvatar"//上传头像


//消息
#define ApiNameGetSysMsgList @"getSysMsgList"//获取系统消息列表
#define ApiNameGetSysMsgInfo @"getSysMsgInfo"//获取系统消息
#define ApiNameDeleteMsg @"deleteMsg"//删除消息

//公司
#define ApiNameUploadListenPhoto @"uploadListenPhoto"//上传营业执照照片
#define ApiNameCreateNewCompany @"createNewCompany"//提交公司审核信息
#define ApiNameGetCompanyInfo @"getCompanyInfo"//获取公司信息

//选择
#define ApiNameGetPortsList @"getPortsList"//获取港口列表
#define ApiNamePayTypeList @"getPayTypeList"//获取支付列表
#define ApiNameOrderSelects @"orderSelects"//获取审核状态列表

//订单
#define ApiNameSubOrder @"subOrder"//下单
#define ApiNameGetOrdersList @"getOrdersList"//委托单列表
#define ApiNameGetOrderInfo @"getOrderInfo"//委托单详情
#define ApiNameOrderComplete @"orderComplete"//确认收货
#define ApiNameoOrderStatusList @"orderStatusList"//货物状态列表

//推送
#define ApiNameSaveChannelId @"saveChannelId"//保存推送号


@interface AFAppDotNetAPIClient :AFHTTPSessionManager
@property (nonatomic, strong) NSString *protalurl;

//@property (nonatomic, strong) LoginModel *login_model;
//@property (nonatomic, strong) ApiMyOrderListModel *MyOrder;

+ (instancetype)sharedClient;

-(void)portal:(void (^)(id result_data, ApiStatus result_status))result;
-(void)uploadFile:(NSString *)function Files:(NSArray *)files Dat:(id)dat Result:(void (^)(id result_data, ApiStatus result_status))result Progress:(void (^)(CGFloat progress))progress;
-(void)downloadFile:(NSString *)function Dat:(id)dat FileName:(NSString *)filename Result:(void (^)(id result_data, ApiStatus result_status))result Progress:(void (^)(CGFloat progress))progress;

-(void)apiPost:(NSString *)function Dat:(id)dat Result:(void (^)(id result_data, ApiStatus result_status, NSString *api))result;

-(void)apiGet:(NSString *)function Dat:(id)dat Result:(void (^)(id result_data, ApiStatus result_status, NSString *api))result;




@end
