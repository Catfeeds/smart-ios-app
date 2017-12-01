//
//  HTOrganizationCountryCell.m
//  School
//
//  Created by hublot on 2017/8/28.
//  Copyright © 2017年 hublot. All rights reserved.
//

#import "HTOrganizationCountryCell.h"
#import "HTOrganizationCountryCollectionCell.h"
#import <NSObject+HTTableRowHeight.h>
#import <UICollectionViewCell+HTSeparate.h>

@interface HTOrganizationCountryCell () <UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, strong) NSArray *modelContentArray;

@property (nonatomic, strong) NSArray *modelSizeArray;

@end

static NSString *kHTOrganizationCountryCellIdentifier = @"kHTOrganizationCountryCellIdentifier";

@implementation HTOrganizationCountryCell

- (void)didMoveToSuperview {
	[self addSubview:self.collectionView];
	[self.collectionView mas_updateConstraints:^(MASConstraintMaker *make) {
		make.edges.mas_equalTo(UIEdgeInsetsMake(15, 15, 15, 15));
	}];
}

- (void)setModel:(NSArray *)model row:(NSInteger)row {
	CGRect collectionFrame = CGRectZero;
	collectionFrame.size.width = HTSCREENWIDTH - 30;
	self.collectionView.frame = collectionFrame;
	
	_modelContentArray = model;
	NSMutableArray *modelSizeArray = [@[] mutableCopy];
	HTOrganizationCountryCollectionCell *cell = [[HTOrganizationCountryCollectionCell alloc] init];
	UIFont *titleNameFont = cell.titleNameLabel.font;
	[_modelContentArray enumerateObjectsUsingBlock:^(NSString *string, NSUInteger index, BOOL * _Nonnull stop) {
		CGSize itemSize = CGSizeZero;
		itemSize.height = [self.class itemHeight];
		NSString *titleName = string;
		itemSize.width = [titleName boundingRectWithSize:CGSizeMake(MAXFLOAT, itemSize.height)
												 options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
											  attributes:@{NSFontAttributeName:titleNameFont} context:nil].size.width;
		itemSize.width += 16;
		[modelSizeArray addObject:[NSValue valueWithCGSize:itemSize]];
	}];
	self.modelSizeArray = modelSizeArray;
	
	[self.collectionView reloadData];
	
	CGFloat modelArrayHeight = 15;
	modelArrayHeight += self.collectionView.collectionViewLayout.collectionViewContentSize.height;
	modelArrayHeight += 15;
	
	[model ht_setRowHeightNumber:@(modelArrayHeight) forCellClass:self.class];
}

+ (CGFloat)itemHeight {
	return 25;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
	return self.modelContentArray.count;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
	return [self.modelSizeArray[indexPath.row] CGSizeValue];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
	UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kHTOrganizationCountryCellIdentifier forIndexPath:indexPath];
	id model = self.modelContentArray[indexPath.row];
	[cell setModel:model row:indexPath.row];
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
		flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
		_collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
		_collectionView.scrollEnabled = false;
		_collectionView.delegate = self;
		_collectionView.dataSource = self;
		[_collectionView registerClass:[HTOrganizationCountryCollectionCell class] forCellWithReuseIdentifier:kHTOrganizationCountryCellIdentifier];
	}
	return _collectionView;
}


@end
