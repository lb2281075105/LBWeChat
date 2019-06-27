//
//  LBWCUserModel.h
//  LBWeChat
//
//  Created by liubo on 2019/6/26.
//  Copyright © 2019 刘博. All rights reserved.
//

#import "JKDBModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface LBWCUserModel : JKDBModel
// 用户类型 1：自己 0：其他人
@property (nonatomic, assign) int type;
// 名字
@property (nonatomic, copy) NSString * name;
// 账号
@property (nonatomic, copy) NSString * account;
// 头像路径
@property (nonatomic, copy) NSString * portrait;
// 区域
@property (nonatomic, copy) NSString * region;
@end

NS_ASSUME_NONNULL_END
