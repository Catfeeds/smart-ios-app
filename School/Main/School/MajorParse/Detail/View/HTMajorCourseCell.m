//
//  HTMajorCourseCell.m
//  School
//
//  Created by hublot on 2017/9/11.
//  Copyright © 2017年 hublot. All rights reserved.
//

#import "HTMajorCourseCell.h"
#import <NSObject+HTTableRowHeight.h>
#import <UICollectionViewCell+HTSeparate.h>
#import <NSAttributedString+HTAttributedString.h>
#import "HTMajorCourseCollectionCell.h"

@interface HTMajorCourseCell () <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, strong) NSArray *modelSizeArray;

@property (nonatomic, strong) NSArray *modelArray;

@end

@implementation HTMajorCourseCell

static NSString *kHTMajorDetailCourseCollectionCellIdentifier = @"kHTMajorDetailCourseCollectionCellIdentifier";

- (void)didMoveToSuperview {
	self.backgroundColor = [UIColor clearColor];
	[self addSubview:self.collectionView];
	[self.collectionView mas_updateConstraints:^(MASConstraintMaker *make) {
		make.edges.mas_equalTo(UIEdgeInsetsMake(15, 15, 15, 15));
	}];
}

+ (CGFloat)itemHeight {
	return 25;
}

- (void)setModel:(NSArray <NSString *> *)model row:(NSInteger)row {
	_modelArray = model;
	NSMutableArray *modelSizeArray = [@[] mutableCopy];
	HTMajorCourseCollectionCell *cell = [[HTMajorCourseCollectionCell alloc] init];
	self.collectionView.frame = CGRectMake(0, 0, HTSCREENWIDTH - 30, 0);
	[model enumerateObjectsUsingBlock:^(NSString *model, NSUInteger index, BOOL * _Nonnull stop) {
		CGSize itemSize = CGSizeZero;
		itemSize.height = [self.class itemHeight];
		[cell setModel:model row:index];
		itemSize.width = [cell.titleNameButton.currentAttributedTitle boundingRectWithSize:CGSizeMake(MAXFLOAT, itemSize.height)
																				   options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
																				   context:nil].size.width;
		itemSize.width += 16;
		[modelSizeArray addObject:[NSValue valueWithCGSize:itemSize]];
	}];
	self.modelSizeArray = modelSizeArray;
	
	[self.collectionView reloadData];
	
	CGFloat modelHeight = 15;
	CGFloat collectionHeight = self.collectionView.collectionViewLayout.collectionViewContentSize.height;
	modelHeight += collectionHeight;
	modelHeight += 15;
	[model ht_setRowHeightNumber:@(modelHeight) forCellClass:self.class];
	
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
	return self.modelArray.count;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
	if (indexPath.row < self.modelSizeArray.count) {
		return [self.modelSizeArray[indexPath.row] CGSizeValue];
	}
	return CGSizeZero;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
	UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kHTMajorDetailCourseCollectionCellIdentifier forIndexPath:indexPath];
	if (indexPath.row < self.modelArray.count) {
		id model = self.modelArray[indexPath.row];
		[cell setModel:model row:indexPath.row];
	}
	return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
	[collectionView deselectItemAtIndexPath:indexPath animated:true];
}

- (UICollectionView *)collectionView {
	if (!_collectionView) {
		UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
		flowLayout.minimumInteritemSpacing = 15;
		flowLayout.minimumLineSpacing = 15;
		_collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
		_collectionView.showsHorizontalScrollIndicator = false;
		_collectionView.showsVerticalScrollIndicator = false;
		_collectionView.delegate = self;
		_collectionView.dataSource = self;
		[_collectionView registerClass:[HTMajorCourseCollectionCell class] forCellWithReuseIdentifier:kHTMajorDetailCourseCollectionCellIdentifier];
	}
	return _collectionView;
}

@end
