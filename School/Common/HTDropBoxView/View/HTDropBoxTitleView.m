//
//  HTDropBoxTitleView.m
//  HTDropBox
//
//  Created by hublot on 2017/9/22.
//  Copyright © 2017年 hublot. All rights reserved.
//

#import "HTDropBoxTitleView.h"
#import "HTDropBoxTitleCell.h"

@interface HTDropBoxTitleView () <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, strong) UIView *separatorLineView;

@end

@implementation HTDropBoxTitleView

static NSString *kHTDropBoxTitleCellIdentifier = @"kHTDropBoxTitleCellIdentifier";

- (void)didMoveToSuperview {
	self.backgroundColor = [UIColor whiteColor];
	[self addSubview:self.separatorLineView];
	[self addSubview:self.collectionView];
	self.collectionView.translatesAutoresizingMaskIntoConstraints = false;
	self.separatorLineView.translatesAutoresizingMaskIntoConstraints = false;
	NSString *collectionViewString = @"collectionView";
	NSString *separatorViewString = @"separatorViewString";
	NSDictionary *viewBinding = @{collectionViewString:self.collectionView, separatorViewString:self.separatorLineView};
	NSString *collectionHorizontal = [NSString stringWithFormat:@"H:|[%@]|", collectionViewString];
	NSString *separatorHorizontal = [NSString stringWithFormat:@"H:|[%@]|", separatorViewString];
	NSString *collectionVertical = [NSString stringWithFormat:@"V:|[%@]|", collectionViewString];
	NSString *separatorVertical = [NSString stringWithFormat:@"V:[%@(%lf)]|", separatorViewString, 1 / [UIScreen mainScreen].scale];
	NSLayoutFormatOptions options = NSLayoutFormatAlignAllLeft | NSLayoutFormatAlignAllRight;
	[self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:collectionHorizontal options:options metrics:nil views:viewBinding]];
	[self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:separatorHorizontal options:options metrics:nil views:viewBinding]];
	[self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:collectionVertical options:options metrics:nil views:viewBinding]];
	[self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:separatorVertical options:options metrics:nil views:viewBinding]];
}

- (void)reloadData {
	[self.collectionView reloadData];
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
	id <HTDropBoxProtocol> model = self.modelArray[indexPath.row];
	if (model.isSelected) {
		[collectionView deselectItemAtIndexPath:indexPath animated:false];
		[self collectionView:collectionView didDeselectItemAtIndexPath:indexPath];
	} else {
		model.isSelected = true;
	}
	if (self.didSelectedBlock) {
		self.didSelectedBlock(model);
	}
}

- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath {
	id <HTDropBoxProtocol> model = self.modelArray[indexPath.row];
	model.isSelected = false;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
	return self.modelArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
	HTDropBoxTitleCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kHTDropBoxTitleCellIdentifier forIndexPath:indexPath];
	NSInteger row = indexPath.row;
	id <HTDropBoxProtocol> model = self.modelArray[row];
	[cell setModel:model];
	return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
	CGSize dropBoxSize = self.bounds.size;
	NSInteger titleModelCount = self.modelArray.count;
	CGFloat width = dropBoxSize.width / titleModelCount;
	CGFloat height = dropBoxSize.height;
	return CGSizeMake(width, height);
}

- (UICollectionView *)collectionView {
	if (!_collectionView) {
		UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
		flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
		flowLayout.minimumInteritemSpacing = 0;
		flowLayout.minimumLineSpacing = 0;
		flowLayout.sectionInset = UIEdgeInsetsZero;
		_collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
		_collectionView.delegate = self;
		_collectionView.dataSource = self;
		_collectionView.scrollEnabled = false;
		[_collectionView registerClass:[HTDropBoxTitleCell class] forCellWithReuseIdentifier:kHTDropBoxTitleCellIdentifier];
		_collectionView.backgroundColor = [UIColor clearColor];
	}
	return _collectionView;
}

- (UIView *)separatorLineView {
	if (!_separatorLineView) {
		_separatorLineView = [[UIView alloc] init];
		_separatorLineView.backgroundColor = [HTDropBoxTitleCell separatorLineColor];
	}
	return _separatorLineView;
}

@end
