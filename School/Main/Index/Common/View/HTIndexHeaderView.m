//
//  HTIndexHeaderView.m
//  School
//
//  Created by hublot on 2017/6/15.
//  Copyright © 2017年 hublot. All rights reserved.
//

#import "HTIndexHeaderView.h"
#import <UICollectionView+HTSeparate.h>
#import "HTIndexHeaderCollectionCell.h"
#import "HTIndexHeaderCollectionModel.h"
#import "HTWebController.h"
#import "HTManagerController.h"
#import "HTRootNavigationController.h"
#import "HTAnswerIssueController.h"
#import "HTIndexWorkController.h"
#import "HTExampleSuccessController.h"
#import "HTIndexAdvisorController.h"
#import "HTLibraryController.h"
#import "HTSchoolFilterController.h"
#import "HTOrganizationController.h"
#import "HTMajorController.h"
#import "HTSchoolRankController.h"
#import "HTEvaluateController.h"
#import "HTDiscoverActivityModel.h"
#import "HTDiscoverActivityDetailController.h"
#import "HTFindAgencyViewController.h"
#import "HTUniversityRankClassController.h"

@interface HTIndexHeaderView ()

@end

@implementation HTIndexHeaderView

- (void)didMoveToSuperview {
	[self.bannerBackgroundView addSubview:self.bannerPageControl];
	[self addSubview:self.bannerBackgroundView];
	[self addSubview:self.circelCollectionView];
}

- (void)setBannerModelArray:(NSArray *)bannerModelArray {
	self.bannerBackgroundView.numberOfRows = bannerModelArray.count;
	self.bannerPageControl.numberOfPages = bannerModelArray.count;
	
	__weak typeof(self) weakSelf = self;
	[self.bannerBackgroundView setButtonForIndexPath:^(UIButton *button, NSInteger index){
		HTDiscoverActivityModel *bannerModel = bannerModelArray[index];
		[button sd_setBackgroundImageWithURL:[NSURL URLWithString:SmartApplyResourse(bannerModel.image)] forState:UIControlStateNormal placeholderImage:HTPLACEHOLDERIMAGE];
	}];
	[self.bannerBackgroundView setWillDisplayIndexPath:^(UIButton *button, NSInteger index){
		weakSelf.bannerPageControl.currentPage = index;
	}];
	[self.bannerBackgroundView setDidSelectedIndexPath:^(UIButton *button, NSInteger index){
		HTDiscoverActivityModel *bannerModel = bannerModelArray[index];
		HTDiscoverActivityDetailController *detailController = [[HTDiscoverActivityDetailController alloc] init];
		detailController.activityIdString = bannerModel.ID;
		[weakSelf.ht_controller.navigationController pushViewController:detailController animated:true];
	}];
	[self.bannerBackgroundView reloadData];
}

- (HTScrollPageView *)bannerBackgroundView {
	if (!_bannerBackgroundView) {
		_bannerBackgroundView = [[HTScrollPageView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height - self.circelCollectionView.bounds.size.height)];
	}
	return _bannerBackgroundView;
}

- (UIPageControl *)bannerPageControl {
	if (!_bannerPageControl) {
		_bannerPageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, self.bannerBackgroundView.bounds.size.height - 30, self.bannerBackgroundView.bounds.size.width, 30)];
		_bannerPageControl.pageIndicatorTintColor = [UIColor whiteColor];
		_bannerPageControl.currentPageIndicatorTintColor = [UIColor ht_colorStyle:HTColorStyleTintColor];
	}
	return _bannerPageControl;
}

- (UICollectionView *)circelCollectionView {
	if (!_circelCollectionView) {
		NSArray *modelArray = [HTIndexHeaderCollectionModel packModelArray];
		CGFloat collectionWidth = HTSCREENWIDTH;
		CGFloat collectionHeight = 180;
		NSInteger singleRowItemCount = 4;
		NSInteger singleColItemCount = 2;
		UIEdgeInsets sectionEdge = UIEdgeInsetsMake(0, 0, 0, 0);
		CGFloat itemHorizontalSpacing = 0;
		CGFloat itemVerticalSpacing = 0;
		CGFloat itemWidth = (collectionWidth - sectionEdge.left - sectionEdge.right - itemHorizontalSpacing * (singleRowItemCount - 1)) / singleRowItemCount;
		CGFloat itemHeight = (collectionHeight - sectionEdge.top - sectionEdge.bottom - itemVerticalSpacing * (singleColItemCount - 1)) / singleColItemCount;
		CGSize itemSize = CGSizeMake(itemWidth, itemHeight);
		UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
		_circelCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, self.bounds.size.height - collectionHeight, collectionWidth, collectionHeight) collectionViewLayout:flowLayout];
		_circelCollectionView.backgroundColor = [UIColor whiteColor];
		
		__weak typeof(self) weakSelf = self;
		[_circelCollectionView ht_updateSection:0 sectionMakerBlock:^(HTCollectionViewSectionMaker *sectionMaker) {
			[sectionMaker.cellClass([HTIndexHeaderCollectionCell class]).modelArray(modelArray).itemSize(itemSize).sectionInset(sectionEdge).itemHorizontalSpacing(itemHorizontalSpacing).itemVerticalSpacing(itemVerticalSpacing) didSelectedCellBlock:^(UICollectionView *collectionView, NSInteger item, __kindof UICollectionViewCell *cell, __kindof HTIndexHeaderCollectionModel *model) {
				UIViewController *viewController = nil;
				switch (model.type) {
					case HTIndexHeaderCollectionItemTypeSchool: {
						viewController = [[HTSchoolFilterController alloc] init];
						break;
					}
					case HTIndexHeaderCollectionItemTypeRank: {
					//	HTSchoolRankController *rankController = [[HTSchoolRankController alloc] init];
						HTUniversityRankClassController *rankController = STORYBOARD_VIEWCONTROLLER(@"Home", @"HTUniversityRankClassController");
						viewController = rankController;
						
						break;
					}
					case HTIndexHeaderCollectionItemTypeMajor: {
                        HTMajorController *majorController = [[HTMajorController alloc] init];
                        viewController = majorController;
						break;
					}
					case HTIndexHeaderCollectionItemTypeLibrary: {
                        HTLibraryController *libraryController = [[HTLibraryController alloc] init];
						viewController = libraryController;
						break;
					}
					case HTIndexHeaderCollectionItemTypeMatriculate: {
						HTEvaluateController *evaluateController = [[HTEvaluateController alloc] init];
						viewController = evaluateController;
						break;
					}
					case HTIndexHeaderCollectionItemTypeWork: {
						HTIndexWorkController *workController = [[HTIndexWorkController alloc] init];
						viewController = workController;
						break;
					}
					case HTIndexHeaderCollectionItemTypeOrganization: {
					//	HTOrganizationController *organizationController = [[HTOrganizationController alloc] init];
						HTFindAgencyViewController *findAgencyViewController = [[HTFindAgencyViewController alloc]init];
						viewController = findAgencyViewController;
						break;
					}
					case HTIndexHeaderCollectionItemTypeAdvisor: {
						HTIndexAdvisorController *advisorController = [[HTIndexAdvisorController alloc] init];
						viewController = advisorController;
						break;
					}
				}
				if (viewController) {
					[weakSelf.ht_controller.rt_navigationController pushViewController:viewController animated:true];
				}
			}];
		}];
	}
	return _circelCollectionView;
}


@end
