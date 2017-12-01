//
//  HTIndexWorkController.m
//  School
//
//  Created by hublot on 2017/8/11.
//  Copyright © 2017年 hublot. All rights reserved.
//

#import "HTIndexWorkController.h"
#import "HTIndexWorkHeaderView.h"
#import "HTIndexWorkCell.h"
#import <UIScrollView+HTRefresh.h>
#import "HTWorkHeaderModel.h"
#import "HTWorkDetailController.h"

@interface HTIndexWorkController () <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, strong) NSArray *modelArray;

@end

static NSString *kHTIndexWorkCollectionCellIdentifier = @"kHTIndexWorkCollectionIdentifier";

static NSString *kHTIndexWorkCollectionHeaderIdentifier = @"kHTIndexWorkCollectionHeaderIdentifier";

@implementation HTIndexWorkController

- (void)viewDidLoad {
	[super viewDidLoad];
	[self initializeDataSource];
	[self initializeUserInterface];
}

- (void)initializeDataSource {
	
	__weak typeof(self) weakSelf = self;
	[self.collectionView ht_setRefreshBlock:^(NSString *pageSize, NSString *currentPage) {
		HTNetworkModel *networkModel = [HTNetworkModel modelForOnlyCacheNoInterfaceForScrollViewWithCacheStyle:HTCacheStyleAllUser];
		[HTRequestManager requestWorkListWithNetworkModel:networkModel complete:^(id response, HTError *errorModel) {
			if (errorModel.existError) {
				[weakSelf.collectionView ht_endRefreshWithModelArrayCount:errorModel.errorType];
				return;
			}
			NSArray *modelArray = [HTWorkHeaderModel mj_objectArrayWithKeyValuesArray:response];
			weakSelf.modelArray = modelArray;
			[weakSelf.collectionView ht_endRefreshWithModelArrayCount:modelArray.count];
			[weakSelf.collectionView reloadData];
		}];
	}];
	[self.collectionView ht_startRefreshHeader];
}

- (void)initializeUserInterface {
	self.navigationItem.title = @"找实习";
	[self.view addSubview:self.collectionView];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
	return self.modelArray.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
	HTWorkHeaderModel *headerModel = self.modelArray[section];
	return headerModel.data.count;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
	HTIndexWorkHeaderView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:kHTIndexWorkCollectionHeaderIdentifier forIndexPath:indexPath];
	HTWorkHeaderModel *headerModel = self.modelArray[indexPath.section];
	[headerView setModelArray:headerModel section:indexPath.section];
	return headerView;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
	HTIndexWorkCell *cell = (HTIndexWorkCell *)[collectionView dequeueReusableCellWithReuseIdentifier:kHTIndexWorkCollectionCellIdentifier forIndexPath:indexPath];
	HTWorkHeaderModel *headerModel = self.modelArray[indexPath.section];
	HTWorkModel *model = headerModel.data[indexPath.row];
	[cell setModel:model row:indexPath.row];
	return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
	HTWorkHeaderModel *headerModel = self.modelArray[indexPath.section];
	HTWorkModel *model = headerModel.data[indexPath.row];
	HTWorkDetailController *detailController = [[HTWorkDetailController alloc] init];
	detailController.workIdString = model.ID;
	detailController.workCatIdString = model.catId;
	[self.navigationController pushViewController:detailController animated:true];
	[collectionView deselectItemAtIndexPath:indexPath animated:true];
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
	CGFloat colCount = 2;
	return CGSizeMake((HTSCREENWIDTH - 15 - 15 - (colCount - 1) * 15) / colCount, 100);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
	return UIEdgeInsetsMake(0, 15, 15, 15);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
	return 15;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
	return 15;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
	return CGSizeMake(HTSCREENWIDTH, 40);
}

- (UICollectionView *)collectionView {
	if (!_collectionView) {
		UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
		
		_collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:flowLayout];
		_collectionView.delegate = self;
		_collectionView.dataSource = self;
		[_collectionView registerClass:[HTIndexWorkCell class] forCellWithReuseIdentifier:kHTIndexWorkCollectionCellIdentifier];
		[_collectionView registerClass:[HTIndexWorkHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:kHTIndexWorkCollectionHeaderIdentifier];
	}
	return _collectionView;
}

- (NSArray *)modelArray {
	if (!_modelArray) {
		NSMutableArray *modelArray = [@[] mutableCopy];
		_modelArray = modelArray;
	}
	return _modelArray;
}

@end
