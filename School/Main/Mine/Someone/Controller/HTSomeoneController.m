//
//  HTSomeoneController.m
//  School
//
//  Created by hublot on 17/8/18.
//  Copyright © 2017年 hublot. All rights reserved.
//

#import "HTSomeoneController.h"
#import <UIScrollView+HTRefresh.h>
#import <UITableView+HTSeparate.h>
#import "HTFansCell.h"
#import "HTUser.h"
#import "HTSomeoneModel.h"
#import "HTSomeoneCell.h"
#import "HTFansController.h"
#import "HTLikeController.h"
#import "HTAnswerRecordController.h"
#import "HTSolutionRecordController.h"
#import "HTUserManager.h"
#import "HTChatController.h"

@interface HTSomeoneController ()

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) UIButton *startMessageButton;

@property (nonatomic, strong) HTUser *userModel;

@end

@implementation HTSomeoneController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initializeDataSource];
    [self initializeUserInterface];
}

- (void)initializeDataSource {
    
    __weak typeof(self) weakSelf = self;
    [self.tableView ht_setRefreshBlock:^(NSString *pageSize, NSString *currentPage) {
        HTNetworkModel *networkModel = [HTNetworkModel modelForOnlyCacheNoInterfaceForScrollViewWithCacheStyle:HTCacheStyleAllUser];
        [HTRequestManager requestUserInfomationWithNetworkModel:networkModel uidString:weakSelf.userIdString complete:^(id response, HTError *errorModel) {
            if (errorModel.existError) {
                [weakSelf.tableView ht_endRefreshWithModelArrayCount:errorModel.errorType];
                return;
            }
            HTUser *user = [HTUser mj_objectWithKeyValues:response[@"data"]];
            if (user) {
                weakSelf.userModel = user;
                weakSelf.navigationItem.title = HTPlaceholderString(user.nickname, user.userName);
                weakSelf.startMessageButton.enabled = true;
                [weakSelf.tableView ht_endRefreshWithModelArrayCount:1];
                [weakSelf.tableView ht_updateSection:0 sectionMakerBlock:^(HTTableViewSectionMaker *sectionMaker) {
                    sectionMaker.modelArray(@[user]);
                }];
                NSArray *modelArray = [HTSomeoneModel packModelArrayWithUser:user];
                [weakSelf.tableView ht_updateSection:1 sectionMakerBlock:^(HTTableViewSectionMaker *sectionMaker) {
                    sectionMaker.modelArray(modelArray);
                }];
            } else {
                [weakSelf.tableView ht_endRefreshWithModelArrayCount:0];
            }
        }];
    }];
    [self.tableView ht_startRefreshHeader];
}

- (void)initializeUserInterface {
    self.navigationItem.title = @"用户资料";
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.startMessageButton];
    [self.startMessageButton mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.right.left.mas_equalTo(self.view);
        make.height.mas_equalTo(0);
    }];
    [self.tableView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.mas_equalTo(self.view);
        make.bottom.mas_equalTo(self.startMessageButton.mas_top);
    }];
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] init];
        _tableView.backgroundColor = [UIColor ht_colorString:@"f0f0f0"];
        _tableView.separatorColor = _tableView.backgroundColor;
        
        __weak typeof(self) weakSelf = self;
        [_tableView ht_updateSection:0 sectionMakerBlock:^(HTTableViewSectionMaker *sectionMaker) {
            [sectionMaker.cellClass([HTFansCell class]).rowHeight(80) didSelectedCellBlock:^(UITableView *tableView, NSInteger row, __kindof UITableViewCell *cell, __kindof NSObject *model) {
                
            }];
        }];
        [_tableView ht_updateSection:1 sectionMakerBlock:^(HTTableViewSectionMaker *sectionMaker) {
            [sectionMaker.cellClass([HTSomeoneCell class]).rowHeight(70) didSelectedCellBlock:^(UITableView *tableView, NSInteger row, __kindof UITableViewCell *cell, __kindof HTSomeoneModel *model) {
                NSString *uidString = weakSelf.userModel.uid;
                UIViewController *viewController;
                switch (model.type) {
                    case HTSomeoneTypeAnswer: {
                        HTAnswerRecordController *recordController = [[HTAnswerRecordController alloc] init];
                        recordController.uidString = uidString;
                        viewController = recordController;
                        break;
                    }
                    case HTSomeoneTypeSolution: {
                        HTSolutionRecordController *recordController = [[HTSolutionRecordController alloc] init];
                        recordController.uidString = uidString;
                        viewController = recordController;
                        break;
                    }
                    case HTSomeoneTypeFans: {
                        HTFansController *fansController = [[HTFansController alloc] init];
                        fansController.uidString = uidString;
                        viewController = fansController;
                        break;
                    }
                    case HTSomeoneTypeLike: {
                        HTLikeController *likeController = [[HTLikeController alloc] init];
                        likeController.uidString = uidString;
                        viewController = likeController;
                        break;
                    }
                }
                if (viewController) {
                    [weakSelf.navigationController pushViewController:viewController animated:true];
                }
            }];
        }];
    }
    return _tableView;
}

- (UIButton *)startMessageButton {
    if (!_startMessageButton) {
        _startMessageButton = [[UIButton alloc] init];
        _startMessageButton.titleLabel.font = [UIFont systemFontOfSize:15];
        [_startMessageButton setTitle:@"和 Ta 聊天" forState:UIControlStateNormal];
        [_startMessageButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
        UIColor *normalBackgroundColor = [UIColor ht_colorStyle:HTColorStyleTintColor];
        UIColor *highlightBackgroundColor = [normalBackgroundColor colorWithAlphaComponent:0.5];
        [_startMessageButton setBackgroundImage:[UIImage ht_pureColor:normalBackgroundColor] forState:UIControlStateNormal];
        [_startMessageButton setBackgroundImage:[UIImage ht_pureColor:highlightBackgroundColor] forState:UIControlStateHighlighted];
        
        _startMessageButton.enabled = false;
        _startMessageButton.clipsToBounds = true;
        
        __weak typeof(self) weakSelf = self;
        [_startMessageButton ht_whenTap:^(UIView *view) {
			NSString *willChatUid = weakSelf.userModel.uid;
			NSString *willChatNickname = weakSelf.userModel.userName;
			[HTUserManager surePermissionHighOrEqual:HTUserPermissionExerciseAbleUser passCompareBlock:^(HTUser *user) {
				if (!willChatUid.length || !willChatNickname.length) {
					[HTAlert title:@"不能发起聊天"];
					return;
				}
				HTChatController *chatController = [[HTChatController alloc] init];
				chatController.willChatUserId = willChatUid;
				chatController.willChatNickname = willChatNickname;
				[weakSelf.navigationController pushViewController:chatController animated:true];
			}];
        }];
    }
    return _startMessageButton;
}


@end
