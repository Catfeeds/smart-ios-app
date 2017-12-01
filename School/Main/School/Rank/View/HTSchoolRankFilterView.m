//
//  HTSchoolRankFilterView.m
//  School
//
//  Created by hublot on 2017/9/11.
//  Copyright © 2017年 hublot. All rights reserved.
//

#import "HTSchoolRankFilterView.h"
#import "HTSchoolRankFilterModel.h"
#import "HTSchoolRankFilterCell.h"
#import <UITableView+HTSeparate.h>

@interface HTSchoolRankFilterView ()

@property (nonatomic, strong) NSArray <HTSchoolRankFilterModel *> *filterModelArray;

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation HTSchoolRankFilterView

+ (CGFloat)rankFitlerCellHeight {
	return 60;
}

- (void)reloadRankFilterHeight {
	self.ht_h = self.filterModelArray.count * [self.class rankFitlerCellHeight];
}

- (void)requestFilterClassComplete:(HTUserTaskCompleteBlock)complete {
	
	__weak typeof(self) weakSelf = self;
	HTNetworkModel *networkModel = [HTNetworkModel modelForOnlyCacheNoInterfaceForScrollViewWithCacheStyle:HTCacheStyleAllUser];
	[HTRequestManager requestRankClassListWithNetworkModel:networkModel currentPage:nil pageSize:nil complete:^(id response, HTError *errorModel) {
		if (errorModel.existError) {
			if (complete) {
				complete(response, errorModel);
			}
			return;
		}
		NSArray <HTSchoolRankSelectedModel *> *classModelArray = [HTSchoolRankSelectedModel mj_objectArrayWithKeyValuesArray:response[@"class"]];
		classModelArray.firstObject.isSelected = true;
		
		[weakSelf.filterModelArray enumerateObjectsUsingBlock:^(HTSchoolRankFilterModel *filterModel, NSUInteger index, BOOL * _Nonnull stop) {
			if (filterModel.type == HTSchoolRankFilterTypeCategory) {
				filterModel.modelArray = classModelArray;
			}
		}];
		[weakSelf.tableView reloadData];
		weakSelf.isReloadClassSuccess = true;
		if (complete) {
			complete(response, errorModel);
		}
	}];
}

- (NSString *)findSelectedModelIdWithType:(HTSchoolRankFilterType)type {
	__block NSString *selectedId = nil;
	[self.filterModelArray enumerateObjectsUsingBlock:^(HTSchoolRankFilterModel *filterModel, NSUInteger idx, BOOL * _Nonnull stop) {
		if (filterModel.type == type && filterModel.selectedIndex >= 0 && filterModel.selectedIndex < filterModel.modelArray.count) {
			HTSchoolRankSelectedModel *selectedModel = filterModel.modelArray[filterModel.selectedIndex];
			selectedId = selectedModel.ID;
			*stop = true;
		}
	}];
	return selectedId;
}

- (void)didMoveToSuperview {
	self.layer.shadowColor = [UIColor grayColor].CGColor;
	self.layer.shadowOffset = CGSizeMake(3, 3);
	self.layer.shadowOpacity = 0.2;
	
	
	[self addSubview:self.tableView];
	[self.tableView mas_updateConstraints:^(MASConstraintMaker *make) {
		make.edges.mas_equalTo(UIEdgeInsetsZero);
	}];
}

- (UITableView *)tableView {
	if (!_tableView) {
		_tableView = [[UITableView alloc] init];
		_tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
		_tableView.allowsSelection = false;
		_tableView.scrollEnabled = false;
		
		__weak typeof(self) weakSelf = self;
		NSArray *modelArray = self.filterModelArray;
		CGFloat modelHeight = [self.class rankFitlerCellHeight];
		[_tableView ht_updateSection:0 sectionMakerBlock:^(HTTableViewSectionMaker *sectionMaker) {
			[sectionMaker.cellClass([HTSchoolRankFilterCell class]).modelArray(modelArray).rowHeight(modelHeight) customCellBlock:^(UITableView *tableView, NSInteger row, __kindof HTSchoolRankFilterCell *cell, __kindof NSObject *model) {
				[cell setReloadRankSelected:^{
					if (weakSelf.filterDidChange) {
						weakSelf.filterDidChange();
					}
				}];
			}];
		}];
	}
	return _tableView;
}


- (NSArray<HTSchoolRankFilterModel *> *)filterModelArray {
	if (!_filterModelArray) {
		_filterModelArray = [HTSchoolRankFilterModel packModelArray];
	}
	return _filterModelArray;
}

@end
