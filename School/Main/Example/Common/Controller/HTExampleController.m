//
//  HTExampleController.m
//  School
//
//  Created by hublot on 2017/9/21.
//  Copyright © 2017年 hublot. All rights reserved.
//

#import "HTExampleController.h"
#import "HTExampleHeaderView.h"
#import <UITableView+HTSeparate.h>
#import <UIScrollView+HTRefresh.h>
#import "HTExampleSectionHeaderView.h"
#import "HTExampleHeaderView.h"
#import "HTExampleSectionModel.h"
#import "HTDiscoverExampleModel.h"
#import "HTExampleSuccessController.h"
#import "HTDiscoverExampleDetailController.h"
#import "HTExampleSectionScrollView.h"
#import <MJRefresh.h>

@interface HTExampleController ()

@property (nonatomic, strong) HTExampleHeaderView *headerView;

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) HTExampleSectionScrollView *sectionScrollView;

@end

@implementation HTExampleController

- (void)viewDidLoad {
	[super viewDidLoad];
	[self initializeDataSource];
	[self initializeUserInterface];
}

- (void)initializeDataSource {
	
	__weak typeof(self) weakSelf = self;
	[self.tableView ht_setRefreshBlock:^(NSString *pageSize, NSString *currentPage) {
		if (currentPage.integerValue > 1) {
			[weakSelf.sectionScrollView refreshTableFooterModelArrayComplete:^{
				[weakSelf.tableView ht_endRefreshWithModelArrayCount:pageSize.integerValue];
			}];
			return;
		}
		HTNetworkModel *networkModel = [HTNetworkModel modelForOnlyCacheNoInterfaceForScrollViewWithCacheStyle:HTCacheStyleAllUser];
		[HTRequestManager requestExampleIndexWithNetworkModel:networkModel singleSectionItemCount:4 complete:^(id response, HTError *errorModel) {
			if (errorModel.existError) {
				[weakSelf.tableView ht_endRefreshWithModelArrayCount:errorModel.errorType];
				return;
			}
			weakSelf.tableView.tableHeaderView = weakSelf.headerView;
			[weakSelf.tableView ht_endRefreshWithModelArrayCount:pageSize.integerValue];
			NSArray *modelArray = [HTExampleSectionModel packModelArrayWithResponse:response];
			[modelArray enumerateObjectsUsingBlock:^(HTExampleSectionModel *sectionModel, NSUInteger index, BOOL * _Nonnull stop) {
				[weakSelf.tableView ht_updateSection:index sectionMakerBlock:^(HTTableViewSectionMaker *sectionMaker) {
					[[[sectionMaker.headerClass(sectionModel.headerClass).headerHeight(sectionModel.headerHeight) customHeaderBlock:^(UITableView *tableView, NSInteger section, __kindof HTExampleSectionHeaderView *reuseView, __kindof NSArray *modelArray) {
						switch (sectionModel.type) {
							case HTExampleSectionTypeHot: {
								[reuseView setSectionMoreBlock:^{
									HTExampleSuccessController *exampleController = [[HTExampleSuccessController alloc] init];
									[weakSelf.navigationController pushViewController:exampleController animated:true];
								} titleName:sectionModel.titleName];
								break;
							}
							case HTExampleSectionTypeSuccess: {
								[reuseView setSectionMoreBlock:^{
									HTExampleSuccessController *exampleController = [[HTExampleSuccessController alloc] init];
									[weakSelf.navigationController pushViewController:exampleController animated:true];
								} titleName:sectionModel.titleName];
								break;
							}
						}
					}].cellClass(sectionModel.cellClass).rowHeight(sectionModel.cellHeigith).modelArray(sectionModel.modelArray) didSelectedCellBlock:^(UITableView *tableView, NSInteger row, __kindof UITableViewCell *cell, __kindof HTDiscoverExampleModel *model) {
						HTDiscoverExampleDetailController *detailController = [[HTDiscoverExampleDetailController alloc] init];
						detailController.exampleIdString = model.ID;
						detailController.exampleCatIdString = model.catId;
						[weakSelf.navigationController pushViewController:detailController animated:true];
					}] didScrollBlock:^(UIScrollView *scrollView, CGPoint contentOffSet, UIEdgeInsets contentInSet) {
						CGFloat contentOffsetY = weakSelf.tableView.contentOffset.y;
						CGFloat contentSizeHeight = weakSelf.tableView.contentSize.height;
						CGFloat currentTableHeight = MAX(weakSelf.sectionScrollView.currentScrollController.tableView.contentSize.height, weakSelf.tableView.ht_h);
						CGFloat magicNaivtaionHeight = 44;
						if (contentOffsetY > contentSizeHeight) {
							weakSelf.sectionScrollView.currentScrollController.tableView.contentOffset = CGPointMake(0, contentOffsetY - contentSizeHeight);
						}
						weakSelf.sectionScrollView.frame = CGRectMake(0, contentSizeHeight + MAX(0, (contentOffsetY - contentSizeHeight)), weakSelf.tableView.ht_w, weakSelf.tableView.ht_h);
						weakSelf.tableView.contentInset = UIEdgeInsetsMake(0, 0, currentTableHeight + magicNaivtaionHeight, 0);
						weakSelf.tableView.mj_footer.ignoredScrollViewContentInsetBottom = weakSelf.tableView.contentInset.bottom;
					}];
				}];
			}];
		}];
	}];
	[self.tableView ht_startRefreshHeader];
}

- (void)initializeUserInterface {
	self.automaticallyAdjustsScrollViewInsets = false;
	self.navigationItem.title = @"案例";
	[self.view addSubview:self.tableView];
	[self.tableView addSubview:self.sectionScrollView];
}

- (HTExampleHeaderView *)headerView {
	if (!_headerView) {
		_headerView = [[HTExampleHeaderView alloc] initWithFrame:CGRectMake(0, 0, 0, 180)];
		
		__weak typeof(self) weakSelf = self;
		[_headerView ht_whenTap:^(UIView *view) {
			HTExampleSuccessController *exampleController = [[HTExampleSuccessController alloc] init];
			[weakSelf.navigationController pushViewController:exampleController animated:true];
		}];
	}
	return _headerView;
}

- (UITableView *)tableView {
	if (!_tableView) {
		_tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, self.view.bounds.size.width, self.view.bounds.size.height - 64 - 49) style:UITableViewStyleGrouped];
		_tableView.backgroundColor = [UIColor whiteColor];
		_tableView.separatorColor = [UIColor ht_colorString:@"f3f3f3"];
	}
	return _tableView;
}

- (HTExampleSectionScrollView *)sectionScrollView {
	if (!_sectionScrollView) {
		_sectionScrollView = [[HTExampleSectionScrollView alloc] initWithFrame:CGRectMake(0, 0, self.tableView.ht_w, self.tableView.ht_h)];
		
		__weak typeof(self) weakSelf = self;
		[_sectionScrollView setReloadHeightBlock:^() {
			[weakSelf.tableView.delegate scrollViewDidScroll:weakSelf.tableView];
		}];
	}
	return _sectionScrollView;
}

@end
