//
//  HTLibraryApplyController.m
//  School
//
//  Created by hublot on 2017/8/15.
//  Copyright © 2017年 hublot. All rights reserved.
//

#import "HTLibraryApplyController.h"
#import "HTLibraryCell.h"
#import "HTLibraryHeaderView.h"
#import "HTLibraryApplyContentController.h"
#import "HTLibraryModel.h"
#import "HTDiscoverItemModel.h"
#import "HTUniversityRankController.h"
#import <MJRefresh.h>


@interface HTLibraryApplyController ()

@end

@implementation HTLibraryApplyController

@synthesize pageModel = _pageModel;

- (void)viewDidLoad {
	[super viewDidLoad];
	[self initializeDataSource];
	[self initializeUserInterface];
	
}

- (void)setPageModel:(HTPageModel *)pageModel {
	_pageModel = pageModel;
	__weak typeof(self) weakSelf = self;
	HTLibraryModel *model = pageModel.modelArray.firstObject;
	HTLibraryApplyTypeModel *tpyeModel = (HTLibraryApplyTypeModel *)model.apply[self.reuseControllerIndex];
	[tpyeModel.child enumerateObjectsUsingBlock:^(HTLibraryApplyHeaderModel *headerModel, NSUInteger index, BOOL * _Nonnull stop) {
		[self.tableView ht_updateSection:index sectionMakerBlock:^(HTTableViewSectionMaker *sectionMaker) {
			NSString *headerTitle = headerModel.name;
			NSArray *modelArray = headerModel.data;
			[[sectionMaker.cellClass([HTLibraryCell class]).rowHeight(50).modelArray(modelArray).headerClass([HTLibraryHeaderView class]).headerHeight(45) customHeaderBlock:^(UITableView *tableView, NSInteger section, __kindof HTLibraryHeaderView *reuseView, __kindof NSArray *modelArray) {
				[reuseView.titleNameButton setTitle:headerTitle forState:UIControlStateNormal];
			}] didSelectedCellBlock:^(UITableView *tableView, NSInteger row, __kindof UITableViewCell *cell, __kindof HTLibraryApplyContentModel *model) {
				if (model.type == 1) {
					HTUniversityRankController *controller = STORYBOARD_VIEWCONTROLLER(@"Home", @"HTUniversityRankController");
					HTUniversityRankClassModel *classModel = [[HTUniversityRankClassModel alloc]init];
					classModel.ID = model.ID;
					classModel.name = model.name;
					controller.selectedRankClassModel = classModel;
					[weakSelf.navigationController pushViewController:controller animated:YES];
				}else{
					NSString *libraryCatIdString = headerModel.ID;
					NSString *libraryIdString = model.ID;
					HTLibraryApplyContentController *contentController = [[HTLibraryApplyContentController alloc] init];
					contentController.libraryCatIdString = libraryCatIdString;
					contentController.libraryIdString = libraryIdString;
					[weakSelf.navigationController pushViewController:contentController animated:true];
				}
			}];
		}];
	}];
	[self initializeUserInterface];
}

- (void)initializeDataSource {
	
}

- (void)initializeUserInterface {
	
	MJRefreshNormalHeader *headerHeader = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
		if (self.delegate) {
			[self.delegate refresh];
		}
	}];
	headerHeader.stateLabel.hidden = YES;
	[headerHeader setTitle:@"" forState:MJRefreshStateIdle];
	headerHeader.lastUpdatedTimeLabel.hidden = YES;
	self.tableView.mj_header = headerHeader;
	self.tableView.backgroundColor = [UIColor ht_colorString:@"fafafa"];
}

@end
