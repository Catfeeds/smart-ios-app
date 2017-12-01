//
//  HTIndexActivityController.m
//  School
//
//  Created by hublot on 2017/8/18.
//  Copyright © 2017年 hublot. All rights reserved.
//

#import "HTIndexActivityController.h"
#import <UITableView+HTSeparate.h>
#import "HTDiscoverActivityCell.h"
#import "HTRootNavigationController.h"
#import "HTDiscoverActivityDetailController.h"
#import "HTDiscoverActivityModel.h"

@interface HTIndexActivityController ()

@property (nonatomic, strong) NSMutableArray *modelArray;

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation HTIndexActivityController

- (void)viewDidLoad {
	[super viewDidLoad];
	[self initializeDataSource];
	[self initializeUserInterface];
}

- (void)initializeDataSource {
	
}

- (void)initializeUserInterface {
	[self.view addSubview:self.tableView];
	[self.tableView mas_updateConstraints:^(MASConstraintMaker *make) {
		make.edges.mas_equalTo(UIEdgeInsetsZero);
	}];
}

- (NSInteger)tableHeightReloadModelArray:(NSArray *)modelArray {
	__block CGFloat tableHeight = 0;
	_modelArray = [modelArray mutableCopy];
	
	__weak typeof(self) weakSelf = self;
	[self.tableView ht_updateSection:0 sectionMakerBlock:^(HTTableViewSectionMaker *sectionMaker) {
		sectionMaker.modelArray(weakSelf.modelArray);
	}];
	[self.tableView ht_updateSection:0 sectionMakerBlock:^(HTTableViewSectionMaker *sectionMaker) {
		tableHeight = sectionMaker.section.sumRowHeight;
	}];
	return tableHeight;
}

- (UITableView *)tableView {
	if (!_tableView) {
		_tableView = [[UITableView alloc] init];
		_tableView.scrollEnabled = false;
		
		__weak typeof(self) weakSelf = self;
		[_tableView ht_updateSection:0 sectionMakerBlock:^(HTTableViewSectionMaker *sectionMaker) {
			[sectionMaker.cellClass([HTDiscoverActivityCell class]) didSelectedCellBlock:^(UITableView *tableView, NSInteger row, __kindof UITableViewCell *cell, __kindof HTDiscoverActivityModel *model) {
				HTDiscoverActivityDetailController *detailController = [[HTDiscoverActivityDetailController alloc] init];
				detailController.activityIdString = model.ID;
				[weakSelf.view.superview.ht_controller.rt_navigationController pushViewController:detailController animated:true];
			}];
		}];
	}
	return _tableView;
}

@end
