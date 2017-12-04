//
//  HTExampleSectionScrollView.m
//  School
//
//  Created by hublot on 2017/9/27.
//  Copyright © 2017年 hublot. All rights reserved.
//

#import "HTExampleSectionScrollView.h"
#import "HTExampleScrollController.h"
#import "VTMagicView.h"
#import "HTDiscoverExampleItemModel.h"
#import <UIScrollView+HTRefresh.h>
#import "HTDiscoverExampleModel.h"

@interface HTExampleSectionScrollView () <VTMagicViewDelegate, VTMagicViewDataSource>

@property (nonatomic, strong) VTMagicView *magicView;

@property (nonatomic, strong)  HTDiscoverExampleItemModel *currenItemModel;

@property (nonatomic, strong) NSArray <HTDiscoverExampleItemModel *> *itemModelArray;

@end

@implementation HTExampleSectionScrollView

- (void)didMoveToSuperview {
	
	self.backgroundColor = [UIColor clearColor];
	__weak typeof(self) weakSelf = self;
	[self addSubview:self.magicView];
	[self.magicView mas_updateConstraints:^(MASConstraintMaker *make) {
		make.edges.mas_equalTo(UIEdgeInsetsZero);
	}];
	[self setReloadNetworkBlock:^{
		weakSelf.placeHolderState = HTPlaceholderStateNetwork;
		HTNetworkModel *networkModel = [HTNetworkModel modelForOnlyCacheNoInterfaceForScrollViewWithCacheStyle:HTCacheStyleAllUser];
		[HTRequestManager requestExampleItemWithNetworkModel:networkModel complete:^(id response, HTError *errorModel) {
			BOOL error = errorModel.existError;
			if (error) {
				weakSelf.placeHolderState = HTPlaceholderStateNetwork;
				if (weakSelf.reloadHeightBlock) {
					weakSelf.reloadHeightBlock();
				}
				return;
			}
			NSArray *itemModelArray = [HTDiscoverExampleItemModel packModelArrayFromResponse:response];
			weakSelf.itemModelArray = itemModelArray;
			weakSelf.placeHolderState = itemModelArray.count;
			[weakSelf.magicView reloadData];
			if (weakSelf.reloadHeightBlock) {
				weakSelf.reloadHeightBlock();
			}
		}];
	}];
	self.reloadNetworkBlock();
	self.reloadHeightBlock();
}

- (void)magicView:(VTMagicView *)magicView viewDidAppear:(__kindof HTExampleScrollController *)viewController atPage:(NSUInteger)pageIndex {
	self.currentScrollController = viewController;
	self.currenItemModel = self.itemModelArray[pageIndex];
	if (!self.currenItemModel.modelArray.count) {
		[self refreshTableFooterModelArrayComplete:^{
			if (self.reloadHeightBlock) {
				self.reloadHeightBlock();
			}
		}];
	}
}

- (NSArray<__kindof NSString *> *)menuTitlesForMagicView:(VTMagicView *)magicView {
	NSMutableArray *titleModelArray = [@[] mutableCopy];
	[self.itemModelArray enumerateObjectsUsingBlock:^(HTDiscoverExampleItemModel *model, NSUInteger index, BOOL * _Nonnull stop) {
		[titleModelArray addObject:model.name];
	}];
	return titleModelArray;
}

- (UIButton *)magicView:(VTMagicView *)magicView menuItemAtIndex:(NSUInteger)itemIndex {
	static NSString *kHTMenuItemIdentifier = @"kHTMenuItemIdentifier";
	UIButton *button = [magicView dequeueReusableItemWithIdentifier:kHTMenuItemIdentifier];
	if (!button) {
		button = [[UIButton alloc] init];
		button.titleLabel.font = [UIFont systemFontOfSize:15];
		[button setTitleColor:[UIColor ht_colorStyle:HTColorStylePrimaryTitle] forState:UIControlStateNormal];
		[button setTitleColor:[UIColor ht_colorStyle:HTColorStyleTintColor] forState:UIControlStateSelected];
	}
	return button;
}

- (UIViewController *)magicView:(VTMagicView *)magicView viewControllerAtPage:(NSUInteger)pageIndex {
	static NSString *kHTControllerIdentifier = @"kHTControllerIdentifier";
	HTExampleScrollController *viewController = (HTExampleScrollController *)[magicView dequeueReusablePageWithIdentifier:kHTControllerIdentifier];
	if (!viewController) {
		viewController = [[HTExampleScrollController alloc] init];
	}
	return viewController;
}

- (void)refreshTableFooterModelArrayComplete:(void(^)(void))complete {
	HTNetworkModel *networkModel = [HTNetworkModel modelForOnlyCacheNoInterfaceForScrollViewWithCacheStyle:HTCacheStyleAllUser];
	HTDiscoverExampleItemModel *model = self.currenItemModel;
	UITableView *currentTableView = self.currentScrollController.tableView;
	if (model.currentPage < 1) {
		model.currentPage = 1;
	}
    [HTRequestManager requestExampleListWithNetworkModel:networkModel catIdString:[NSString stringWithFormat:@"%@",model.catId] pageSize:[NSString stringWithFormat:@"%ld", currentTableView.ht_pageSize] currentPage:[NSString stringWithFormat:@"%ld", model.currentPage] complete:^(id response, HTError *errorModel) {
		if (errorModel.existError) {
			if (complete) {
				complete();
			}
			return;
		}
		NSMutableArray *modelArray = [HTDiscoverExampleModel mj_objectArrayWithKeyValuesArray:response[@"data"]];
		[modelArray enumerateObjectsUsingBlock:^(HTDiscoverExampleModel *exampleModel, NSUInteger idx, BOOL * _Nonnull stop) {
			exampleModel.catId = model.catId;
		}];
		if (model.currentPage <= 1) {
			model.modelArray = modelArray;
			model.currentPage = 2;
		} else {
			model.currentPage ++;
			[model.modelArray addObjectsFromArray:modelArray];
		}
		[self.currentScrollController setModelArray:model.modelArray];
		if (complete) {
			complete();
		}
	}];
}

- (VTMagicView *)magicView {
	if (!_magicView) {
		_magicView = [[VTMagicView alloc] init];
		_magicView.delegate = self;
		_magicView.dataSource = self;
		_magicView.sliderColor = [UIColor ht_colorStyle:HTColorStyleTintColor];
		_magicView.sliderHeight = 1 / [UIScreen mainScreen].scale;
		_magicView.separatorColor = [UIColor clearColor];
		_magicView.layoutStyle = VTLayoutStyleCenter;
		_magicView.backgroundColor = [UIColor clearColor];
		[_magicView reloadData];
	}
	return _magicView;
}

@end
