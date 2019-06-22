//
//  LBWCMessageCell.m
//  LBWeChat
//
//  Created by liubo on 2019/3/31.
//  Copyright © 2019 刘博. All rights reserved.
//

#import "LBWCMessageCell.h"

@implementation LBWCMessageCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.contentView addSubview:self.portraitView];
        [self.contentView addSubview:self.nameLabel];
        [self.contentView addSubview:self.messageLabel];
        [self.contentView addSubview:self.timeLabel];
    }
    return self;
}

- (void)setMessage:(LBWCMessage *)message{
    [self.portraitView sd_setImageWithURL:[NSURL URLWithString:message.userPortrait] placeholderImage:nil];
    self.nameLabel.text = message.userName;
    self.messageLabel.text = message.content;
    self.timeLabel.text = [NSString stringWithFormat:@"%@",[Utility getMessageTime:message.time]];
}

- (UIImageView *)portraitView{
    if (!_portraitView) {
        _portraitView = [[UIImageView alloc] initWithFrame:CGRectMake(15, 10, 50, 50)];
        _portraitView.backgroundColor = [UIColor lightGrayColor];
        _portraitView.contentMode = UIViewContentModeScaleAspectFill;
        _portraitView.contentScaleFactor = [[UIScreen mainScreen] scale];
        _portraitView.clipsToBounds = YES;
        _portraitView.layer.cornerRadius = 4.0;
        _portraitView.layer.masksToBounds = YES;
    }
    return _portraitView;
}

- (UILabel *)nameLabel{
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(75, 13, [UIScreen cz_screenWidth] - 150, 25)];
        _nameLabel.font = [UIFont systemFontOfSize:17.0];
        _nameLabel.textColor = [UIColor blackColor];
    }
    return _nameLabel;
}

- (UILabel *)messageLabel{
    if (!_messageLabel) {
        _messageLabel = [[UILabel alloc] initWithFrame:CGRectMake(75, 37, [UIScreen cz_screenWidth] - 100, 20)];
        _messageLabel.font = [UIFont systemFontOfSize:14.0];
        _messageLabel.textColor = [UIColor lightGrayColor];
    }
    return _messageLabel;
}

- (UILabel *)timeLabel{
    if (!_timeLabel) {
        _timeLabel = [[UILabel alloc] initWithFrame:CGRectMake([UIScreen cz_screenWidth] - 110, 10, 100, 25)];
        _timeLabel.textAlignment = NSTextAlignmentRight;
        _timeLabel.font = [UIFont systemFontOfSize:12.0];
        _timeLabel.textColor = [UIColor lightGrayColor];
    }
    return _timeLabel;
}


@end
