//
//  HTExampleScrollController.m
//  School
//
//  Created by hublot on 2017/9/27.
//  Copyright © 2017年 hublot. All rights reserved.
//

#import "HTExampleScrollController.h"
#import <UITableView+HTSeparate.h>
#import "HTDiscoverExampleContentCell.h"
#import "HTDiscoverExampleDetailController.h"
#import "HTDiscoverExampleModel.h"

@interface HTExampleScrollController ()

@end

@implementation HTExampleScrollController

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

- (void)setModelArray:(NSMutableArray *)modelArray {
	_modelArray = modelArray;
	[self.tableView ht_updateSection:0 sectionMakerBlock:^(HTTableViewSectionMaker *sectionMaker) {
		sectionMaker.modelArray(modelArray);
	}];
}

- (UITableView *)tableView {
	if (!_tableView) {
		_tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
		_tableView.scrollEnabled = false;
		_tableView.showsVerticalScrollIndicator = false;
		_tableView.backgroundColor = [UIColor clearColor];
		
		__weak typeof(self) weakSelf = self;
		[_tableView ht_updateSection:0 sectionMakerBlock:^(HTTableViewSectionMaker *sectionMaker) {
			[sectionMaker.cellClass([HTDiscoverExampleContentCell class]).rowHeight(130) didSelectedCellBlock:^(UITableView *tableView, NSInteger row, __kindof UITableViewCell *cell, __kindof HTDiscoverExampleModel *model) {
				HTDiscoverExampleDetailController *detailController = [[HTDiscoverExampleDetailController alloc] init];
				detailController.exampleIdString = model.ID;
				detailController.exampleCatIdString = model.catId;
				[weakSelf.view.superview.ht_controller.navigationController pushViewController:detailController animated:true];
			}];
		}];
	}
	return _tableView;
}

@end
