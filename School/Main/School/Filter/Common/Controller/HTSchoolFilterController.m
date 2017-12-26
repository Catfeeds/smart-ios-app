//
//  HTSchoolFilterController.m
//  School
//
//  Created by hublot on 17/8/14.
//  Copyright © 2017年 hublot. All rights reserved.
//

#import "HTSchoolFilterController.h"
#import "HTSchoolFilterModel.h"
#import <UITableView+HTSeparate.h>
#import <UIScrollView+HTRefresh.h>
#import "HTFilterResultSchoolController.h"
#import "HTFilterResultSchoolModel.h"
#import "HTFilterResultSchoolCell.h"
#import "HTDropBoxView.h"

@interface HTSchoolFilterController ()

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) HTSchoolFilterModel *filterModel;

@property (nonatomic, strong) HTDropBoxView *filterHeaderView;

@property (nonatomic, strong) NSMutableArray *filterResultArray;

@property (nonatomic, strong) NSString *seletedCountry;
@property (nonatomic, strong) NSString *seltedRank;
@property (nonatomic, strong) NSString *seletedProfessional;

@end

@implementation HTSchoolFilterController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initializeDataSource];
    [self initializeUserInterface];
}

- (void)selectFilter:(NSNotification *)notification{
    
}

- (void)initializeDataSource {
    
    __weak typeof(self) weakSelf = self;
    [self.tableView ht_setRefreshBlock:^(NSString *pageSize, NSString *currentPage) {
        if (!weakSelf.filterModel) {
            [weakSelf requestFilterModel];
		} else {
			[weakSelf requestSchoolModelArrayPageSize:pageSize currentPage:currentPage];
		}
    }];
    [self.tableView ht_startRefreshHeader];
}

- (void)requestFilterModel {
    HTNetworkModel *networkModel = [HTNetworkModel modelForOnlyCacheNoInterfaceForScrollViewWithCacheStyle:HTCacheStyleAllUser];
    
    __weak typeof(self) weakSelf = self;
    [HTRequestManager requestSchoolFilterParameterWithNetworkModel:networkModel complete:^(id response, HTError *errorModel) {
        if (errorModel.existError) {
            [self.tableView ht_endRefreshWithModelArrayCount:errorModel.errorType];
            return;
        }
        HTSchoolFilterModel *filterModel = [HTSchoolFilterModel mj_objectWithKeyValues:response];
        self.filterModel = filterModel;
		[weakSelf.tableView ht_endRefreshWithModelArrayCount:filterModel.filterModelArray.count];
		
		[weakSelf.tableView ht_startRefreshHeader];
		weakSelf.filterHeaderView.titleModelArray = [filterModel.filterModelArray mutableCopy];
		[weakSelf.filterHeaderView setSureReloadBlock:^{
            [weakSelf setChooseResultForTitle];
			[weakSelf.tableView ht_startRefreshHeader];
		}];
		[weakSelf.filterHeaderView reloadData];
    }];
}

- (void)requestSchoolModelArrayPageSize:(NSString *)pageSize currentPage:(NSString *)currentPage {
    HTNetworkModel *networkModel = [HTNetworkModel modelForOnlyCacheNoInterfaceForScrollViewWithCacheStyle:HTCacheStyleAllUser];
	__weak typeof(self) weakSelf = self;
	__block NSString *countryIdString = nil;
	__block NSString *rankIdString = nil;
	__block NSString *professionalIdString = nil;
	[self.filterModel.filterModelArray enumerateObjectsUsingBlock:^(HTSchoolFilterSelectedModel *selectedModel, NSUInteger index, BOOL * _Nonnull stop) {
		__block id <HTDropBoxProtocol> model;
		__block NSString *selectedIdString;
		[selectedModel.selectedModelArray enumerateObjectsUsingBlock:^(id <HTDropBoxProtocol> contentModel, NSUInteger index, BOOL * _Nonnull stop) {
			if (contentModel.isSelected) {
				model = contentModel;
				selectedIdString = contentModel.ID;
				*stop = true;
			}
		}];
		if ([selectedIdString integerValue] <= 0) {
			selectedIdString = nil;
		}
		if (selectedModel.type == HTFilterTypeCountry) {
			countryIdString = selectedIdString;
		} else if (selectedModel.type == HTFilterTypeRank) {
			rankIdString = selectedIdString;
		} else if (selectedModel.type == HTFilterTypeMajor) {
			[model.selectedModelArray enumerateObjectsUsingBlock:^(id <HTDropBoxProtocol> majorModel, NSUInteger index, BOOL * _Nonnull stop) {
				if (majorModel.isSelected) {
					selectedIdString = majorModel.ID;
					*stop = true;
				}
			}];
			professionalIdString = selectedIdString;
		}
	}];
	[HTRequestManager requestSchoolFilterListWithNetworkModel:networkModel countryIdString:countryIdString rankIdString:rankIdString professionalIdString:professionalIdString currentPage:currentPage pageSize:pageSize complete:^(id response, HTError *errorModel) {
		if (errorModel.existError) {
			[self.tableView ht_endRefreshWithModelArrayCount:errorModel.errorType];
			return;
		}
		NSMutableArray *filterResultArray = [HTFilterResultSchoolModel mj_objectArrayWithKeyValuesArray:response[@"data"]];
		if (currentPage.integerValue <= 1) {
			self.filterResultArray = filterResultArray;
		} else {
			[self.filterResultArray addObjectsFromArray:filterResultArray];
		}
		[self.tableView ht_endRefreshWithModelArrayCount:filterResultArray.count];
		[self.tableView ht_updateSection:0 sectionMakerBlock:^(HTTableViewSectionMaker *sectionMaker) {
			sectionMaker.modelArray(weakSelf.filterResultArray);
		}];
	}];
}


- (void)setChooseResultForTitle{
    __block NSString *countryString = nil;
    __block NSString *rankString = nil;
    __block NSString *professionalString = nil;
    [self.filterModel.filterModelArray enumerateObjectsUsingBlock:^(HTSchoolFilterSelectedModel *selectedModel, NSUInteger index, BOOL * _Nonnull stop) {
        __block id <HTDropBoxProtocol> model;
        __block NSString *selectedString;
        [selectedModel.selectedModelArray enumerateObjectsUsingBlock:^(id <HTDropBoxProtocol> contentModel, NSUInteger index, BOOL * _Nonnull stop) {
            if (contentModel.isSelected) {
                model = contentModel;
                selectedString = contentModel.title;
                *stop = true;
            }
        }];
        if (selectedModel.type == HTFilterTypeCountry) {
            countryString = selectedString;
        } else if (selectedModel.type == HTFilterTypeRank) {
            rankString = selectedString;
        } else if (selectedModel.type == HTFilterTypeMajor) {
            [model.selectedModelArray enumerateObjectsUsingBlock:^(id <HTDropBoxProtocol> majorModel, NSUInteger index, BOOL * _Nonnull stop) {
                if (majorModel.isSelected) {
                    selectedString = majorModel.title;
                    *stop = true;
                }
            }];
            professionalString = selectedString;
        }
    }];
    self.seletedCountry      = countryString ? countryString : @"所在国家";
    self.seltedRank          = rankString ?   rankString : @"综合排名";
    self.seletedProfessional = professionalString ? professionalString : @"专业方向";
    NSMutableArray <HTDropBoxProtocol> *newTitleSelecetd = [NSMutableArray <HTDropBoxProtocol> array];
    [self.filterModel.filterModelArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        HTSchoolFilterSelectedModel *model = obj;
        if (model.type == HTFilterTypeCountry)  model.title = self.seletedCountry;
        if (model.type == HTFilterTypeRank)     model.title = self.seltedRank;
        if (model.type == HTFilterTypeMajor)     model.title = self.seletedProfessional;
        [newTitleSelecetd addObject:model];
        
    }];
    self.filterHeaderView.titleModelArray  = newTitleSelecetd;
    
}

- (void)initializeUserInterface {
    self.automaticallyAdjustsScrollViewInsets = false;
    self.navigationItem.title = @"院校查询";
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.filterHeaderView];
	[self.filterHeaderView mas_updateConstraints:^(MASConstraintMaker *make) {
		make.top.mas_equalTo(64);
		make.left.right.bottom.mas_equalTo(self.view);
	}];
    [self.tableView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(64 + 40);
		make.left.right.bottom.mas_equalTo(self.view);
    }];
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero];
        _tableView.backgroundColor = [UIColor ht_colorStyle:HTColorStyleCompareBackground];
        
        __weak typeof(self) weakSelf = self;
        [_tableView ht_updateSection:0 sectionMakerBlock:^(HTTableViewSectionMaker *sectionMaker) {
			[[[sectionMaker.cellClass([HTFilterResultSchoolCell class]) didSelectedCellBlock:^(UITableView *tableView, NSInteger row, __kindof UITableViewCell *cell, __kindof HTFilterResultSchoolModel *model) {
				HTFilterResultSchoolController *schoolController = [[HTFilterResultSchoolController alloc] init];
				schoolController.resultSchoolModel = model;
				[weakSelf.navigationController pushViewController:schoolController animated:true];
			}] willEndDraggingBlock:^(UIScrollView *scrollView, CGPoint contentOffSet, UIEdgeInsets contentInSet, CGPoint velocity, CGPoint targetContentOffSet) {
				//                if (velocity.y > 0.5) {
				//                    if (!weakSelf.filterHeaderView.selectedHidden) {
				//                        [weakSelf.filterHeaderView setSelectedHidden:true duration:0.4];
				//                    }
				//                } else if (velocity.y < - 1) {
				//                    if (weakSelf.filterHeaderView.selectedHidden) {
				//                        [weakSelf.filterHeaderView setSelectedHidden:false duration:0.4];
				//                    }
				//                }
			}] customCellBlock:^(UITableView *tableView, NSInteger row, __kindof UITableViewCell *cell, __kindof NSObject *model) {
				
			}] ;
        }];
    }
    return _tableView;
}

- (HTDropBoxView *)filterHeaderView {
    if (!_filterHeaderView) {
        _filterHeaderView = [[HTDropBoxView alloc] init];
    }
    return _filterHeaderView;
}


@end
