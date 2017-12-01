//
//  HTProfessionalRequireCell.m
//  School
//
//  Created by hublot on 2017/9/21.
//  Copyright © 2017年 hublot. All rights reserved.
//

#import "HTProfessionalRequireCell.h"
#import "HTProfessionalRequireCollectionCell.h"
#import <UICollectionView+HTSeparate.h>
#import <NSObject+HTTableRowHeight.h>
#import "HTProfessionalModel.h"

@interface HTProfessionalRequireCell ()

@property (nonatomic, strong) UICollectionView *collectionView;

@end

@implementation HTProfessionalRequireCell

- (void)didMoveToSuperview {
	self.backgroundColor = [UIColor clearColor];
	self.selectionStyle = UITableViewCellSelectionStyleNone;
	[self addSubview:self.collectionView];
	[self.collectionView mas_updateConstraints:^(MASConstraintMaker *make) {
		make.edges.mas_equalTo(UIEdgeInsetsMake(15, 15, 15, 15));
	}];
}

- (void)setModel:(HTProfessionalModel *)model row:(NSInteger)row {
	HTProfessionalDetailModel *professionalModel = model.data.firstObject;
	NSArray *modelArray = @[@"GPA", [NSString stringWithFormat:@"%@", professionalModel.system], @"托福", [NSString stringWithFormat:@"%@", professionalModel.speak],
							@"雅思", [NSString stringWithFormat:@"%@", professionalModel.price], @"GMAT", [NSString stringWithFormat:@"%@", professionalModel.answer],
							@"GRE", [NSString stringWithFormat:@"%@", professionalModel.duration], @"学位", [NSString stringWithFormat:@"%@", professionalModel.numbering],
							@"工作年限", [NSString stringWithFormat:@"%@", professionalModel.problemComplement], @"学费", [NSString stringWithFormat:@"%@", professionalModel.tuition]];
	__block CGSize itemSize = CGSizeZero;
	[self.collectionView ht_updateSection:0 sectionMakerBlock:^(HTCollectionViewSectionMaker *sectionMaker) {
		sectionMaker.modelArray(modelArray);
		itemSize = sectionMaker.section.itemSize;
	}];
	CGFloat modelHeigth = itemSize.height * ((modelArray.count) / 2) + 30;
	[model ht_setRowHeightNumber:@(modelHeigth) forCellClass:self.class];
}

- (UICollectionView *)collectionView {
	if (!_collectionView) {
		UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
		CGFloat singleRowCount = 2;
		CGFloat itemWidth = (HTSCREENWIDTH - 30) / singleRowCount;
		CGFloat itemHeight = 50;
		CGFloat itemHorizontalSpacing = 0;
		CGFloat itemVerticalSpacing = 0;
		UIEdgeInsets sectionEdge = UIEdgeInsetsMake(0, 0, 0, 0);
		CGSize itemSize = CGSizeMake(itemWidth, itemHeight);
		_collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
		_collectionView.scrollEnabled = false;
		[_collectionView ht_updateSection:0 sectionMakerBlock:^(HTCollectionViewSectionMaker *sectionMaker) {
			[sectionMaker.cellClass([HTProfessionalRequireCollectionCell class]).itemSize(itemSize).itemHorizontalSpacing(itemHorizontalSpacing).itemVerticalSpacing(itemVerticalSpacing).sectionInset(sectionEdge) didSelectedCellBlock:^(UICollectionView *collectionView, NSInteger item, __kindof UICollectionViewCell *cell, __kindof NSObject *model) {
				
			}];
		}];
		_collectionView.backgroundColor = [UIColor clearColor];
	}
	return _collectionView;
}

@end
