//
//  LBWCMessageCell.h
//  LBWeChat
//
//  Created by liubo on 2019/3/31.
//  Copyright © 2019 刘博. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LBWCMessage.h"
NS_ASSUME_NONNULL_BEGIN

@interface LBWCMessageCell : UITableViewCell
@property (nonatomic, strong) LBWCMessage *message;
@property (nonatomic, strong) UIImageView *portraitView;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *messageLabel;
@property (nonatomic, strong) UILabel *timeLabel;

@end

NS_ASSUME_NONNULL_END
