//
//  HTMatriculateSearchController.m
//  School
//
//  Created by hublot on 2017/9/19.
//  Copyright © 2017年 hublot. All rights reserved.
//

#import "HTMatriculateSearchController.h"
#import <NSObject+HTObjectCategory.h>
#import <UITableView+HTSeparate.h>
#import <UIScrollView+HTRefresh.h>
#import <HTKeyboardController.h>
#import "HTSchoolMatriculateSelectedCell.h"
#import "HTRootNavigationController.h"
#import "HTManagerController.h"
#import "HTSchoolMatriculateModel.h"

@interface HTMatriculateSearchController () <UISearchBarDelegate>

@property (nonatomic, strong) UISearchBar *searchBar;

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *modelArray;

@property (nonatomic, strong) HTSchoolMatriculateSelectedModel *matriculateModel;

@property (nonatomic, copy) HTMatriculateSearchSelectedBlock selectedBlock;

@end

@implementation HTMatriculateSearchController

+ (void)presentSearchControllerAnimated:(BOOL)animated matriculateModel:(HTSchoolMatriculateSelectedModel *)matriculateModel selectedBlock:(HTMatriculateSearchSelectedBlock)selectedBlock {
	HTMatriculateSearchController *searchController = [[HTMatriculateSearchController alloc] init];
	searchController.selectedBlock = selectedBlock;
	searchController.matriculateModel = matriculateModel;

	[searchController.searchBar becomeFirstResponder];
	HTRootNavigationController *navigationController = [[HTRootNavigationController alloc] initWithRootViewController:searchController];
	[[HTManagerController defaultManagerController] presentViewController:navigationController animated:animated completion:^{
		
	}];
}

- (void)viewWillDisappear:(BOOL)animated {
	[super viewWillDisappear:animated];
	[self.searchBar endEditing:animated];
}

- (void)viewDidLoad {
	[super viewDidLoad];
	[self initializeDataSource];
	[self initializeUserInterface];
}

- (void)initializeDataSource {
	
}

- (void)initializeUserInterface {
	self.navigationItem.titleView = self.searchBar;
	[self.searchBar sizeToFit];
	[self.view addSubview:self.tableView];
}

- (void)searchDispatchTimeSelector {
	
	__weak typeof(self) weakSelf = self;
	[self.tableView ht_setRefreshBlock:^(NSString *pageSize, NSString *currentPage) {
		HTNetworkModel *networkModel = [HTNetworkModel modelForOnlyCacheNoInterfaceForScrollViewWithCacheStyle:HTCacheStyleAllUser];
		[HTRequestManager requestSearchSchoolOrMajorListWithNetworkModel:networkModel parameter:@{@"school":HTPlaceholderString(weakSelf.searchBar.text, @"")} pageSize:pageSize currentPage:currentPage complete:^(id response, HTError *errorModel) {
			if (errorModel.existError) {
				[weakSelf.tableView ht_endRefreshWithModelArrayCount:errorModel.errorType];
				return;
			}
			NSMutableArray *modelArray = [HTSchoolModel mj_objectArrayWithKeyValuesArray:response[@"data"]];
			[weakSelf.tableView ht_endRefreshWithModelArrayCount:modelArray.count];
			if (currentPage.integerValue > 1) {
				[weakSelf.modelArray addObjectsFromArray:modelArray];
			} else {
				weakSelf.modelArray = modelArray;
			}
			[weakSelf.tableView ht_updateSection:0 sectionMakerBlock:^(HTTableViewSectionMaker *sectionMaker) {
				sectionMaker.modelArray(weakSelf.modelArray);
			}];
		}];
	}];
	[self.tableView ht_startRefreshHeader];
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
	[NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(searchDispatchTimeSelector) object:nil];
	[self performSelector:@selector(searchDispatchTimeSelector) withObject:nil afterDelay:0.3];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
	[HTKeyboardController resignFirstResponder];
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
	[self dismissViewControllerAnimated:true completion:nil];
}

- (UISearchBar *)searchBar {
	if (!_searchBar) {
		_searchBar = [[UISearchBar alloc] init];
		_searchBar.placeholder = @"搜索更多学校";
		_searchBar.tintColor = [UIColor whiteColor];
		_searchBar.showsCancelButton = true;
		_searchBar.delegate = self;
		
		UIButton *cancelButton = [_searchBar ht_valueForSelector:NSSelectorFromString(@"_cancelButton") runtime:false];
		[cancelButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
	}
	return _searchBar;
}

- (UITableView *)tableView {
	if (!_tableView) {
		_tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
		_tableView.separatorColor = [UIColor ht_colorString:@"f0f0f0"];
		_tableView.backgroundColor = _tableView.separatorColor;
		_tableView.ht_pageSize = 30;
		
		__weak typeof(self) weakSelf = self;
		[_tableView ht_updateSection:0 sectionMakerBlock:^(HTTableViewSectionMaker *sectionMaker) {
			[sectionMaker.cellClass([HTSchoolMatriculateSelectedCell class]).rowHeight(45) didSelectedCellBlock:^(UITableView *tableView, NSInteger row, __kindof UITableViewCell *cell, __kindof HTSchoolModel *model) {
				model.isSelected = true;
				if (weakSelf.matriculateModel) {
					weakSelf.matriculateModel.pickerModelArray = @[model];
				}
				
				[weakSelf dismissViewControllerAnimated:true completion:^{
					if (weakSelf.selectedBlock) {
						weakSelf.selectedBlock(model);
					}
				}];
			}];
		}];
	}
	return _tableView;
}

@end
