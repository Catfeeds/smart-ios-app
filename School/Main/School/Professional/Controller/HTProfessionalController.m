//
//  HTProfessionalController.m
//  School
//
//  Created by hublot on 2017/9/21.
//  Copyright © 2017年 hublot. All rights reserved.
//

#import "HTProfessionalController.h"
#import "HTProfessionalHeaderView.h"
#import "HTProfessionalSectionHeaderView.h"
#import "HTProfessionalSectionModel.h"
#import "HTProfessionalModel.h"
#import "HTUserActionManager.h"
#import "HTUserHistoryManager.h"
#import "HTUserStoreManager.h"
#import "HTStoreBarButtonItem.h"
#import <UIScrollView+HTRefresh.h>
#import <UITableView+HTSeparate.h>

@interface HTProfessionalController ()

@property (nonatomic, strong) HTProfessionalHeaderView *professionalHeaderView;

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation HTProfessionalController

- (void)viewDidLoad {
	[super viewDidLoad];
	[self initializeDataSource];
	[self initializeUserInterface];
}

- (void)initializeDataSource {
	
	__weak typeof(self) weakSelf = self;
	[self.tableView ht_setRefreshBlock:^(NSString *pageSize, NSString *currentPage) {
		HTNetworkModel *networkModel = [HTNetworkModel modelForOnlyCacheNoInterfaceForScrollViewWithCacheStyle:HTCacheStyleAllUser];
		[HTRequestManager requestProfessionalWithNetworkModel:networkModel professionalId:weakSelf.professionalId complete:^(id response, HTError *errorModel) {
			if (errorModel.existError) {
				[weakSelf.tableView ht_endRefreshWithModelArrayCount:errorModel.errorType];
				return;
			}
			HTProfessionalModel *professionalModel = [HTProfessionalModel mj_objectWithKeyValues:response];
			HTProfessionalDetailModel *detailModel = professionalModel.data.firstObject;
			[weakSelf.tableView ht_endRefreshWithModelArrayCount:1];
			weakSelf.navigationItem.title = [NSString stringWithFormat:@"%@", detailModel.name];
			NSString *professionalIdString = HTPlaceholderString(weakSelf.professionalId, @"");
			[HTUserActionManager trackUserActionWithType:HTUserActionTypeVisitProfessionalDetail keyValue:@{@"id":professionalModel}];
			[HTUserHistoryManager appendHistoryModel:[HTUserHistoryModel packHistoryModelType:HTUserHistoryTypeProfessionalDetail lookId:professionalIdString titleName:detailModel.name]];
			
			HTUserStoreModel *model = [HTUserStoreModel packStoreModelType:HTUserStoreTypeProfessional lookId:detailModel.ID titleName:detailModel.name];
			HTStoreBarButtonItem *storeBarButtonItem = [[HTStoreBarButtonItem alloc] initWithTapHandler:^(HTStoreBarButtonItem *item) {
				[HTUserStoreManager switchStoreStateWithModel:model];
				item.selected = [HTUserStoreManager isStoredWithModel:model];
			}];
			storeBarButtonItem.selected = [HTUserStoreManager isStoredWithModel:model];
			weakSelf.navigationItem.rightBarButtonItem = storeBarButtonItem;
			
			[weakSelf.professionalHeaderView setModel:professionalModel];
			weakSelf.tableView.tableHeaderView = weakSelf.professionalHeaderView;
			
			NSArray *sectionModelArray = [HTProfessionalSectionModel packModelArrayWithProfessionalModel:professionalModel];
			[sectionModelArray enumerateObjectsUsingBlock:^(HTProfessionalSectionModel *sectionModel, NSUInteger index, BOOL * _Nonnull stop) {
				[weakSelf.tableView ht_updateSection:index sectionMakerBlock:^(HTTableViewSectionMaker *sectionMaker) {
					[[sectionMaker.headerClass(sectionModel.headerClass).headerHeight(sectionModel.headerHeight) customHeaderBlock:^(UITableView *tableView, NSInteger section, __kindof HTProfessionalSectionHeaderView *reuseView, __kindof NSArray *modelArray) {
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
	self.navigationItem.title = @"专业详情";
	[self.view addSubview:self.tableView];
}

- (HTProfessionalHeaderView *)professionalHeaderView {
	if (!_professionalHeaderView) {
		_professionalHeaderView = [[HTProfessionalHeaderView alloc] initWithFrame:CGRectMake(0, 0, 0, 180)];
	}
	return _professionalHeaderView;
}

- (UITableView *)tableView {
	if (!_tableView) {
		_tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
		_tableView.backgroundColor = [UIColor whiteColor];
		_tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
		_tableView.allowsSelection = false;
		UIView *backgroundView = [[UIView alloc] init];
		CGFloat timeLineCenterX = [HTProfessionalSectionHeaderView timeLineCenterX];
		CGFloat lineWidth =  1 / [UIScreen mainScreen].scale;
		CGFloat lineLeft = timeLineCenterX - lineWidth / 2;
		UIView *separatorView = [[UIView alloc] initWithFrame:CGRectMake(lineLeft, 0, lineWidth, self.view.bounds.size.height)];
		separatorView.backgroundColor = [UIColor ht_colorStyle:HTColorStylePrimarySeparate];
		[backgroundView addSubview:separatorView];
		_tableView.backgroundView = backgroundView;
	}
	return _tableView;
}

@end
