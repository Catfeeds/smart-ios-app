//
//  HTSchoolMatriculateSelectedController.m
//  School
//
//  Created by hublot on 2017/8/17.
//  Copyright © 2017年 hublot. All rights reserved.
//

#import "HTSchoolMatriculateSelectedController.h"
#import "HTSchoolMatriculateSelectedCell.h"
#import <UITableView+HTSeparate.h>

@interface HTSchoolMatriculateSelectedController ()

@end

@implementation HTSchoolMatriculateSelectedController

- (void)viewDidLoad {
	[super viewDidLoad];
	[self initializeDataSource];
	[self initializeUserInterface];
}

- (void)viewWillDisappear:(BOOL)animated {
	[super viewWillDisappear:animated];
	if (self.endSelectedBlock) {
		self.endSelectedBlock();
	}
}

- (void)initializeDataSource {
	
}

- (void)initializeUserInterface {
	[self.view addSubview:self.tableView];
}

- (UITableView *)tableView {
	if (!_tableView) {
		_tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
		_tableView.separatorColor = [UIColor ht_colorString:@"f0f0f0"];
		_tableView.backgroundColor = _tableView.separatorColor;
		[_tableView ht_updateSection:0 sectionMakerBlock:^(HTTableViewSectionMaker *sectionMaker) {
			sectionMaker.cellClass([HTSchoolMatriculateSelectedCell class]).rowHeight(45);
		}];
	}
	return _tableView;
}

@end
