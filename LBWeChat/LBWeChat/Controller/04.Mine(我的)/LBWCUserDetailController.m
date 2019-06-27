//
//  LBWCUserDetailController.m
//  LBWeChat
//
//  Created by liubo on 2019/6/26.
//  Copyright © 2019 刘博. All rights reserved.
//

#import "LBWCUserDetailController.h"
#import "MMImageListView.h"
#import "LBWCUserDetailCell.h"
#import "LBWCMineTV.h"
@interface LBWCUserDetailController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) LBWCMineTV *tableView;
@property (nonatomic, strong) UIView *imageListView;

@end

@implementation LBWCUserDetailController

- (void)viewDidLoad{
    [super viewDidLoad];
    self.title = @"详细资料";
    self.view.backgroundColor = LBWeChatBackgroundColor;
    [self setupUI];
}

- (void)setupUI
{
    _tableView = [[LBWCMineTV alloc] initWithFrame:CGRectMake(0, 0, [UIScreen cz_screenWidth], [UIScreen cz_screenHeight] - LBWeChatTopHeight) style:UITableViewStyleGrouped];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    [self.view addSubview:_tableView];
    
    UIView * footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen cz_screenWidth], 200)];
    footerView.backgroundColor = [UIColor clearColor];
    _tableView.tableFooterView = footerView;
    
    UIButton * chatBtn = [[UIButton alloc] initWithFrame:CGRectMake(20, 20, [UIScreen cz_screenWidth] - 40, 44)];
    chatBtn.layer.cornerRadius = 4.0;
    chatBtn.layer.masksToBounds = YES;
    chatBtn.userInteractionEnabled = NO;
    chatBtn.backgroundColor = LBWeChatRGBColor(14.0, 178.0, 10.0);
    [chatBtn setTitle:@"发消息" forState:UIControlStateNormal];
    [footerView addSubview:chatBtn];
    
    UIButton * videoBtn = [[UIButton alloc] initWithFrame:CGRectMake(20, chatBtn.bottom + 15, [UIScreen cz_screenWidth] - 40, 44)];
    videoBtn.layer.cornerRadius = 4.0;
    videoBtn.layer.masksToBounds = YES;
    videoBtn.layer.borderColor = LBWeChatRGBColor(215.0, 215.0, 215.0).CGColor;
    videoBtn.layer.borderWidth = 0.5;
    videoBtn.userInteractionEnabled = NO;
    videoBtn.backgroundColor = [UIColor whiteColor];
    [videoBtn setTitle:@"视频聊天" forState:UIControlStateNormal];
    [videoBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [footerView addSubview:videoBtn];
    
    NSArray * images = @[@"https://ss0.bdstatic.com/70cFuHSh_Q1YnxGkpoWK1HF6hhy/it/u=239815455,722413567&fm=26&gp=0.jpg",
                         @"https://ss1.bdstatic.com/70cFvXSh_Q1YnxGkpoWK1HF6hhy/it/u=3541265676,1400518403&fm=26&gp=0.jpg",
                         @"https://ss1.bdstatic.com/70cFuXSh_Q1YnxGkpoWK1HF6hhy/it/u=4048148084,3143739835&fm=26&gp=0.jpg"];
    
    _imageListView = [[UIView alloc] initWithFrame:CGRectMake([UIScreen cz_screenWidth] - 110, 0, 80, 80)];
    CGFloat width = _imageListView.width;
    NSInteger count = arc4random() % 3 + 1; // 1-3个
    for (NSInteger i = 1; i <= count; i ++) {
        MMImageView * imageView = [[MMImageView alloc] initWithFrame:CGRectMake(width - 60 * i, 15, 50, 50)];
        [imageView sd_setImageWithURL:[NSURL URLWithString:[images objectAtIndex:i - 1]] placeholderImage:nil];
        [_imageListView addSubview:imageView];
    }
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 2) {
        return 2;
    } else {
        return 1;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        LBWCUserDetailCell * cell = [[LBWCUserDetailCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:nil];
        cell.user = self.user;
        return cell;
    } else {
        UITableViewCell * cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:nil];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.backgroundColor = [UIColor whiteColor];
        if (indexPath.section == 1) {
            cell.textLabel.text = @"设置备注和标签";
        } else if (indexPath.section == 2) {
            if (indexPath.row == 0) {
                cell.textLabel.text = @"朋友圈";
                [cell.contentView addSubview:_imageListView];
            } else {
                cell.textLabel.text = @"更多信息";
            }
        } else {
        }
        return cell;
    }
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 80;
    } else if (indexPath.section == 1) {
        return 44;
    } else {
        return indexPath.row == 0 ? 80 : 44;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 20;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
