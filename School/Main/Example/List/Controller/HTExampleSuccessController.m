//
//  HTExampleSuccessController.m
//  School
//
//  Created by hublot on 2017/9/27.
//  Copyright © 2017年 hublot. All rights reserved.
//

#import "HTExampleSuccessController.h"
#import <UIScrollView+HTRefresh.h>
#import <UITableView+HTSeparate.h>
#import "HTDiscoverExampleModel.h"
#import "HTDiscoverExampleContentCell.h"
#import "HTDiscoverExampleDetailController.h"

@interface HTExampleSuccessController ()

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *modelArray;

@end

@implementation HTExampleSuccessController

- (void)viewDidLoad {
	[super viewDidLoad];
	[self initializeDataSource];
	[self initializeUserInterface];
}

- (void)initializeDataSource {
	
	__weak typeof(self) weakSelf = self;
	[self.tableView ht_setRefreshBlock:^(NSString *pageSize, NSString *currentPage) {
		HTNetworkModel *networkModel = [HTNetworkModel modelForOnlyCacheNoInterfaceForScrollViewWithCacheStyle:HTCacheStyleAllUser];
		[HTRequestManager requestExampleListWithNetworkModel:networkModel catIdString:nil pageSize:pageSize currentPage:currentPage complete:^(id response, HTError *errorModel) {
			if (errorModel.existError) {
				[weakSelf.tableView ht_endRefreshWithModelArrayCount:errorModel.errorType];
				return;
			}
			NSMutableArray *modelArray = [HTDiscoverExampleModel mj_objectArrayWithKeyValuesArray:response[@"data"]];
			[weakSelf.tableView ht_endRefreshWithModelArrayCount:modelArray.count];
			if (currentPage.integerValue <= 1) {
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
	self.navigationItem.title = @"成功案例";
	[self.view addSubview:self.tableView];
}

- (UITableView *)tableView {
	if (!_tableView) {
		_tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
		
		__weak typeof(self) weakSelf = self;
		[_tableView ht_updateSection:0 sectionMakerBlock:^(HTTableViewSectionMaker *sectionMaker) {
			[sectionMaker.cellClass([HTDiscoverExampleContentCell class]).rowHeight(130) didSelectedCellBlock:^(UITableView *tableView, NSInteger row, __kindof UITableViewCell *cell, __kindof HTDiscoverExampleModel *model) {
				HTDiscoverExampleDetailController *detailController = [[HTDiscoverExampleDetailController alloc] init];
				detailController.exampleIdString = model.ID;
				detailController.exampleCatIdString = model.catId;
				[weakSelf.navigationController pushViewController:detailController animated:true];
			}];
		}];
	}
	return _tableView;
}

@end
