//
//  HTFilterResultSchoolController.m
//  School
//
//  Created by hublot on 2017/8/28.
//  Copyright © 2017年 hublot. All rights reserved.
//

#import "HTFilterResultSchoolController.h"
#import <UITableView+HTSeparate.h>
#import <UIScrollView+HTRefresh.h>
#import "HTSchoolCell.h"
#import "HTSchoolFilterProfessionalCell.h"
#import "HTSchoolController.h"
#import "HTProfessionalController.h"
#import "HTSchoolModel.h"
#import "RTRootNavigationController.h"
#import "HTProfessionDetailController.h"

@interface HTFilterResultSchoolController ()

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation HTFilterResultSchoolController

- (void)viewDidLoad {
	[super viewDidLoad];
	[self initializeDataSource];
	[self initializeUserInterface];
}

- (void)initializeDataSource {
	
	__weak typeof(self) weakSelf = self;
	[self.tableView ht_setRefreshBlock:^(NSString *pageSize, NSString *currentPage) {
		[weakSelf.tableView ht_endRefreshWithModelArrayCount:weakSelf.resultSchoolModel ? 1 : 0];
		HTSchoolModel *schoolModel = [HTSchoolModel mj_objectWithKeyValues:weakSelf.resultSchoolModel.mj_keyValues];
		schoolModel.answer = weakSelf.resultSchoolModel.place;
		[weakSelf.tableView ht_updateSection:0 sectionMakerBlock:^(HTTableViewSectionMaker *sectionMaker) {
			[sectionMaker.cellClass([HTSchoolCell class]).rowHeight(130).modelArray(@[schoolModel]) didSelectedCellBlock:^(UITableView *tableView, NSInteger row, __kindof UITableViewCell *cell, __kindof HTSchoolModel *model) {
				HTSchoolController *schoolController = [[HTSchoolController alloc] init];
				schoolController.schoolIdString = model.ID;
				
				RTRootNavigationController *navigationController = weakSelf.rt_navigationController;
				
				__weak typeof(navigationController) weakNavigationController = navigationController;
				[navigationController pushViewController:schoolController animated:true complete:^(BOOL finished) {
					[weakNavigationController removeViewController:weakSelf animated:false];
				}];
			}];
		}];
		[weakSelf.tableView ht_updateSection:1 sectionMakerBlock:^(HTTableViewSectionMaker *sectionMaker) {
			[sectionMaker.cellClass([HTSchoolFilterProfessionalCell class]).rowHeight(45).modelArray(weakSelf.resultSchoolModel.major) didSelectedCellBlock:^(UITableView *tableView, NSInteger row, __kindof UITableViewCell *cell, __kindof HTFilterResultProfessionalModel *model) {
			//	HTProfessionalController *professionalController = [[HTProfessionalController alloc] init];
                HTProfessionDetailController *professionalController = STORYBOARD_VIEWCONTROLLER(@"Home", @"HTProfessionDetailController");
				professionalController.professionalId = model.ID;
				[weakSelf.navigationController pushViewController:professionalController animated:true];
			}];
		}];
	}];
	[self.tableView ht_startRefreshHeader];
}

- (void)initializeUserInterface {
	self.navigationItem.title = @"查询结果";
	[self.view addSubview:self.tableView];
}


- (UITableView *)tableView {
	if (!_tableView) {
		_tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
		_tableView.backgroundColor = [UIColor ht_colorString:@"f3f3f3"];
		_tableView.separatorColor = _tableView.backgroundColor;
	}
	return _tableView;
}

@end
