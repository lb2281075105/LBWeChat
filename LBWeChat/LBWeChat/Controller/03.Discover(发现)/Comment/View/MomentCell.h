//
//  MomentCell.h
//  MomentKit
//
//  Created by LEA on 2017/12/14.
//  Copyright © 2017年 LEA. All rights reserved.
//
//  朋友圈动态
//

#import <UIKit/UIKit.h>
#import "MMOperateMenuView.h"
#import "MMImageListView.h"
#import "MomentKit.h"
#import "Moment.h"
#import "Comment.h"

//#### 动态

@protocol MomentCellDelegate;
@interface MomentCell : UITableViewCell <MLLinkLabelDelegate>

// 头像
@property (nonatomic, strong) MMImageView * avatarImageView;
// 名称
@property (nonatomic, strong) UILabel * nameLab;
// 时间
@property (nonatomic, strong) UILabel * timeLab;
// 位置
@property (nonatomic, strong) UIButton * locationBtn;
// 时间
@property (nonatomic, strong) UIButton * deleteBtn;
// 全文
@property (nonatomic, strong) UIButton * showAllBtn;
// 内容
@property (nonatomic, strong) MLLinkLabel * linkLabel;
// 图片
@property (nonatomic, strong) MMImageListView * imageListView;
// 赞和评论视图
@property (nonatomic, strong) UIView * commentView;
// 赞和评论视图背景
@property (nonatomic, strong) UIImageView * bgImageView;
// 操作视图
@property (nonatomic, strong) MMOperateMenuView * menuView;

// 动态
@property (nonatomic, strong) Moment * moment;
// 代理
@property (nonatomic, assign) id<MomentCellDelegate> delegate;


@end

@protocol MomentCellDelegate <NSObject>

@optional

// 点击头像|删除|点赞|评论|全文/收起
- (void)didOperateMoment:(MomentCell *)cell operateType:(MMOperateType)operateType;
// 选择评论
- (void)didSelectComment:(Comment *)comment;
// 点击高亮文字
- (void)didClickLink:(MLLink *)link linkText:(NSString *)linkText;

@end


//#### 评论
@interface CommentLabel : UIView <MLLinkLabelDelegate>

// 内容Label
@property (nonatomic, strong) MLLinkLabel * linkLabel;
// 评论
@property (nonatomic, strong) Comment * comment;
// 点击评论高亮内容
@property (nonatomic, copy) void (^didClickLinkText)(MLLink *link , NSString *linkText);
// 点击评论
@property (nonatomic, copy) void (^didClickText)(Comment *comment);

@end


