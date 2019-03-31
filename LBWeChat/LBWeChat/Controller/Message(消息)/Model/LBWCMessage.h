//
//  LBWCMessage.h
//  LBWeChat
//
//  Created by liubo on 2019/3/31.
//  Copyright © 2019 刘博. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LBWCMessage : JKDBModel
// 名字
@property (nonatomic, copy) NSString *userName;
// 头像路径
@property (nonatomic, copy) NSString *userPortrait;
// 名字
@property (nonatomic, copy) NSString *content;
// 时间戳
@property (nonatomic, assign) long long time;
@end

NS_ASSUME_NONNULL_END
