//
//  HTIndexForYouIndexFooterView.m
//  School
//
//  Created by hublot on 2017/7/26.
//  Copyright © 2017年 hublot. All rights reserved.
//

#import "HTIndexForYouIndexFooterView.h"
#import "HTIndexAnswerController.h"
#import "HTIndexActivityController.h"
#import <NSObject+HTTableRowHeight.h>
#import "VTMagic.h"
#import <UITableView+HTSeparate.h>

@interface HTIndexForYouIndexFooterView () <VTMagicViewDelegate, VTMagicViewDataSource>

@property (nonatomic, strong) VTMagicView *magicView;

@property (nonatomic, strong) UIView *centerSeparatorView;

@property (nonatomic, strong) NSMutableArray <NSArray *> *model;

@end

@implementation HTIndexForYouIndexFooterView

- (void)didMoveToSuperview {
	self.backgroundColor = [UIColor whiteColor];
	[self addSubview:self.magicView];
}

- (NSArray<NSString *> *)menuTitlesForMagicView:(VTMagicView *)magicView {
	return @[@"最热问答", @"留学专栏"];
}

- (UIButton *)magicView:(VTMagicView *)magicView menuItemAtIndex:(NSUInteger)itemIndex {
	static NSString *itemIdentifier = @"itemIdentifier";
	UIButton *menuItem = [magicView dequeueReusableItemWithIdentifier:itemIdentifier];
	if (!menuItem) {
		menuItem = [UIButton buttonWithType:UIButtonTypeCustom];
		[menuItem setTitleColor:[UIColor ht_colorStyle:HTColorStylePrimaryTitle] forState:UIControlStateNormal];
		[menuItem setTitleColor:[UIColor ht_colorStyle:HTColorStyleTintColor] forState:UIControlStateSelected];
		menuItem.titleLabel.font = [UIFont systemFontOfSize:15];
	}
	return menuItem;
}

- (UIViewController *)magicView:(VTMagicView *)magicView viewControllerAtPage:(NSUInteger)pageIndex {
	NSArray *controllerClassArray = @[NSStringFromClass([HTIndexAnswerController class]), NSStringFromClass([HTIndexActivityController class])];
	UIViewController *viewController = [magicView dequeueReusablePageWithIdentifier:controllerClassArray[pageIndex]];
	if (!viewController) {
		if (pageIndex == 0) {
			viewController = [[HTIndexAnswerController alloc] init];
		} else if (pageIndex == 1) {
			viewController = [[HTIndexActivityController alloc] init];
		}
	}
	return viewController;
}

- (void)magicView:(VTMagicView *)magicView viewDidAppear:(__kindof UIViewController <HTIndexContentHeight> *)viewController atPage:(NSUInteger)pageIndex {
	if (self.model.count > pageIndex) {
		NSArray *modelArray = self.model[pageIndex];
        [self reloadHeightFromContentController:viewController modelArray:modelArray];
	}
}

- (void)setAnswerModelArray:(NSArray *)answerModelArray {
	_answerModelArray = answerModelArray;
	self.model[0] = _answerModelArray;
	[self reloadFooterView];
}

- (void)setActivityModelArray:(NSArray *)activityModelArray {
	_activityModelArray = activityModelArray;
	self.model[1] = _activityModelArray;
	[self reloadFooterView];
}

- (void)reloadFooterView {
	[self.magicView reloadData];
	self.centerSeparatorView = self.centerSeparatorView;
}

- (void)reloadHeightFromContentController:(UIViewController <HTIndexContentHeight> *)contentController modelArray:(NSArray *)modelArray {
    CGFloat tableHeight = [contentController tableHeightReloadModelArray:modelArray];
	self.magicView.ht_h = tableHeight + self.magicView.navigationHeight + 1;
	self.ht_h = self.magicView.ht_h;
	CGFloat modelHeight = self.magicView.ht_h;
	[self.model ht_setRowHeightNumber:@(modelHeight) forCellClass:self.class];
    self.superTableView.tableFooterView = self;
}

- (VTMagicView *)magicView {
	if (!_magicView) {
		
		_magicView = [[VTMagicView alloc] initWithFrame:CGRectMake(0, 0, HTSCREENWIDTH, 0)];
		_magicView.layoutStyle = VTLayoutStyleDivide;
		_magicView.sliderStyle = VTSliderStyleDefault;
		_magicView.navigationHeight = 40;
		_magicView.separatorColor = [UIColor clearColor];
		_magicView.sliderColor = [UIColor clearColor];
		_magicView.navigationColor = [UIColor whiteColor];
		_magicView.autoresizesSubviews = YES;
		
		CGFloat borderWidth = 1 / [UIScreen mainScreen].scale;
		
		_magicView.navigationInset = UIEdgeInsetsMake(borderWidth, 0, borderWidth, 0);
		_magicView.delegate = self;
		_magicView.dataSource = self;
		_magicView.bounces = false;
		_magicView.scrollEnabled = false;
		_magicView.menuScrollEnabled = false;
		
		/**
		 * MARK: 设置头部的 bounces
		 */
		UIScrollView *scrollView = [self.magicView valueForKey:@"menuBar"];
		scrollView.bounces = false;
		UIColor *separatorColor = [UIColor ht_colorStyle:HTColorStylePrimarySeparate];
		scrollView.layer.borderColor = separatorColor.CGColor;
		scrollView.layer.borderWidth = borderWidth;
	}
	return _magicView;
}

- (UIView *)centerSeparatorView {
	UIScrollView *scrollView = [self.magicView valueForKey:@"menuBar"];
	if (!_centerSeparatorView) {
		CGFloat lineWidth = 1 / [UIScreen mainScreen].scale;
		CGFloat lineHeight = 28;
		_centerSeparatorView = [[UIView alloc] initWithFrame:CGRectMake(scrollView.ht_w / 2, (self.magicView.navigationHeight - lineHeight) / 2, lineWidth, lineHeight)];
		UIColor *separatorColor = [UIColor ht_colorStyle:HTColorStylePrimarySeparate];
		_centerSeparatorView.backgroundColor = separatorColor;
	}
	[scrollView addSubview:_centerSeparatorView];
	return _centerSeparatorView;
}

- (NSMutableArray <NSArray *> *)model {
	if (!_model) {
		_model = [@[@[], @[]] mutableCopy];
	}
	return _model;
}

@end
