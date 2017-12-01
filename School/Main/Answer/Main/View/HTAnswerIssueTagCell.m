//
//  HTAnswerIssueTagCell.m
//  School
//
//  Created by hublot on 2017/8/14.
//  Copyright © 2017年 hublot. All rights reserved.
//

#import "HTAnswerIssueTagCell.h"
#import "HTSchoolFilterSelectedCollectionCell.h"
#import <UICollectionViewCell+HTSeparate.h>
#import "HTSchoolFilterModel.h"
#import <NSObject+HTTableRowHeight.h>
#import "HTAnswerIssueTagModel.h"

@interface HTAnswerIssueTagCell () <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UILabel *titleNameLabel;

@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, strong) HTAnswerIssueTagModel *model;

@property (nonatomic, strong) NSArray *modelSizeArray;

@end

static NSString *kHTAnswerIssueTagCollectionCellIdentifier = @"kHTAnswerIssueTagCollectionCellIdentifier";

@implementation HTAnswerIssueTagCell

+ (CGFloat)itemHeight {
	return 25;
}

- (void)didMoveToSuperview {
	[self addSubview:self.titleNameLabel];
	[self addSubview:self.collectionView];
	[self.titleNameLabel mas_updateConstraints:^(MASConstraintMaker *make) {
		make.left.top.mas_equalTo(15);
		make.right.mas_equalTo(- 15);
		make.height.mas_equalTo(20);
	}];
	[self.collectionView mas_updateConstraints:^(MASConstraintMaker *make) {
		make.left.right.mas_equalTo(self.titleNameLabel);
		make.top.mas_equalTo(self.titleNameLabel.mas_bottom).offset(10);
		make.bottom.mas_equalTo(- 10);
	}];
}

- (void)setModel:(HTAnswerIssueTagModel *)model row:(NSInteger)row {
	CGRect collectionFrame = CGRectZero;
	collectionFrame.size.width = HTSCREENWIDTH - 30;
	self.collectionView.frame = collectionFrame;

	_model = model;
	NSMutableArray *modelSizeArray = [@[] mutableCopy];
	HTSchoolFilterSelectedCollectionCell *cell = [[HTSchoolFilterSelectedCollectionCell alloc] init];
	UIFont *titleNameFont = cell.titleNameButton.titleLabel.font;
	[_model.tagModelArray enumerateObjectsUsingBlock:^(HTAnswerTagModel *model, NSUInteger index, BOOL * _Nonnull stop) {
		CGSize itemSize = CGSizeZero;
		itemSize.height = [self.class itemHeight];
		NSString *titleName = model.name;
		itemSize.width = [titleName boundingRectWithSize:CGSizeMake(MAXFLOAT, itemSize.height)
												 options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
											  attributes:@{NSFontAttributeName:titleNameFont} context:nil].size.width;
		itemSize.width += 16;
		[modelSizeArray addObject:[NSValue valueWithCGSize:itemSize]];
	}];
	self.modelSizeArray = modelSizeArray;
	
	[self.collectionView reloadData];
	
	if (self.model.selectedIndexArray.count) {
		[self.model.selectedIndexArray enumerateObjectsUsingBlock:^(NSNumber *number, NSUInteger index, BOOL * _Nonnull stop) {
			[self.collectionView selectItemAtIndexPath:[NSIndexPath indexPathForRow:number.integerValue inSection:0] animated:false scrollPosition:UICollectionViewScrollPositionNone];
		}];
	}
	
	
	CGFloat modelArrayHeight = 0;
	modelArrayHeight += 15;
	modelArrayHeight += 20;
	modelArrayHeight += 10;
	modelArrayHeight += self.collectionView.collectionViewLayout.collectionViewContentSize.height;
	modelArrayHeight += 10;
	
	[model ht_setRowHeightNumber:@(modelArrayHeight) forCellClass:self.class];
	
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
	return self.model.tagModelArray.count;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
	return [self.modelSizeArray[indexPath.row] CGSizeValue];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
	UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kHTAnswerIssueTagCollectionCellIdentifier forIndexPath:indexPath];
	id model = self.model.tagModelArray[indexPath.row];
	[cell setModel:model row:indexPath.row];
	return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
	[self.model.selectedIndexArray addObject:@(indexPath.row)];
}

- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath {
	[self.model.selectedIndexArray removeObject:@(indexPath.row)];
}

- (UILabel *)titleNameLabel {
	if (!_titleNameLabel) {
		_titleNameLabel = [[UILabel alloc] init];
		_titleNameLabel.textColor = [UIColor ht_colorStyle:HTColorStylePrimaryTitle];
		_titleNameLabel.font = [UIFont systemFontOfSize:15];
		_titleNameLabel.text = @"问题标签";
	}
	return _titleNameLabel;
}

- (UICollectionView *)collectionView {
	if (!_collectionView) {
		UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
		flowLayout.minimumInteritemSpacing = 15;
		flowLayout.minimumLineSpacing = 15;
		flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
		_collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
		_collectionView.scrollEnabled = false;
		_collectionView.allowsMultipleSelection = true;
		_collectionView.delegate = self;
		_collectionView.dataSource = self;
		[_collectionView registerClass:[HTSchoolFilterSelectedCollectionCell class] forCellWithReuseIdentifier:kHTAnswerIssueTagCollectionCellIdentifier];
	}
	return _collectionView;
}

@end
