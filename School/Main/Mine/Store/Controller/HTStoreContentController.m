//
//  HTStoreContentController.m
//  School
//
//  Created by hublot on 17/9/2.
//  Copyright © 2017年 hublot. All rights reserved.
//

#import "HTStoreContentController.h"
#import "HTStoreCell.h"
#import "HTUserStoreManager.h"
#import "HTSchoolController.h"
#import "HTProfessionalController.h"
#import "HTAnswerDetailController.h"
#import "HTLibraryApplyContentController.h"
#import "HTDiscoverActivityDetailController.h"

@interface HTStoreContentController ()

@end

@implementation HTStoreContentController

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
        [[sectionMaker.cellClass([HTStoreCell class]).rowHeight(70) didSelectedCellBlock:^(UITableView *tableView, NSInteger row, __kindof UITableViewCell *cell, __kindof HTUserStoreModel *model) {
            UIViewController *viewController;
            switch (model.type) {
                case HTUserStoreTypeSchool: {
                    HTSchoolController *detailController = [[HTSchoolController alloc] init];
                    detailController.schoolIdString = model.lookId;
                    viewController = detailController;
                    break;
                }
                case HTUserStoreTypeProfessional: {
                    HTProfessionalController *detailController = [[HTProfessionalController alloc] init];
                    detailController.professionalId = model.lookId;
                    viewController = detailController;
                    break;
                }
                case HTUserStoreTypeAnswer: {
                    HTDiscoverActivityDetailController *detailController = [[HTDiscoverActivityDetailController alloc] init];
                    detailController.activityIdString = model.lookId;
                    viewController = detailController;
                    break;
                }
                case HTUserStoreTypeActivity: {
                    HTAnswerDetailController *detailController = [[HTAnswerDetailController alloc] init];
                    detailController.answerIdString = model.lookId;
                    viewController = detailController;
                    break;
                }
                case HTUserStoreTypeLibrary: {
                    HTLibraryApplyContentController *detailController = [[HTLibraryApplyContentController alloc] init];
                    detailController.libraryIdString = model.lookId;
                    viewController = detailController;
                    break;
                }
            }
            if (viewController) {
                [weakSelf.navigationController pushViewController:viewController animated:true];
            }
        }] deleteCellBlock:^(UITableView *tableView, NSInteger row, __kindof UITableViewCell *cell, __kindof HTUserStoreModel *model) {
            [HTUserStoreManager switchStoreStateWithModel:model];
        }].deleteTitle(@"取消收藏");
    }];
}

@end
