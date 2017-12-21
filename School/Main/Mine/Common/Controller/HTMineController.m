//
//  HTMineController.m
//  School
//
//  Created by hublot on 2017/6/14.
//  Copyright © 2017年 hublot. All rights reserved.
//

#import "HTMineController.h"
#import "HTLoginManager.h"
#import "HTMineHeaderView.h"
#import "HTMineCell.h"
#import "HTMineModel.h"
#import <UITableView+HTSeparate.h>
#import "HTIssueController.h"
#import "HTUserManager.h"
#import "HTMatriculateRecordController.h"
#import "HTIndexAdvisorController.h"
#import "HTHistoryController.h"
#import "HTMinePreferenceController.h"
#import "HTBackgroundController.h"

@interface HTMineController ()

@property (nonatomic, strong) HTMineHeaderView *headerView;

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation HTMineController

- (void)viewDidLoad {
	[super viewDidLoad];
	[self initializeDataSource];
	[self initializeUserInterface];
}

- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
	[HTUserManager updateUserDetailComplete:^(BOOL success) {
	}];
}

- (void)initializeDataSource {
	
}

- (void)initializeUserInterface {
	self.view.backgroundColor = [UIColor ht_colorStyle:HTColorStyleCompareBackground];
	[self.navigationController setNavigationBarHidden:true animated:false];
	self.automaticallyAdjustsScrollViewInsets = false;
	UIView *backgroundView = [[UIView alloc] init];
	[backgroundView addSubview:self.headerView];
	self.tableView.backgroundView = backgroundView;
	[self.view addSubview:self.tableView];
}

- (UITableView *)tableView {
	if (!_tableView) {
		_tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height - 49) style:UITableViewStyleGrouped];
		
		_tableView.backgroundColor = [UIColor ht_colorStyle:HTColorStyleCompareBackground];
		_tableView.separatorColor = [UIColor ht_colorString:@"ebebeb"];
		//		NSArray *modelArray = [HTMineModel packModelArray];
		
		
		__weak typeof(self) weakSelf = self;
		
		[_tableView ht_updateSection:0 sectionMakerBlock:^(HTTableViewSectionMaker *sectionMaker) {
			NSArray *array = [HTMineModel itemArrayWithSectionIndex:0];
			[sectionMaker.cellClass([HTMineCell class]).rowHeight(75).footerHeight(15).modelArray(array) didSelectedCellBlock:^(UITableView *tableView, NSInteger row, __kindof UITableViewCell *cell, __kindof HTMineModel *model) {
				[self pushControllerWithType:model.type];
			}];
		}];
		[_tableView ht_updateSection:1 sectionMakerBlock:^(HTTableViewSectionMaker *sectionMaker) {
			
			NSArray *array = [HTMineModel itemArrayWithSectionIndex:1];
			[sectionMaker.cellClass([HTMineCell class]).rowHeight(75).footerHeight(15).modelArray(array) didSelectedCellBlock:^(UITableView *tableView, NSInteger row, __kindof UITableViewCell *cell, __kindof HTMineModel *model) {
				[self pushControllerWithType:model.type];
				
			}];
		}];
		[_tableView ht_updateSection:2 sectionMakerBlock:^(HTTableViewSectionMaker *sectionMaker) {
			NSArray *array = [HTMineModel itemArrayWithSectionIndex:2];
			[sectionMaker.cellClass([HTMineCell class]).rowHeight(75).modelArray(array) didSelectedCellBlock:^(UITableView *tableView, NSInteger row, __kindof UITableViewCell *cell, __kindof HTMineModel *model) {
				[self pushControllerWithType:model.type];
				
			}];
		}];
		CGFloat normalHeaderHeight = 300;
		_tableView.contentInset = UIEdgeInsetsMake(normalHeaderHeight, 0, 0, 0);
		_tableView.scrollIndicatorInsets = _tableView.contentInset;
		[_tableView bk_addObserverForKeyPath:NSStringFromSelector(@selector(contentOffset)) options:NSKeyValueObservingOptionInitial task:^(id obj, NSDictionary *change) {
			CGFloat contentOffsetY = weakSelf.tableView.contentOffset.y;
			CGRect headerFrame = self.headerView.frame;
			if (- contentOffsetY <= normalHeaderHeight) {
				headerFrame.origin.y = - normalHeaderHeight - contentOffsetY;
				headerFrame.size.height = normalHeaderHeight;
			} else {
				headerFrame.origin.y = 0;
				headerFrame.size.height = - contentOffsetY;
			}
			
			weakSelf.headerView.frame = headerFrame;
		}];
		[_tableView scrollRectToVisible:CGRectMake(0, 0, 1, 1) animated:false];
	}
	return _tableView;
}


- (void)pushControllerWithType:(HTMineType)type{
	UIViewController *viewController = nil;
	switch (type) {
		case HTMineTypeMatriculate: {
			HTMatriculateRecordController *matriculateController = [[HTMatriculateRecordController alloc] init];
			viewController = matriculateController;
			break;
		}
		case HTMineTypeRecent:{
			HTHistoryController *historyController = [[HTHistoryController alloc] init];
			viewController = historyController;
			break;
		}
		case HTMineTypeInformation: {
			HTMinePreferenceController *preferenceController = [[HTMinePreferenceController alloc] init];
			viewController = preferenceController;
			break;
		}
		case HTMineTypeService: {
//            HTIndexAdvisorController *advisorController = [[HTIndexAdvisorController alloc] init];
            HTBackgroundController *backgroundController = [[HTBackgroundController alloc] init];
			viewController = backgroundController;
			break;
		}
		case HTMineTypeMoney: {
			break;
		}
		case HTMineTypeGood: {
			[HTRequestManager requestOpenAppStore];
			break;
		}
		case HTMineTypeSeting: {
			break;
		}
		case HTMineTypeProgress:{
			break;
		}
		case HTMineTypeIssue: {
			HTIssueController *issueController = [[HTIssueController alloc] init];
			viewController = issueController;
			break;
		}
		default:{
			
		}
	}
	if (viewController) {
		[self.navigationController pushViewController:viewController animated:true];
	}
}

- (HTMineHeaderView *)headerView {
	if (!_headerView) {
		_headerView = [[HTMineHeaderView alloc] initWithFrame:CGRectMake(0, 0, HTSCREENWIDTH, 0)];
	}
	return _headerView;
}


@end
