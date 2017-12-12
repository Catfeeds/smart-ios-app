//
//  HTHistoryContentController.m
//  School
//
//  Created by hublot on 2017/8/31.
//  Copyright © 2017年 hublot. All rights reserved.
//

#import "HTHistoryContentController.h"
#import "HTHistoryCell.h"
#import "HTUserHistoryManager.h"
#import "HTSchoolController.h"
#import "HTProfessionalController.h"
#import "HTAnswerDetailController.h"
#import "HTLibraryApplyContentController.h"
#import "HTDiscoverActivityDetailController.h"
#import "HTProfessionDetailController.h"

@interface HTHistoryContentController ()

@end

@implementation HTHistoryContentController

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
		[[sectionMaker.cellClass([HTHistoryCell class]).rowHeight(70) didSelectedCellBlock:^(UITableView *tableView, NSInteger row, __kindof UITableViewCell *cell, __kindof HTUserHistoryModel *model) {
            UIViewController *viewController;
            switch (model.type) {
                case HTUserHistoryTypeSchoolDetail: {
                    HTSchoolController *detailController = [[HTSchoolController alloc] init];
                    detailController.schoolIdString = model.lookId;
                    viewController = detailController;
                    break;
                }
                case HTUserHistoryTypeProfessionalDetail: {
//                    HTProfessionalController *detailController = [[HTProfessionalController alloc] init];
					HTProfessionDetailController *detailController = STORYBOARD_VIEWCONTROLLER(@"Home", @"HTProfessionDetailController");
                    detailController.professionalId = model.lookId;
                    viewController = detailController;
                    break;
                }
                case HTUserHistoryTypeActivityDetail: {
                    HTDiscoverActivityDetailController *detailController = [[HTDiscoverActivityDetailController alloc] init];
                    detailController.activityIdString = model.lookId;
                    viewController = detailController;
                    break;
                }
                case HTUserHistoryTypeAnswerDetail: {
                    HTAnswerDetailController *detailController = [[HTAnswerDetailController alloc] init];
                    detailController.answerIdString = model.lookId;
                    viewController = detailController;
                    break;
                }
                case HTUserHistoryTypeLibraryDetail: {
                    HTLibraryApplyContentController *detailController = [[HTLibraryApplyContentController alloc] init];
                    detailController.libraryIdString = model.lookId;
                    viewController = detailController;
                    break;
                }
            }
            if (viewController) {
                [weakSelf.navigationController pushViewController:viewController animated:true];
            }
        }] deleteCellBlock:^(UITableView *tableView, NSInteger row, __kindof UITableViewCell *cell, __kindof HTUserHistoryModel *model) {
            [HTUserHistoryManager deleteHistoryModel:model];
        }];
	}];
}

@end
