//
//  HTIndexBookIndexCell.m
//  School
//
//  Created by hublot on 2017/8/8.
//  Copyright © 2017年 hublot. All rights reserved.
//

#import "HTIndexBookIndexCell.h"
#import <UICollectionView+HTSeparate.h>
#import <NSObject+HTTableRowHeight.h>
#import "HTIndexBookCell.h"
#import "HTSellerDetailController.h"
#import "HTIndexModel.h"

@interface HTIndexBookIndexCell ()

@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, strong) NSArray *model;

@end

@implementation HTIndexBookIndexCell

- (void)didMoveToSuperview {
	self.selectionStyle = UITableViewCellSelectionStyleNone;
	[self addSubview:self.collectionView];
}

- (void)setModel:(NSArray *)model row:(NSInteger)row {
	if (_model == model) {
		return;
	}
	_model = model;
	[self.collectionView ht_updateSection:0 sectionMakerBlock:^(HTCollectionViewSectionMaker *sectionMaker) {
		sectionMaker.modelArray(model);
	}];
	
	CGFloat modelHeight = self.collectionView.bounds.size.height;
	[model ht_setRowHeightNumber:@(modelHeight) forCellClass:self.class];
}

- (UICollectionView *)collectionView {
	if (!_collectionView) {
        
        __weak typeof(self) weakSelf = self;
		CGFloat itemWidth = 200;
		CGFloat itemHeight = 140;
		CGFloat itemHorizontalSpacing = 0;
		CGFloat itemVerticalSpacing = 5;
		UIEdgeInsets sectionEdge = UIEdgeInsetsMake(10, 10, 10, 10);
		CGSize itemSize = CGSizeMake(itemWidth, itemHeight);
		UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
		flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
		_collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, HTSCREENWIDTH, itemHeight + sectionEdge.top + sectionEdge.bottom) collectionViewLayout:flowLayout];
		[_collectionView ht_updateSection:0 sectionMakerBlock:^(HTCollectionViewSectionMaker *sectionMaker) {
			[sectionMaker.cellClass([HTIndexBookCell class]).itemSize(itemSize).itemHorizontalSpacing(itemHorizontalSpacing).itemVerticalSpacing(itemVerticalSpacing).sectionInset(sectionEdge) didSelectedCellBlock:^(UICollectionView *collectionView, NSInteger item, __kindof UICollectionViewCell *cell, __kindof HTIndexDocument *model) {
                HTSellerDetailController *detailController = [[HTSellerDetailController alloc] init];
                detailController.sellerIdString = model.ID;
                [weakSelf.ht_controller.navigationController pushViewController:detailController animated:true];
            }];
		}];
	}
	return _collectionView;
}

@end
