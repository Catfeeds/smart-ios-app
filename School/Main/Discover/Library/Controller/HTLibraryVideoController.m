//
//  HTLibraryVideoController.m
//  School
//
//  Created by hublot on 2017/8/15.
//  Copyright © 2017年 hublot. All rights reserved.
//

#import "HTLibraryVideoController.h"
#import "HTLibraryModel.h"
#import <UICollectionView+HTSeparate.h>
#import "HTLibraryVideoHeaderView.h"
#import "HTLibraryVideoCell.h"
#import "HTWebController.h"
#import <UIScrollView+HTRefresh.h>
#import "HTSellerDetailController.h"
#import "HTPlayerController.h"
#import "HTUserManager.h"

@interface HTLibraryVideoController ()

@property (nonatomic, strong) UICollectionView *collectionView;

@end

@implementation HTLibraryVideoController

@synthesize pageModel = _pageModel;

- (void)viewDidLoad {
	[super viewDidLoad];
	[self initializeDataSource];
	[self initializeUserInterface];
}

- (void)initializeDataSource {
	
}

- (void)setPageModel:(HTPageModel *)pageModel {
	
	UIEdgeInsets sectionEdge = UIEdgeInsetsMake(15, 15, 15, 15);
	CGFloat itemHorizontalSpacing = 15;
	CGFloat itemVerticalSpacing = 15;
	CGFloat colCount = 2;
	CGFloat itemWidth = (HTSCREENWIDTH - itemHorizontalSpacing * (colCount - 1) - sectionEdge.left - sectionEdge.right) / colCount;
	CGFloat itemHeight = 170;
	CGSize itemSize = CGSizeMake(itemWidth, itemHeight);
	
	__weak typeof(self) weakSelf = self;
	_pageModel = pageModel;
	HTLibraryModel *model = pageModel.modelArray.firstObject;	
	[model.applyVideo enumerateObjectsUsingBlock:^(HTLibraryProjectVideoHeaderModel *headerModel, NSUInteger index, BOOL * _Nonnull stop) {
		NSString *headerTitle = headerModel.name;
		NSArray *modelArray = headerModel.data;
		[self.collectionView ht_updateSection:index sectionMakerBlock:^(HTCollectionViewSectionMaker *sectionMaker) {
			[[sectionMaker.cellClass([HTLibraryVideoCell class])
			  .itemHorizontalSpacing(itemHorizontalSpacing)
			  .itemVerticalSpacing(itemVerticalSpacing)
			  .sectionInset(sectionEdge)
			  .itemSize(itemSize).modelArray(modelArray).headerClass([HTLibraryVideoHeaderView class]).headerSize(CGSizeMake(HTSCREENWIDTH, 45)) customReusableViewBlock:^(UICollectionView *collectionView, __kindof HTLibraryVideoHeaderView *reusableView, BOOL isHeader) {
				[reusableView.titleNameButton setTitle:headerTitle forState:UIControlStateNormal];
			}] didSelectedCellBlock:^(UICollectionView *collectionView, NSInteger item, __kindof UICollectionViewCell *cell, __kindof HTLibraryProjectVideoContentModel *model) {
			//HTSellerDetailController *detailController = [[HTSellerDetailController alloc] init];
			//	detailController.sellerIdString = model.ID;
				[HTUserManager surePermissionHighOrEqual:HTUserPermissionExerciseAbleUser passCompareBlock:^(HTUser *user) {
					HTPlayerController *detailController = [[HTPlayerController alloc]init];
					detailController.courseURLString = model.url;
					detailController.sellerIdString = model.ID;
					[weakSelf.navigationController pushViewController:detailController animated:true];
				}];
			}];
		}];
	}];
	[self.collectionView ht_setRefreshBlock:^(NSString *pageSize, NSString *currentPage) {
		[weakSelf.collectionView reloadData];
		[weakSelf.collectionView ht_endRefreshWithModelArrayCount:model.applyVideo.count];
	}];
	[self.collectionView ht_startRefreshHeader];
}

- (void)initializeUserInterface {
	[self.tableView removeFromSuperview];
	[self.view addSubview:self.collectionView];
	[self.collectionView mas_updateConstraints:^(MASConstraintMaker *make) {
		make.edges.mas_equalTo(UIEdgeInsetsZero);
	}];
}

- (UICollectionView *)collectionView {
	if (!_collectionView) {
		UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
		_collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
		_collectionView.backgroundColor = [UIColor ht_colorStyle:HTColorStyleCompareBackground];
	}
	return _collectionView;
}


@end
