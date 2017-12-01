//
//  HTSchoolMajorCell.m
//  School
//
//  Created by hublot on 2017/9/21.
//  Copyright © 2017年 hublot. All rights reserved.
//

#import "HTSchoolMajorCell.h"
#import "HTSchoolModel.h"
#import <UITableView+HTSeparate.h>
#import "HTSchoolMajorTitleCell.h"
#import <NSObject+HTTableRowHeight.h>
#import "HTSchoolMajorDetailCell.h"
#import "HTProfessionalController.h"

@interface HTSchoolMajorCell () <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UITableView *titleTableView;

@property (nonatomic, strong) UICollectionView *detailCollectionView;

@property (nonatomic, strong) NSArray <HTSchoolProfessionalModel *> *modelArray;

@property (nonatomic, strong) HTSchoolProfessionalModel *selectedProfessionalModel;

@end

@implementation HTSchoolMajorCell

static NSString *kHTSchoolMajorReuseIdentifier = @"kHTSchoolMajorReuseIdentifier";

+ (CGFloat)titleTableRowHeight {
	return 40;
}

- (void)didMoveToSuperview {
	self.selectionStyle = UITableViewCellSelectionStyleNone;
	[self addSubview:self.titleTableView];
	[self addSubview:self.detailCollectionView];
	[self.titleTableView mas_updateConstraints:^(MASConstraintMaker *make) {
		make.left.top.bottom.mas_equalTo(self);
		make.width.mas_equalTo(self).multipliedBy(0.3);
	}];
	[self.detailCollectionView mas_updateConstraints:^(MASConstraintMaker *make) {
		make.right.top.bottom.mas_equalTo(self);
		make.left.mas_equalTo(self.titleTableView.mas_right);
	}];
}

- (void)setModel:(NSArray <HTSchoolProfessionalModel *> *)model row:(NSInteger)row {
	NSMutableArray *modelArray = [@[] mutableCopy];
	[model enumerateObjectsUsingBlock:^(HTSchoolProfessionalModel *professionalModel, NSUInteger index, BOOL * _Nonnull stop) {
		if (professionalModel.content.count) {
			[modelArray addObject:professionalModel];
		}
	}];
	
	[self.titleTableView ht_updateSection:0 sectionMakerBlock:^(HTTableViewSectionMaker *sectionMaker) {
		sectionMaker.modelArray(modelArray);
	}];
	[modelArray enumerateObjectsUsingBlock:^(HTSchoolProfessionalModel *professionalModel, NSUInteger index, BOOL * _Nonnull stop) {
		if (professionalModel.isSelected) {
			*stop = true;
		} else if (index >= modelArray.count - 1) {
			HTSchoolProfessionalModel *selectedModel = modelArray.firstObject;
			selectedModel.isSelected = true;
		}
	}];
	self.modelArray = modelArray;
	[modelArray enumerateObjectsUsingBlock:^(HTSchoolProfessionalModel *professionalModel, NSUInteger index, BOOL * _Nonnull stop) {
		if (professionalModel.isSelected) {
			NSIndexPath *indexPath = [NSIndexPath indexPathForRow:index inSection:0];
			[self.titleTableView selectRowAtIndexPath:indexPath animated:true scrollPosition:UITableViewRowAnimationNone];
			[self tableView:self.titleTableView didSelectItemAtIndexPath:indexPath];
		}
	}];
	CGFloat modelHeight = [self.class titleTableRowHeight] * modelArray.count;
	[model ht_setRowHeightNumber:@(modelHeight) forCellClass:self.class];
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
	HTSchoolProfessionalSubModel *model = self.selectedProfessionalModel.content[indexPath.row];
	CGFloat height = [HTSchoolMajorDetailCell collectionItemHeight];
	CGFloat pointSize = [HTSchoolMajorDetailCell cellFontPointSize];
	CGFloat width = [model.name boundingRectWithSize:CGSizeMake(MAXFLOAT, height) options:NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:pointSize]} context:nil].size.width;
	width += 45;
	return CGSizeMake(width, height);
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
	return self.selectedProfessionalModel.content.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
	HTSchoolMajorDetailCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kHTSchoolMajorReuseIdentifier forIndexPath:indexPath];
	NSInteger row = indexPath.row;
	HTSchoolProfessionalSubModel *model = self.selectedProfessionalModel.content[row];
	[cell setModel:model row:row];
	return cell;
}

- (void)tableView:(UITableView *)tableView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
	HTSchoolProfessionalModel *model = self.modelArray[indexPath.row];
	model.isSelected = true;
	self.selectedProfessionalModel = model;
	[self.detailCollectionView reloadData];
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
	HTSchoolProfessionalSubModel *model = self.selectedProfessionalModel.content[indexPath.row];
	HTProfessionalController *professionalController = [[HTProfessionalController alloc] init];
	professionalController.professionalId = model.ID;
	[self.ht_controller.navigationController pushViewController:professionalController animated:true];
	[collectionView deselectItemAtIndexPath:indexPath animated:true];
}

- (UITableView *)titleTableView {
	if (!_titleTableView) {
		_titleTableView = [[UITableView alloc] initWithFrame:CGRectZero];
		_titleTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
		_titleTableView.backgroundColor = [UIColor ht_colorString:@"f3f3f3"];
		_titleTableView.scrollEnabled = false;
		
		__weak typeof(self) weakSelf = self;
		[_titleTableView ht_updateSection:0 sectionMakerBlock:^(HTTableViewSectionMaker *sectionMaker) {
			[[sectionMaker.cellClass([HTSchoolMajorTitleCell class]).rowHeight([weakSelf.class titleTableRowHeight]) didSelectedCellBlock:^(UITableView *tableView, NSInteger row, __kindof UITableViewCell *cell, __kindof HTSchoolProfessionalModel *model) {
				[weakSelf tableView:tableView didSelectItemAtIndexPath:[NSIndexPath indexPathForRow:row inSection:0]];
			}] diddeSelectedCellBlock:^(UITableView *tableView, NSInteger row, __kindof UITableViewCell *cell, __kindof HTSchoolProfessionalModel *model) {
				model.isSelected = false;
			}];
		}];
	}
	return _titleTableView;
}

- (UICollectionView *)detailCollectionView {
	if (!_detailCollectionView) {
		UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
		flowLayout.minimumLineSpacing = 15;
		flowLayout.minimumInteritemSpacing = 15;
		flowLayout.sectionInset = UIEdgeInsetsMake(15, 15, 15, 15);
		_detailCollectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
		_detailCollectionView.delegate = self;
		_detailCollectionView.dataSource = self;
		[_detailCollectionView registerClass:[HTSchoolMajorDetailCell class] forCellWithReuseIdentifier:kHTSchoolMajorReuseIdentifier];
	}
	return _detailCollectionView;
}

@end
