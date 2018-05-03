//
//  FWPayManager.h
//  FWWXPay
//
//  Created by 孔凡伍 on 2018/5/3.
//  Copyright © 2018年 潇潇. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WXApi.h"
#import "WXApiObject.h"

static NSString * const WX_APP_ID = @"wxd930ea5d5a258f4f";

typedef void(^PayRespBlock)(BaseResp *resp);


@interface FWPayManager : NSObject 

+ (instancetype)sharedInstance;

/**
 发起支付
 
 @param req 支付对象
 @param respBlock 支付结果回调block,
 @return 发起支付结果
 */
- (BOOL)sendReq:(BaseReq*)req onRespBlock:(PayRespBlock)respBlock;

/*! @brief 处理微信通过URL启动App时传递的数据
 *
 * 需要在 application:openURL:sourceApplication:annotation:或者application:handleOpenURL中调用。
 * @param url 微信启动第三方应用时传递过来的URL
 * @return 成功返回YES，失败返回NO。
 */
- (BOOL)handleOpenURL:(NSURL *)url;

@end
