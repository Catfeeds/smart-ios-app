//
//  HTDiscoverActivityController.m
//  School
//
//  Created by hublot on 2017/7/31.
//  Copyright © 2017年 hublot. All rights reserved.
//

#import "HTDiscoverActivityController.h"
#import "HTDiscoverActivityCell.h"
#import <UITableView+HTSeparate.h>
#import <UIScrollView+HTRefresh.h>
#import "HTDiscoverActivityModel.h"
#import "HTDiscoverActivityDetailController.h"

@interface HTDiscoverActivityController ()

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *modelArray;

@end

@implementation HTDiscoverActivityController

- (void)viewDidLoad {
	[super viewDidLoad];
	[self initializeDataSource];
	[self initializeUserInterface];
}

- (void)initializeDataSource {
    __weak typeof(self) weakSelf = self;
    [self.tableView ht_setRefreshBlock:^(NSString *pageSize, NSString *currentPage) {
		HTNetworkModel *networkModel = [HTNetworkModel modelForOnlyCacheNoInterfaceForScrollViewWithCacheStyle:HTCacheStyleAllUser];
		[HTRequestManager requestActivityListWithNetworkModel:networkModel pageSize:pageSize currentPage:currentPage complete:^(id response, HTError *errorModel) {
			if (errorModel.existError) {
				[weakSelf.tableView ht_endRefreshWithModelArrayCount:errorModel.errorType];
				return;
			}
			NSMutableArray *modelArray = [HTDiscoverActivityModel mj_objectArrayWithKeyValuesArray:response[@"data"][@"data"]];
			[weakSelf.tableView ht_endRefreshWithModelArrayCount:modelArray.count];
			if (currentPage.integerValue == 1) {
				weakSelf.modelArray = modelArray;
			} else {
				[weakSelf.modelArray addObjectsFromArray:modelArray];
			}
			[weakSelf.tableView ht_updateSection:0 sectionMakerBlock:^(HTTableViewSectionMaker *sectionMaker) {
				sectionMaker.modelArray(weakSelf.modelArray);
			}];
		}];
    }];
    [self.tableView ht_startRefreshHeader];
}

- (void)initializeUserInterface {
    self.navigationItem.title = @"留学活动";
    [self.view addSubview:self.tableView];
    [self.tableView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
    }];
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] init];
        
        __weak typeof(self) weakSelf = self;
        [_tableView ht_updateSection:0 sectionMakerBlock:^(HTTableViewSectionMaker *sectionMaker) {
            [sectionMaker.cellClass([HTDiscoverActivityCell class]) didSelectedCellBlock:^(UITableView *tableView, NSInteger row, __kindof UITableViewCell *cell, __kindof HTDiscoverActivityModel *model) {
                HTDiscoverActivityDetailController *detailController = [[HTDiscoverActivityDetailController alloc] init];
                detailController.activityIdString = model.ID;
                [weakSelf.navigationController pushViewController:detailController animated:true];
            }];
        }];
    }
    return _tableView;
}

@end
