//
//  HTOrganizationContentController.m
//  School
//
//  Created by hublot on 2017/8/18.
//  Copyright © 2017年 hublot. All rights reserved.
//

#import "HTOrganizationContentController.h"
#import "HTOrganizationCell.h"
#import "HTOrganizationDetailController.h"
#import "HTOrganizationModel.h"

@interface HTOrganizationContentController ()

@end

@implementation HTOrganizationContentController

- (void)viewDidLoad {
	[super viewDidLoad];
	[self initializeDataSource];
	[self initializeUserInterface];
}

- (void)initializeDataSource {
	
}

- (void)initializeUserInterface {
	
	__weak typeof(self) weakSelf = self;
	[self.tableView ht_updateSection:0 sectionMakerBlock:^(HTTableViewSectionMaker *sectionMaker) {
		[sectionMaker.cellClass([HTOrganizationCell class]).rowHeight(130) didSelectedCellBlock:^(UITableView *tableView, NSInteger row, __kindof UITableViewCell *cell, __kindof HTOrganizationModel *model) {
			HTOrganizationDetailController *detailController = [[HTOrganizationDetailController alloc] init];
			detailController.organizationIdString = model.ID;
			[weakSelf.navigationController pushViewController:detailController animated:true];
		}];
	}];
}


@end
