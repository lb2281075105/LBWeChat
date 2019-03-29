//
//  MomentCell.m
//  MomentKit
//
//  Created by LEA on 2017/12/14.
//  Copyright © 2017年 LEA. All rights reserved.
//

#import "MomentCell.h"

#pragma mark - ------------------ 动态 ------------------

// 最大高度限制
CGFloat maxLimitHeight = 0;
CGFloat lineSpacing = 5;

@implementation MomentCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self configUI];
    }
    return self;
}

- (void)configUI
{
    __weak typeof(self) weakSelf = self;
    // 头像视图
    _avatarImageView = [[MMImageView alloc] initWithFrame:CGRectMake(10, kBlank, kAvatarWidth, kAvatarWidth)];
    [_avatarImageView setClickHandler:^(MMImageView *imageView) {
        if ([weakSelf.delegate respondsToSelector:@selector(didOperateMoment:operateType:)]) {
            [weakSelf.delegate didOperateMoment:weakSelf operateType:MMOperateTypeProfile];
        }
    }];
    [self.contentView addSubview:_avatarImageView];
    // 名字视图
    _nameLab = [[UILabel alloc] initWithFrame:CGRectMake(_avatarImageView.right + 10, _avatarImageView.top, kTextWidth, 20)];
    _nameLab.font = [UIFont boldSystemFontOfSize:17.0];
    _nameLab.textColor = kHLTextColor;
    [self.contentView addSubview:_nameLab];
    // 正文视图 ↓↓
    // attributes
    NSMutableDictionary * linkTextAttributes = [NSMutableDictionary dictionary];
    [linkTextAttributes setObject:kLinkTextColor forKey:NSForegroundColorAttributeName]; // 前景色
    NSMutableDictionary * activeLinkTextAttributes = [NSMutableDictionary dictionary];
    [activeLinkTextAttributes setObject:kLinkTextColor forKey:NSForegroundColorAttributeName]; // 前景色
    [activeLinkTextAttributes setObject:kHLBgColor forKey:NSBackgroundColorAttributeName]; // 背景色

    _linkLabel = kMLLinkLabel();
    _linkLabel.font = kTextFont;
    _linkLabel.delegate = self;
    _linkLabel.linkTextAttributes = linkTextAttributes;
    _linkLabel.activeLinkTextAttributes = activeLinkTextAttributes;
    [self.contentView addSubview:_linkLabel];
    // 查看'全文'按钮
    _showAllBtn = [[UIButton alloc] init];
    _showAllBtn.titleLabel.font = kTextFont;
    _showAllBtn.backgroundColor = [UIColor clearColor];
    [_showAllBtn setTitle:@"全文" forState:UIControlStateNormal];
    [_showAllBtn setTitle:@"收起" forState:UIControlStateSelected];
    [_showAllBtn setTitleColor:kHLTextColor forState:UIControlStateNormal];
    [_showAllBtn addTarget:self action:@selector(fullTextClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:_showAllBtn];
    [_showAllBtn sizeToFit];
    // 图片区
    _imageListView = [[MMImageListView alloc] initWithFrame:CGRectZero];
    [self.contentView addSubview:_imageListView];
    // 位置视图
    _locationBtn = [[UIButton alloc] init];
    _locationBtn.backgroundColor = [UIColor clearColor];
    _locationBtn.titleLabel.font = [UIFont systemFontOfSize:13.0];
    [_locationBtn setTitleColor:kHLTextColor forState:UIControlStateNormal];
    [_locationBtn addTarget:self action:@selector(locationClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:_locationBtn];
    // 时间视图
    _timeLab = [[UILabel alloc] init];
    _timeLab.textColor = [UIColor colorWithRed:0.43 green:0.43 blue:0.43 alpha:1.0];
    _timeLab.font = [UIFont systemFontOfSize:13.0f];
    [self.contentView addSubview:_timeLab];
    // 删除视图
    _deleteBtn = [[UIButton alloc] init];
    _deleteBtn.backgroundColor = [UIColor clearColor];
    _deleteBtn.titleLabel.font = [UIFont systemFontOfSize:13.0];
    [_deleteBtn setTitle:@"删除" forState:UIControlStateNormal];
    [_deleteBtn setTitleColor:kHLTextColor forState:UIControlStateNormal];
    [_deleteBtn addTarget:self action:@selector(deleteClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:_deleteBtn];
    // 评论视图
    _bgImageView = [[UIImageView alloc] init];
    [self.contentView addSubview:_bgImageView];
    _commentView = [[UIView alloc] init];
    [self.contentView addSubview:_commentView];
    // 操作视图
    _menuView = [[MMOperateMenuView alloc] initWithFrame:CGRectZero];
    [_menuView setOperateMenu:^(MMOperateType operateType) { // 评论|赞
        if ([weakSelf.delegate respondsToSelector:@selector(didOperateMoment:operateType:)]) {
            [weakSelf.delegate didOperateMoment:weakSelf operateType:operateType];
        }
    }];
    [self.contentView addSubview:_menuView];
    // 最大高度限制
    maxLimitHeight = (_linkLabel.font.lineHeight + lineSpacing) * 6;
}

#pragma mark - setter
- (void)setMoment:(Moment *)moment
{
    _moment = moment;
    // 头像
    [_avatarImageView sd_setImageWithURL:[NSURL URLWithString:moment.userPortrait] placeholderImage:nil];
    // 昵称
    _nameLab.text = moment.userName;
    // 正文
    _showAllBtn.hidden = YES;
    _linkLabel.hidden = YES;
    CGFloat bottom = _nameLab.bottom + kPaddingValue;
    CGFloat rowHeight = 0;
    if ([moment.text length])
    {
        _linkLabel.hidden = NO;
        NSMutableParagraphStyle * style = [[NSMutableParagraphStyle alloc] init];
        style.lineSpacing = lineSpacing;
        NSMutableAttributedString * attributedText = [[NSMutableAttributedString alloc] initWithString:moment.text];
        [attributedText addAttribute:NSParagraphStyleAttributeName value:style range:NSMakeRange(0,[moment.text length])];
        _linkLabel.attributedText = attributedText;
        // 判断显示'全文'/'收起'
        CGSize attrStrSize = [_linkLabel preferredSizeWithMaxWidth:kTextWidth];
        CGFloat labHeight = attrStrSize.height;
        if (labHeight > maxLimitHeight) {
            if (!_moment.isFullText) {
                labHeight = maxLimitHeight;
            }
            _showAllBtn.hidden = NO;
            _showAllBtn.selected = _moment.isFullText;
        }
        _linkLabel.frame = CGRectMake(_nameLab.left, bottom, attrStrSize.width, labHeight);
        _showAllBtn.frame = CGRectMake(_nameLab.left, _linkLabel.bottom + kArrowHeight, _showAllBtn.width, kMoreLabHeight);
        if (_showAllBtn.hidden) {
            bottom = _linkLabel.bottom + kPaddingValue;
        } else {
            bottom = _showAllBtn.bottom + kPaddingValue;
        }
    }
    // 图片
    _imageListView.moment = moment;
    if ([moment.pictureList count] > 0) {
        _imageListView.origin = CGPointMake(_nameLab.left, bottom);
        bottom = _imageListView.bottom + kPaddingValue;
    }
    // 位置
    _timeLab.text = [Utility getMomentTime:moment.time];
    [_timeLab sizeToFit];
    if ([moment.location length]) {
        [_locationBtn setTitle:moment.location forState:UIControlStateNormal];
        [_locationBtn sizeToFit];
        _locationBtn.hidden = NO;
        _locationBtn.frame = CGRectMake(_nameLab.left, bottom, _locationBtn.width, kTimeLabelH);
        bottom = _locationBtn.bottom + kPaddingValue;
    } else {
        _locationBtn.hidden = YES;
    }
    _timeLab.frame = CGRectMake(_nameLab.left, bottom, _timeLab.width, kTimeLabelH);
    _deleteBtn.frame = CGRectMake(_timeLab.right + 25, _timeLab.top, 30, kTimeLabelH);
    bottom = _timeLab.bottom + kPaddingValue;
    // 操作视图
    _menuView.frame = CGRectMake([UIScreen cz_screenWidth]-kOperateWidth-10, _timeLab.top-(kOperateHeight-kTimeLabelH)/2, kOperateWidth, kOperateHeight);
    _menuView.show = NO;
    _menuView.isLike = moment.isLike;
    // 处理评论/赞
    _commentView.frame = CGRectZero;
    _bgImageView.frame = CGRectZero;
    _bgImageView.image = nil;
    [_commentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    // 处理赞
    CGFloat top = 0;
    CGFloat width = [UIScreen cz_screenWidth] - kRightMargin - _nameLab.left;
    if ([moment.likeList count]) {
        MLLinkLabel * likeLabel = kMLLinkLabel();
        likeLabel.delegate = self;
        likeLabel.attributedText = kMLLinkLabelAttributedText(moment);
        CGSize attrStrSize = [likeLabel preferredSizeWithMaxWidth:kTextWidth];
        likeLabel.frame = CGRectMake(5, 8, attrStrSize.width, attrStrSize.height);
        [_commentView addSubview:likeLabel];
        // 分割线
        UIView * line = [[UIView alloc] initWithFrame:CGRectMake(0, likeLabel.bottom + 7, width, 0.5)];
        line.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.3];
        [_commentView addSubview:line];
        // 更新
        top = attrStrSize.height + 15;
    }
    // 处理评论
    NSInteger count = [moment.commentList count];
    if (count > 0) {
        for (NSInteger i = 0; i < count; i ++) {
            CommentLabel * label = [[CommentLabel alloc] initWithFrame:CGRectMake(0, top, width, 0)];
            label.comment = [moment.commentList objectAtIndex:i];
            [label setDidClickText:^(Comment *comment) {
                if ([self.delegate respondsToSelector:@selector(didSelectComment:)]) {
                    [self.delegate didSelectComment:comment];
                }
            }];
            [label setDidClickLinkText:^(MLLink *link, NSString *linkText) {
                if ([self.delegate respondsToSelector:@selector(didClickLink:linkText:)]) {
                    [self.delegate didClickLink:link linkText:linkText];
                }
            }];
            [_commentView addSubview:label];
            // 更新
            top += label.height;
        }
    }
    // 更新UI
    if (top > 0) {
        _bgImageView.frame = CGRectMake(_nameLab.left, bottom, width, top + kArrowHeight);
        _bgImageView.image = [[UIImage imageNamed:@"comment_bg"] stretchableImageWithLeftCapWidth:40 topCapHeight:30];
        _commentView.frame = CGRectMake(_nameLab.left, bottom + kArrowHeight, width, top);
        rowHeight = _commentView.bottom + kBlank;
    } else {
        rowHeight = _timeLab.bottom + kBlank;
    }
    // 这样做就是起到缓存行高的作用，省去重复计算!!!
    _moment.rowHeight = rowHeight;
}

#pragma mark - 点击事件
// 查看位置
- (void)locationClicked:(UIButton *)sender
{
    _locationBtn.titleLabel.backgroundColor = kHLBgColor;
    dispatch_time_t when = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC));
    dispatch_after(when, dispatch_get_main_queue(), ^{
        _locationBtn.titleLabel.backgroundColor = [UIColor clearColor];
        if ([self.delegate respondsToSelector:@selector(didOperateMoment:operateType:)]) {
            [self.delegate didOperateMoment:self operateType:MMOperateTypeLocation];
        }
    });
}

// 查看全文/收起
- (void)fullTextClicked:(UIButton *)sender
{
    _showAllBtn.titleLabel.backgroundColor = kHLBgColor;
    dispatch_time_t when = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC));
    dispatch_after(when, dispatch_get_main_queue(), ^{
        _showAllBtn.titleLabel.backgroundColor = [UIColor clearColor];
        _moment.isFullText = !_moment.isFullText;
        [_moment update];
        if ([self.delegate respondsToSelector:@selector(didOperateMoment:operateType:)]) {
            [self.delegate didOperateMoment:self operateType:MMOperateTypeFull];
        }
    });
}

// 删除动态
- (void)deleteClicked:(UIButton *)sender
{
    _deleteBtn.titleLabel.backgroundColor = [UIColor lightGrayColor];
    dispatch_time_t when = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC));
    dispatch_after(when, dispatch_get_main_queue(), ^{
        _deleteBtn.titleLabel.backgroundColor = [UIColor clearColor];
        if ([self.delegate respondsToSelector:@selector(didOperateMoment:operateType:)]) {
            [self.delegate didOperateMoment:self operateType:MMOperateTypeDelete];
        }
    });
}

#pragma mark - MLLinkLabelDelegate
- (void)didClickLink:(MLLink *)link linkText:(NSString *)linkText linkLabel:(MLLinkLabel *)linkLabel
{
    // 点击动态正文或者赞高亮
    if ([self.delegate respondsToSelector:@selector(didClickLink:linkText:)]) {
        [self.delegate didClickLink:link linkText:linkText];
    }
}
@end

#pragma mark - ------------------ 评论 ------------------
@implementation CommentLabel

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _linkLabel = kMLLinkLabel();
        _linkLabel.delegate = self;
        [self addSubview:_linkLabel];
    }
    return self;
}

#pragma mark - Setter
- (void)setComment:(Comment *)comment
{
    _comment = comment;
    _linkLabel.attributedText = kMLLinkLabelAttributedText(comment);
    CGSize attrStrSize = [_linkLabel preferredSizeWithMaxWidth:kTextWidth];
    _linkLabel.frame = CGRectMake(5, 3, attrStrSize.width, attrStrSize.height);
    self.height = attrStrSize.height + 5;
}

#pragma mark - MLLinkLabelDelegate
- (void)didClickLink:(MLLink *)link linkText:(NSString *)linkText linkLabel:(MLLinkLabel *)linkLabel
{
    if (self.didClickLinkText) {
        self.didClickLinkText(link,linkText);
    }
}

#pragma mark - 点击
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    self.backgroundColor = kHLBgColor;
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    dispatch_time_t when = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC));
    dispatch_after(when, dispatch_get_main_queue(), ^{
        self.backgroundColor = [UIColor clearColor];
        if (self.didClickText) {
            self.didClickText(_comment);
        }
    });
}

- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    self.backgroundColor = [UIColor clearColor];
}

@end
