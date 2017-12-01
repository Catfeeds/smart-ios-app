//
//  HTSchoolHotDetailController.m
//  School
//
//  Created by hublot on 2017/6/16.
//  Copyright © 2017年 hublot. All rights reserved.
//

#import "HTSchoolHotDetailController.h"
#import <UITableView+HTSeparate.h>
#import "HTSchoolHotDetailCell.h"
#import "HTSchoolController.h"
#import "HTSchoolMatriculateSingleController.h"
#import <UIScrollView+HTRefresh.h>
#import "HTSchoolHotModel.h"

@interface HTSchoolHotDetailController ()

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation HTSchoolHotDetailController

- (void)viewDidLoad {
	[super viewDidLoad];
	[self initializeDataSource];
	[self initializeUserInterface];
}

- (void)initializeDataSource {
	
	__weak typeof(self) weakSelf = self;
	[self.tableView ht_setRefreshBlock:^(NSString *pageSize, NSString *currentPage) {
		HTNetworkModel *networkModel = [HTNetworkModel modelForOnlyCacheNoInterfaceForScrollViewWithCacheStyle:HTCacheStyleAllUser];
		[HTRequestManager requestHotSchoolListWithNetworkModel:networkModel currentPage:currentPage pageSize:pageSize complete:^(id response, HTError *errorModel) {
			if (errorModel.existError) {
				[weakSelf.tableView ht_endRefreshWithModelArrayCount:errorModel.errorType];
				return;
			}
			NSArray *modelArray = [HTSchoolHotModel mj_objectArrayWithKeyValuesArray:response];
			[weakSelf.tableView ht_endRefreshWithModelArrayCount:modelArray.count];
			[weakSelf.tableView ht_updateSection:0 sectionMakerBlock:^(HTTableViewSectionMaker *sectionMaker) {
				sectionMaker.modelArray(modelArray);
			}];
		}];
	}];
	[self.tableView ht_startRefreshHeader];
}

- (void)initializeUserInterface {
	self.navigationItem.title = @"热门学校";
	[self.view addSubview:self.tableView];
	[self.tableView mas_updateConstraints:^(MASConstraintMaker *make) {
		make.edges.mas_equalTo(UIEdgeInsetsZero);
	}];
}

- (UITableView *)tableView {
	if (!_tableView) {
		_tableView = [[UITableView alloc] init];
		_tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
		
		__weak HTSchoolHotDetailController *weakSelf = self;
		_tableView.ht_pageSize = 11;
		[_tableView ht_updateSection:0 sectionMakerBlock:^(HTTableViewSectionMaker *sectionMaker) {
			[sectionMaker.cellClass([HTSchoolHotDetailCell class]).rowHeight(120) didSelectedCellBlock:^(UITableView *tableView, NSInteger row, __kindof UITableViewCell *cell, __kindof HTSchoolHotModel *model) {
				HTSchoolController *schoolController = [[HTSchoolController alloc] init];
				schoolController.schoolIdString = model.ID;
				[weakSelf.navigationController pushViewController:schoolController animated:true];
			}];
		}];
	}
	return _tableView;
}


@end
