//
//  LBWCMineTV.m
//  LBWeChat
//
//  Created by liubo on 2019/6/26.
//  Copyright © 2019 刘博. All rights reserved.
//

#import "LBWCMineTV.h"

@implementation LBWCMineTV
- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    self = [super initWithFrame:frame style:style];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setupUI];
    }
    return self;
}

// 预估高度
- (void)setupUI{
    
    self.backgroundColor = [UIColor clearColor];
    self.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    self.separatorColor = LBWeChatRGBColor(205.f, 205.f, 205.f);
    self.estimatedRowHeight = 0;
    self.estimatedSectionHeaderHeight = 0;
    self.estimatedSectionFooterHeight = 0;
}

@end
