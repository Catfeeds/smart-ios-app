//
//  HTSchoolRankController.m
//  School
//
//  Created by hublot on 2017/9/11.
//  Copyright © 2017年 hublot. All rights reserved.
//

#import "HTSchoolRankController.h"
#import "HTSchoolRankFilterView.h"
#import "HTSchoolRankCell.h"
#import "HTSchoolRankModel.h"
#import "HTSchoolRankFilterModel.h"
#import <UIScrollView+HTRefresh.h>
#import <UITableView+HTSeparate.h>

@interface HTSchoolRankController ()

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) HTSchoolRankFilterView *filterView;

@property (nonatomic, strong) NSMutableArray *modelArray;

@end

@implementation HTSchoolRankController

- (void)viewDidLoad {
	[super viewDidLoad];
	[self initializeDataSource];
	[self initializeUserInterface];
}

- (void)initializeDataSource {
	__weak typeof(self) weakSelf = self;
	[self.tableView ht_setRefreshBlock:^(NSString *pageSize, NSString *currentPage) {
		if (!weakSelf.filterView.isReloadClassSuccess) {
			[weakSelf requestRankClassModel];
		} else {
			[weakSelf reloadTableSelectedRefreshWithCurrentPage:currentPage pageSize:pageSize];
		}
	}];
	[self.tableView ht_startRefreshHeader];
}

- (void)requestRankClassModel {
	__weak typeof(self) weakSelf = self;
	[self.filterView requestFilterClassComplete:^(id response, HTError *errorModel) {
		if (errorModel.existError) {
			[weakSelf.tableView ht_endRefreshWithModelArrayCount:errorModel.errorType];
			return;
		}
		[weakSelf.tableView ht_endRefreshWithModelArrayCount:1];
		[weakSelf.tableView ht_startRefreshHeader];
	}];
}

- (void)initializeUserInterface {
	self.automaticallyAdjustsScrollViewInsets = false;
	self.navigationItem.title = @"大学排名";
	[self.view addSubview:self.tableView];
	[self.view addSubview:self.filterView];
	[self.filterView mas_updateConstraints:^(MASConstraintMaker *make) {
		make.left.right.mas_equalTo(self.view);
		make.top.mas_equalTo(64);
		make.height.mas_equalTo(self.filterView.ht_h);
	}];
	[self.tableView mas_updateConstraints:^(MASConstraintMaker *make) {
		make.left.right.bottom.mas_equalTo(self.view);
		make.top.mas_equalTo(self.filterView.mas_bottom);
	}];
}

- (void)reloadTableSelectedRefreshWithCurrentPage:(NSString *)currentPage pageSize:(NSString *)pageSize {
	NSString *selectedCategoryId = [self.filterView findSelectedModelIdWithType:HTSchoolRankFilterTypeCategory];
	NSString *selectedYearId = [self.filterView findSelectedModelIdWithType:HTSchoolRankFilterTypeYear];
	
	__weak typeof(self) weakSelf = self;
	HTNetworkModel *networkModel = [HTNetworkModel modelForOnlyCacheNoInterfaceForScrollViewWithCacheStyle:HTCacheStyleAllUser];
	[HTRequestManager requestRankSchoolListWithNetworkModel:networkModel classIdString:selectedCategoryId yearIdString:selectedYearId currentPage:currentPage pageSize:pageSize complete:^(id response, HTError *errorModel) {
		if (errorModel.existError) {
			[weakSelf.tableView ht_endRefreshWithModelArrayCount:errorModel.errorType];
			return;
		}
		NSMutableArray *modelArray = [HTSchoolRankModel mj_objectArrayWithKeyValuesArray:response[@"data"]];
		[weakSelf.tableView ht_endRefreshWithModelArrayCount:modelArray.count];
		if (currentPage.integerValue <= 1) {
			weakSelf.modelArray = modelArray;
		} else {
			[weakSelf.modelArray addObjectsFromArray:modelArray];
		}
		[weakSelf.modelArray enumerateObjectsUsingBlock:^(HTSchoolRankModel *model, NSUInteger index, BOOL * _Nonnull stop) {
			[model reloadModelImageWithIndex:index];
		}];
		[weakSelf.tableView ht_updateSection:0 sectionMakerBlock:^(HTTableViewSectionMaker *sectionMaker) {
			sectionMaker.modelArray(weakSelf.modelArray);
		}];
	}];
}

- (UITableView *)tableView {
	if (!_tableView) {
		_tableView = [[UITableView alloc] init];
		_tableView.separatorColor = [UIColor ht_colorString:@"f3f3f3"];
		[_tableView ht_updateSection:0 sectionMakerBlock:^(HTTableViewSectionMaker *sectionMaker) {
			[sectionMaker.cellClass([HTSchoolRankCell class]).rowHeight(100) didSelectedCellBlock:^(UITableView *tableView, NSInteger row, __kindof UITableViewCell *cell, __kindof NSObject *model) {
				
			}];
		}];
	}
	return _tableView;
}

- (HTSchoolRankFilterView *)filterView {
	if (!_filterView) {
		_filterView = [[HTSchoolRankFilterView alloc] init];
		[_filterView reloadRankFilterHeight];
		
		__weak typeof(self) weakSelf = self;
		[_filterView setFilterDidChange:^() {
			[weakSelf.tableView ht_startRefreshHeader];
		}];
	}
	return _filterView;
}


@end
