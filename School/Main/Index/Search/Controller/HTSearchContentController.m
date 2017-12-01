//
//  HTSearchContentController.m
//  School
//
//  Created by hublot on 2017/9/12.
//  Copyright © 2017年 hublot. All rights reserved.
//

#import "HTSearchContentController.h"
#import "HTSearchResultCell.h"
#import "HTSearchResultModel.h"
#import "HTSchoolController.h"
#import "HTProfessionalController.h"
#import "HTAnswerDetailController.h"
#import "HTLibraryApplyContentController.h"
#import "HTDiscoverActivityDetailController.h"

@interface HTSearchContentController ()

@end

@implementation HTSearchContentController

- (void)viewDidLoad {
	[super viewDidLoad];
	[self initializeDataSource];
	[self initializeUserInterface];
}

- (void)initializeDataSource {
	
}

- (void)initializeUserInterface {
	self.tableView.backgroundColor = [UIColor ht_colorString:@"eeeeee"];
	self.tableView.separatorColor = self.tableView.backgroundColor;
	
	__weak typeof(self) weakSelf = self;
	[self.tableView ht_updateSection:0 sectionMakerBlock:^(HTTableViewSectionMaker *sectionMaker) {
		[sectionMaker.cellClass([HTSearchResultCell class]).rowHeight(70) didSelectedCellBlock:^(UITableView *tableView, NSInteger row, __kindof UITableViewCell *cell, __kindof HTSearchResultModel *model) {
			UIViewController *viewController;
			switch (model.type) {
				case HTSearchTypeSchool: {
					HTSchoolController *detailController = [[HTSchoolController alloc] init];
					detailController.schoolIdString = model.ID;
					viewController = detailController;
					break;
				}
				case HTSearchTypeProfessional: {
					HTProfessionalController *detailController = [[HTProfessionalController alloc] init];
					detailController.professionalId = model.ID;
					viewController = detailController;
					break;
				}
				case HTSearchTypeAnswer: {
					HTAnswerDetailController *detailController = [[HTAnswerDetailController alloc] init];
					detailController.answerIdString = model.ID;
					viewController = detailController;
					break;
				}
				case HTSearchTypeActivity: {
					HTDiscoverActivityDetailController *detailController = [[HTDiscoverActivityDetailController alloc] init];
					detailController.activityIdString = model.ID;
					viewController = detailController;
					break;
				}
				case HTSearchTypeLibrary: {
					HTLibraryApplyContentController *detailController = [[HTLibraryApplyContentController alloc] init];
					detailController.libraryIdString = model.ID;
					viewController = detailController;
					break;
				}
			}
			if (viewController) {
				[weakSelf.navigationController pushViewController:viewController animated:true];
			}
		}];
	}];
	
}


@end
