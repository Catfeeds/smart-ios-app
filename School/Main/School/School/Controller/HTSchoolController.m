//
//  HTSchoolController.m
//  School
//
//  Created by hublot on 2017/9/21.
//  Copyright © 2017年 hublot. All rights reserved.
//

#import "HTSchoolController.h"
#import "HTSchoolModel.h"
#import <UIScrollView+HTRefresh.h>
#import <UITableView+HTSeparate.h>
#import "HTUserActionManager.h"
#import "HTUserHistoryManager.h"
#import "HTUserStoreManager.h"
#import "HTStoreBarButtonItem.h"
#import "HTSchoolSectionModel.h"
#import "HTSchoolSectionHeaderView.h"
#import "HTSchoolHeaderView.h"

@interface HTSchoolController ()

@property (nonatomic, strong) HTSchoolHeaderView *schoolHeaderView;

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation HTSchoolController

- (void)viewDidLoad {
	[super viewDidLoad];
	[self initializeDataSource];
	[self initializeUserInterface];
}

- (void)initializeDataSource {
	
	__weak typeof(self) weakSelf = self;
	[self.tableView ht_setRefreshBlock:^(NSString *pageSize, NSString *currentPage) {
		HTNetworkModel *networkModel = [HTNetworkModel modelForOnlyCacheNoInterfaceForScrollViewWithCacheStyle:HTCacheStyleAllUser];
		[HTRequestManager requestSchoolDetailWithNetworkModel:networkModel schoolId:weakSelf.schoolIdString complete:^(id response, HTError *errorModel) {
			if (errorModel.existError) {
				[weakSelf.tableView ht_endRefreshWithModelArrayCount:errorModel.errorType];
				return;
			}
			HTSchoolModel *schoolModel = [HTSchoolModel mj_objectWithKeyValues:response[@"data"]];
			schoolModel.major = [HTSchoolProfessionalModel mj_objectArrayWithKeyValuesArray:response[@"major"]];
			schoolModel.country = [NSString stringWithFormat:@"%@",response[@"country"]];
			weakSelf.navigationItem.title = schoolModel.name;
			[weakSelf.tableView ht_endRefreshWithModelArrayCount:1];

			NSString *schoolIdString = HTPlaceholderString(weakSelf.schoolIdString, @"");
			[HTUserActionManager trackUserActionWithType:HTUserActionTypeVisitSchoolDetail keyValue:@{@"id":schoolIdString}];
			[HTUserHistoryManager appendHistoryModel:[HTUserHistoryModel packHistoryModelType:HTUserHistoryTypeSchoolDetail lookId:schoolIdString titleName:schoolModel.name]];

			HTUserStoreModel *model = [HTUserStoreModel packStoreModelType:HTUserStoreTypeSchool lookId:schoolModel.ID titleName:schoolModel.name];
			HTStoreBarButtonItem *storeBarButtonItem = [[HTStoreBarButtonItem alloc] initWithTapHandler:^(HTStoreBarButtonItem *item) {
				[HTUserStoreManager switchStoreStateWithModel:model];
				item.selected = [HTUserStoreManager isStoredWithModel:model];
			}];
			storeBarButtonItem.selected = [HTUserStoreManager isStoredWithModel:model];
			weakSelf.navigationItem.rightBarButtonItem = storeBarButtonItem;

			[weakSelf.schoolHeaderView setModel:schoolModel];
			weakSelf.tableView.tableHeaderView = weakSelf.schoolHeaderView;
			NSArray *sectionModelArray = [HTSchoolSectionModel packModelArrayWithSchoolModel:schoolModel];
			[sectionModelArray enumerateObjectsUsingBlock:^(HTSchoolSectionModel *sectionModel, NSUInteger index, BOOL * _Nonnull stop) {
				[weakSelf.tableView ht_updateSection:index sectionMakerBlock:^(HTTableViewSectionMaker *sectionMaker) {
					[[sectionMaker.headerClass(sectionModel.headerClass).headerHeight(sectionModel.headerHeight) customHeaderBlock:^(UITableView *tableView, NSInteger section, __kindof HTSchoolSectionHeaderView *reuseView, __kindof NSArray *modelArray) {
						[reuseView setTitleName:sectionModel.titleName];
					}].cellClass(sectionModel.cellClass).rowHeight(sectionModel.cellHeigith).modelArray(sectionModel.modelArray) didSelectedCellBlock:^(UITableView *tableView, NSInteger row, __kindof UITableViewCell *cell, __kindof NSObject *model) {
						
					}].footerHeight(sectionModel.footerHeight);
				}];
			}];
			
		}];
	}];
	[self.tableView ht_startRefreshHeader];
}

- (void)initializeUserInterface {
	self.navigationItem.title = @"学校详情";
	[self.view addSubview:self.tableView];
}

- (UITableView *)tableView {
	if (!_tableView) {
		_tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
		_tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
		_tableView.backgroundColor = [UIColor ht_colorString:@"f3f3f3"];
	}
	return _tableView;
}

- (HTSchoolHeaderView *)schoolHeaderView {
	if (!_schoolHeaderView) {
		_schoolHeaderView = [[HTSchoolHeaderView alloc] initWithFrame:CGRectMake(0, 0, 0, 200)];
	}
	return _schoolHeaderView;
}

@end
