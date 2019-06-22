//
//  LBWCMessageController.m
//  LBWeChat
//
//  Created by liubo on 2019/3/29.
//  Copyright © 2019 刘博. All rights reserved.
//

#import "LBWCMessageController.h"
#import "LBWCSearchResultController.h"
#import "LBWCMessage.h"
#import "LBWCMessageCell.h"

@interface LBWCMessageController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *messageList;

@end

@implementation LBWCMessageController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = LBWeChatBackgroundColor;
    [self.view addSubview:self.tableView];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.messageList removeAllObjects];
    [self.messageList addObjectsFromArray:[LBWCMessage findAll]];
    [self.tableView reloadData];
}

- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen cz_screenWidth], [UIScreen cz_screenHeight] - LBWeChatTopHeight - LBWeChatTabBarHeight)];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        
        LBWCSearchResultController *controller = [[LBWCSearchResultController alloc] init];
        UISearchController *searchController = [[UISearchController alloc] initWithSearchResultsController:controller];
        searchController.searchBar.userInteractionEnabled = NO;
        searchController.searchBar.enablesReturnKeyAutomatically = YES;
        searchController.searchBar.searchTextPositionAdjustment = UIOffsetMake(5, 0);
        [searchController.searchBar setPositionAdjustment:UIOffsetMake(([UIScreen cz_screenWidth] - 60) / 2.0, 0) forSearchBarIcon:UISearchBarIconSearch];
        [searchController.searchBar setBackgroundImage:[Utility imageWithRenderColor:LBWeChatBackgroundColor renderSize:CGSizeMake(1, 1)] forBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
        [searchController.searchBar sizeToFit];
        // 输入框
        UITextField *searchField = [searchController.searchBar valueForKey:@"_searchField"];
        searchField.borderStyle = UITextBorderStyleNone;
        searchField.textAlignment = NSTextAlignmentCenter;
        searchField.textColor = [UIColor grayColor];
        searchField.font = [UIFont systemFontOfSize:16];
        searchField.placeholder = @"搜索";
        searchField.layer.masksToBounds = YES;
        searchField.layer.cornerRadius = 5;
        searchField.backgroundColor = [UIColor whiteColor];
        _tableView.tableHeaderView = searchController.searchBar;
        _tableView.tableFooterView = [UIView new];
    }
    return _tableView;
}

- (NSMutableArray *)messageList{
    if (!_messageList) {
        _messageList = [[NSMutableArray alloc] init];
    }
    return _messageList;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.messageList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"LBWCMessageCell";
    LBWCMessageCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[LBWCMessageCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.backgroundColor = [UIColor whiteColor];
    }
    LBWCMessage *message = [self.messageList objectAtIndex:indexPath.row];
    cell.message = message;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 70;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
