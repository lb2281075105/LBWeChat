//
//  LBWCUserDetailCell.m
//  LBWeChat
//
//  Created by liubo on 2019/6/26.
//  Copyright © 2019 刘博. All rights reserved.
//

#import "LBWCUserDetailCell.h"
#import "MMImageListView.h"
@interface LBWCUserDetailCell()

@property (nonatomic, strong) MMImageView *avatarImageView; // 头像
@property (nonatomic, strong) UILabel *nameLabel; // 名称
@property (nonatomic, strong) UILabel *accountLabel; // 微信号
@property (nonatomic, strong) UILabel *regionLabel; // 地区

@end

@implementation LBWCUserDetailCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        // 头像
        _avatarImageView = [[MMImageView alloc] initWithFrame:CGRectMake(15, 10, 60, 60)];
        _avatarImageView.layer.cornerRadius = 4.0;
        _avatarImageView.layer.masksToBounds = YES;
        [self.contentView addSubview:_avatarImageView];
        // 名字
        _nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(_avatarImageView.right + 10, _avatarImageView.top, [UIScreen cz_screenWidth] - (_avatarImageView.right + 20), 23)];
        _nameLabel.font = [UIFont boldSystemFontOfSize:17.0];
        _nameLabel.textColor = [UIColor blackColor];
        [self.contentView addSubview:_nameLabel];
        // 账号
        _accountLabel = [[UILabel alloc] initWithFrame:CGRectMake(_nameLabel.left, _nameLabel.bottom, _nameLabel.width, 20)];
        _accountLabel.font = [UIFont systemFontOfSize:12.0];
        _accountLabel.textColor = [UIColor grayColor];
        [self.contentView addSubview:_accountLabel];
        // 账号
        _regionLabel = [[UILabel alloc] initWithFrame:CGRectMake(_nameLabel.left, _accountLabel.bottom, _nameLabel.width, 18)];
        _regionLabel.font = [UIFont systemFontOfSize:12.0];
        _regionLabel.textColor = [UIColor grayColor];
        [self.contentView addSubview:_regionLabel];
    }
    return self;
}

- (void)setUser:(MUser *)user
{
    _nameLabel.text = user.name;
    _accountLabel.text = [NSString stringWithFormat:@"微信号：%@",user.account];
    _regionLabel.text = [NSString stringWithFormat:@"地区：%@",user.region];
    [_avatarImageView sd_setImageWithURL:[NSURL URLWithString:user.portrait] placeholderImage:[UIImage imageNamed:@"moment_head"]];
}

@end
