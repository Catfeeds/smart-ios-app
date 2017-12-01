//
//  HTEvaluateController.m
//  School
//
//  Created by hublot on 2017/9/19.
//  Copyright © 2017年 hublot. All rights reserved.
//

#import "HTEvaluateController.h"
#import <UITableView+HTSeparate.h>
#import "HTEvaluateCell.h"
#import "HTEvaluateModel.h"
#import "HTBackgroundController.h"
#import "HTSchoolMatriculateSingleController.h"
#import "HTSchoolMatriculateDetailController.h"
#import "HTChooseSchoolEvaluationController.h"

@interface HTEvaluateController ()

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation HTEvaluateController

- (void)viewDidLoad {
	[super viewDidLoad];
	[self initializeDataSource];
	[self initializeUserInterface];
}

- (void)initializeDataSource {
	
}

- (void)initializeUserInterface {
	self.navigationItem.title = @"留学评估系统";
	[self.view addSubview:self.tableView];
}

- (UITableView *)tableView {
	if (!_tableView) {
		_tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
		_tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
		NSArray *modelArray = [HTEvaluateModel packModelArray];
		
		__weak typeof(self) weakSelf = self;
		[_tableView ht_updateSection:0 sectionMakerBlock:^(HTTableViewSectionMaker *sectionMaker) {
			[sectionMaker.cellClass([HTEvaluateCell class]).rowHeight(170).modelArray(modelArray) didSelectedCellBlock:^(UITableView *tableView, NSInteger row, __kindof UITableViewCell *cell, __kindof HTEvaluateModel *model) {
				UIViewController *viewController;
				switch (model.type) {
					case HTEvaluateTypeBackground: {
						HTBackgroundController *backgroundController = [[HTBackgroundController alloc] init];
						viewController = backgroundController;
						break;
					}
					case HTEvaluateTypeSum: {
						HTSchoolMatriculateDetailController *sumController = [[HTSchoolMatriculateDetailController alloc] init];
//						viewController = sumController;
                        HTChooseSchoolEvaluationController *gradeController = STORYBOARD_VIEWCONTROLLER(@"Home", @"HTChooseSchoolEvaluationController");
                        viewController = gradeController;
						break;
					}
					case HTEvaluateTypeSingle: {
						HTSchoolMatriculateSingleController *singleController = [[HTSchoolMatriculateSingleController alloc] init];
						viewController = singleController;
						break;
					}
				}
				if (viewController) {
					[weakSelf.navigationController pushViewController:viewController animated:true];
				}
			}];
		}];
	}
	return _tableView;
}

@end
