//
//  HTDropBoxDetailView.m
//  HTDropBox
//
//  Created by hublot on 2017/9/22.
//  Copyright © 2017年 hublot. All rights reserved.
//

#import "HTDropBoxDetailView.h"
#import "HTDropBoxDetailTableCell.h"
#import "HTDropBoxDetailLeftCell.h"
#import "HTDropBoxDetailRightCell.h"

@interface HTDropBoxDetailView () <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) UITableView *leftTableView;

@property (nonatomic, strong) UICollectionView *rightCollectionView;

@property (nonatomic, strong) NSArray <HTDropBoxProtocol> *modelArray;

@property (nonatomic, strong) id <HTDropBoxProtocol> leftSelectedModel;

@end

@implementation HTDropBoxDetailView

static NSString *kHTDropBoxDetailCollectionCellIdentifier = @"kHTDropBoxDetailCollectionCellIdentifier";

static NSString *kHTDropBoxDetailTableCellIdentifier = @"kHTDropBoxDetailTableCellIdentifier";

- (void)didMoveToSuperview {
	[self addSubview:self.tableView];
	[self addSubview:self.leftTableView];
	[self addSubview:self.rightCollectionView];
	self.tableView.translatesAutoresizingMaskIntoConstraints = false;
	self.leftTableView.translatesAutoresizingMaskIntoConstraints = false;
	self.rightCollectionView.translatesAutoresizingMaskIntoConstraints = false;
	NSString *tableViewString = @"tableViewString";
	NSString *leftTableViewString = @"leftTableViewString";
	NSString *rightCollectionViewString = @"rightCollectionViewString";
	NSDictionary *viewBinding = @{tableViewString:self.tableView, leftTableViewString:self.leftTableView, rightCollectionViewString:self.rightCollectionView};
	NSString *tableHorizontal = [NSString stringWithFormat:@"H:|[%@]|", tableViewString];
	NSString *tableVertical = [NSString stringWithFormat:@"V:|[%@]|", tableViewString];
	NSString *horizontal = [NSString stringWithFormat:@"H:|[%@(150)][%@]|", leftTableViewString, rightCollectionViewString];
	NSString *leftTableVertical = [NSString stringWithFormat:@"V:|[%@]|", leftTableViewString];
	NSString *rightCollectionVertical = [NSString stringWithFormat:@"V:|[%@]|", rightCollectionViewString];
	[self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:tableHorizontal options:kNilOptions metrics:nil views:viewBinding]];
	[self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:tableVertical options:kNilOptions metrics:nil views:viewBinding]];
	[self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:horizontal options:kNilOptions metrics:nil views:viewBinding]];
	[self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:leftTableVertical options:kNilOptions metrics:nil views:viewBinding]];
	[self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:rightCollectionVertical options:kNilOptions metrics:nil views:viewBinding]];
}

- (CGFloat)heightWithSetModelArray:(NSArray <HTDropBoxProtocol> *)modelArray {
	CGFloat height = 0;
	_modelArray = modelArray;
	id <HTDropBoxProtocol> model = self.modelArray.firstObject;
	UITableView *visibleTableView;
	if (model.selectedModelArray.count) {
		visibleTableView = self.leftTableView;
	} else {
		visibleTableView = self.leftTableView;
	}
	CGFloat itemHeight = [self tableView:visibleTableView heightForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
	NSInteger itemCount = modelArray.count;
	height = itemHeight * itemCount;
	return height;
}

- (void)reloadData {
	id <HTDropBoxProtocol> model = self.modelArray.firstObject;
	UITableView *visibleTableView;
	if (model.selectedModelArray.count) {
		[self.leftTableView reloadData];
		self.tableView.hidden = true;
		self.leftTableView.hidden = self.rightCollectionView.hidden = false;
		visibleTableView = self.leftTableView;
	} else {
		self.tableView.hidden = false;
		self.leftTableView.hidden = self.rightCollectionView.hidden = true;
		[self.tableView reloadData];
		visibleTableView = self.tableView;
	}
	[self.modelArray enumerateObjectsUsingBlock:^(id <HTDropBoxProtocol> model, NSUInteger index, BOOL * _Nonnull stop) {
		if (model.isSelected) {
			NSIndexPath *indexPath = [NSIndexPath indexPathForRow:index inSection:0];
			[visibleTableView selectRowAtIndexPath:indexPath animated:false scrollPosition:UITableViewScrollPositionNone];
			[self tableView:visibleTableView didSelectRowAtIndexPath:indexPath];
		}
	}];
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return self.modelArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	if (tableView == self.tableView) {
		return 40;
	} else if (tableView == self.leftTableView) {
		return 40;
	}
	return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	UITableViewCell <HTDropBoxCellProtocol> *cell = [tableView dequeueReusableCellWithIdentifier:kHTDropBoxDetailTableCellIdentifier];
	NSInteger row = indexPath.row;
	id <HTDropBoxProtocol> model = self.modelArray[row];
	[cell setModel:model];
	return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	id <HTDropBoxProtocol> model = self.modelArray[indexPath.row];
	model.isSelected = true;
	self.leftSelectedModel = model;
	[self.rightCollectionView reloadData];
	[model.selectedModelArray enumerateObjectsUsingBlock:^(id <HTDropBoxProtocol> model, NSUInteger index, BOOL * _Nonnull stop) {
		if (model.isSelected) {
			NSIndexPath *indexPath = [NSIndexPath indexPathForRow:index inSection:0];
			[self.rightCollectionView selectItemAtIndexPath:indexPath animated:false scrollPosition:UICollectionViewScrollPositionNone];
			[self collectionView:self.rightCollectionView didSelectItemAtIndexPath:indexPath];
		}
	}];
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath {
	id <HTDropBoxProtocol> model = self.modelArray[indexPath.row];
	model.isSelected = false;
}













- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
	return self.leftSelectedModel.selectedModelArray.count;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
	id <HTDropBoxProtocol> model = self.leftSelectedModel.selectedModelArray[indexPath.row];
	CGFloat height = [HTDropBoxDetailRightCell collectionItemHeight];
	CGFloat pointSize = [HTDropBoxDetailRightCell cellFontPointSize];
	CGFloat width = [model.title boundingRectWithSize:CGSizeMake(MAXFLOAT, height) options:NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:pointSize]} context:nil].size.width;
	width += 45;
	return CGSizeMake(width, height);
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
	UICollectionViewCell <HTDropBoxCellProtocol> *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kHTDropBoxDetailCollectionCellIdentifier forIndexPath:indexPath];
	id <HTDropBoxProtocol> model = self.leftSelectedModel.selectedModelArray[indexPath.row];
	[cell setModel:model];
	return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
	id <HTDropBoxProtocol> model = self.leftSelectedModel.selectedModelArray[indexPath.row];
	model.isSelected = true;
}

- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath {
	id <HTDropBoxProtocol> model = self.leftSelectedModel.selectedModelArray[indexPath.row];
	model.isSelected = false;
}

- (UITableView *)tableView {
	if (!_tableView) {
		_tableView = [[UITableView alloc] init];
		_tableView.delegate = self;
		_tableView.dataSource = self;
		CGFloat gray = 243 / 255.0;
		_tableView.separatorColor = [UIColor colorWithRed:gray green:gray blue:gray alpha:1];
		[_tableView registerClass:[HTDropBoxDetailTableCell class] forCellReuseIdentifier:kHTDropBoxDetailTableCellIdentifier];
	}
	return _tableView;
}

- (UITableView *)leftTableView {
	if (!_leftTableView) {
		_leftTableView = [[UITableView alloc] init];
		_leftTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
		_leftTableView.delegate = self;
		_leftTableView.dataSource = self;
		CGFloat gray = 250 / 255.0;
		_leftTableView.backgroundColor = [UIColor colorWithRed:gray green:gray blue:gray alpha:1];
		[_leftTableView registerClass:[HTDropBoxDetailLeftCell class] forCellReuseIdentifier:kHTDropBoxDetailTableCellIdentifier];
	}
	return _leftTableView;
}

- (UICollectionView *)rightCollectionView {
	if (!_rightCollectionView) {
		UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
		flowLayout.minimumInteritemSpacing = 15;
		flowLayout.minimumLineSpacing = 15;
		flowLayout.sectionInset = UIEdgeInsetsMake(15, 15, 15, 15);
		_rightCollectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
		_rightCollectionView.delegate = self;
		_rightCollectionView.dataSource = self;
		[_rightCollectionView registerClass:[HTDropBoxDetailRightCell class] forCellWithReuseIdentifier:kHTDropBoxDetailCollectionCellIdentifier];
		_rightCollectionView.backgroundColor = [UIColor whiteColor];
	}
	return _rightCollectionView;
}

@end
