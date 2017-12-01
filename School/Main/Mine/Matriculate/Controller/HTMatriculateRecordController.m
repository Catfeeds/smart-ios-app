//
//  HTMatriculateRecordController.m
//  School
//
//  Created by hublot on 2017/8/18.
//  Copyright © 2017年 hublot. All rights reserved.
//

#import "HTMatriculateRecordController.h"
#import "HTMatriculateRecordTypeModel.h"
#import "HTMatriculateRecordCell.h"
#import <UITableView+HTSeparate.h>
#import <UIScrollView+HTRefresh.h>
#import "HTMatriculateAllSchoolController.h"
#import "HTMatriculateSingleSchoolController.h"
#import "HTSchoolMatriculateDetailController.h"
#import "HTSchoolMatriculateSingleController.h"
#import "HTManagerController.h"
#import "HTRootNavigationController.h"

@interface HTMatriculateRecordController ()

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation HTMatriculateRecordController

- (void)viewDidLoad {
	[super viewDidLoad];
	[self initializeDataSource];
	[self initializeUserInterface];
}

- (void)initializeDataSource {
	
	__weak typeof(self) weakSelf = self;
	[self.tableView ht_setRefreshBlock:^(NSString *pageSize, NSString *currentPage) {
        HTNetworkModel *networkModel = [HTNetworkModel modelForOnlyCacheNoInterfaceForScrollViewWithCacheStyle:HTCacheStyleSingleUser];
        [HTRequestManager requestMatriculateRecordWithNetworkModel:networkModel complete:^(id response, HTError *errorModel) {
            if (errorModel.existError) {
                [weakSelf.tableView ht_endRefreshWithModelArrayCount:errorModel.errorType];
                return;
            }
            NSArray *modelArray = [HTMatriculateRecordTypeModel packModelArrayWithResponse:response];
            [weakSelf.tableView ht_endRefreshWithModelArrayCount:1];
            [weakSelf.tableView ht_updateSection:0 sectionMakerBlock:^(HTTableViewSectionMaker *sectionMaker) {
                sectionMaker.modelArray(modelArray);
            }];
        }];
	}];
	[self.tableView ht_startRefreshHeader];
}

- (void)initializeUserInterface {
	self.navigationItem.title = @"我的测评";
	[self.view addSubview:self.tableView];
}

- (UITableView *)tableView {
	if (!_tableView) {
		_tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
		_tableView.backgroundColor = [UIColor ht_colorString:@"f3f3f3"];
		_tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
		
		__weak typeof(self) weakSelf = self;
		[_tableView ht_updateSection:0 sectionMakerBlock:^(HTTableViewSectionMaker *sectionMaker) {
			[[sectionMaker.cellClass([HTMatriculateRecordCell class]) customCellBlock:^(UITableView *tableView, NSInteger row, __kindof HTMatriculateRecordCell *cell, __kindof HTMatriculateRecordTypeModel *model) {
				[cell.lookDetailButton ht_whenTap:^(UIView *view) {
					UIViewController *viewController;
					switch (model.type) {
						case HTMatriculateRecordTypeAll: {
							HTMatriculateAllSchoolController *allController = [[HTMatriculateAllSchoolController alloc] init];
							viewController = allController;
							break;
						}
						case HTMatriculateRecordTypeSingle: {
							HTMatriculateSingleSchoolController *singleController = [[HTMatriculateSingleSchoolController alloc] init];
							viewController = singleController;
							break;
						}
					}
					if (viewController) {
						[weakSelf.navigationController pushViewController:viewController animated:true];
					}
				}];
				[cell.matriculateButton ht_whenTap:^(UIView *view) {
					UIViewController *viewController;
					switch (model.type) {
						case HTMatriculateRecordTypeAll: {
							HTSchoolMatriculateDetailController *allController = [[HTSchoolMatriculateDetailController alloc] init];
							viewController = allController;
							break;
						}
						case HTMatriculateRecordTypeSingle: {
							HTSchoolMatriculateSingleController *singleController = [[HTSchoolMatriculateSingleController alloc] init];
							viewController = singleController;
							break;
						}
					}
					if (viewController) {
						[weakSelf.navigationController pushViewController:viewController animated:true];
					}
				}];
			}] didSelectedCellBlock:^(UITableView *tableView, NSInteger row, __kindof HTMatriculateRecordCell *cell, __kindof HTMatriculateRecordTypeModel *model) {
				if (model.showDetail) {
					[cell.lookDetailButton ht_responderTap];
				} else {
					[cell.matriculateButton ht_responderTap];
				}
			}];
		}];
	}
	return _tableView;
}


@end
