//
//  HTDropBoxView.m
//  HTDropBox
//
//  Created by hublot on 2017/9/22.
//  Copyright © 2017年 hublot. All rights reserved.
//

#import "HTDropBoxView.h"
#import "HTDropBoxTitleView.h"
#import "HTDropBoxDetailView.h"
#import "HTDropBoxActionView.h"

@interface HTDropBoxView ()

@property (nonatomic, strong) HTDropBoxTitleView *titleView;

@property (nonatomic, strong) HTDropBoxDetailView *detailView;

@property (nonatomic, strong) HTDropBoxActionView *actionView;

@property (nonatomic, strong) UIView *backgroundView;

@property (nonatomic, strong) NSLayoutConstraint *detailHeightConstraint;

@property (nonatomic, strong) NSLayoutConstraint *willCloseDetailConstraint;

@property (nonatomic, strong) NSLayoutConstraint *willOpenDetailConstraint;

@end

@implementation HTDropBoxView

- (void)didMoveToSuperview {
	self.clipsToBounds = true;
	[self addSubview:self.backgroundView];
	[self addSubview:self.detailView];
	[self addSubview:self.actionView];
	[self addSubview:self.titleView];
	self.titleView.translatesAutoresizingMaskIntoConstraints = false;
	self.backgroundView.translatesAutoresizingMaskIntoConstraints = false;
	self.detailView.translatesAutoresizingMaskIntoConstraints = false;
	self.actionView.translatesAutoresizingMaskIntoConstraints = false;
	CGFloat titleHeight = 40;
	CGFloat actionHeight = 49;
	NSString *titleViewString = @"titleView";
	NSString *backgroundViewString = @"backgroundView";
	NSString *detailViewString = @"detailView";
	NSString *actionViewString = @"actionView";
	NSDictionary *viewBinding = @{titleViewString:self.titleView, backgroundViewString:self.backgroundView, detailViewString:self.detailView, actionViewString:self.actionView};
	NSString *titleViewHorizontal = [NSString stringWithFormat:@"H:|[%@]|", titleViewString];
	NSString *titleViewVertical = [NSString stringWithFormat:@"V:|[%@(%lf)][%@]|", titleViewString, titleHeight, backgroundViewString];
	NSString *detailViewHorizontal = [NSString stringWithFormat:@"H:|[%@]|", detailViewString];
	NSString *actionViewVertical = [NSString stringWithFormat:@"V:[%@][%@(%lf)]", detailViewString, actionViewString, actionHeight];
	
	self.willCloseDetailConstraint = [NSLayoutConstraint constraintWithItem:self.actionView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.backgroundView attribute:NSLayoutAttributeTop multiplier:1 constant:0];
	self.willOpenDetailConstraint = [NSLayoutConstraint constraintWithItem:self.detailView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.backgroundView attribute:NSLayoutAttributeTop multiplier:1 constant:0];
	self.detailHeightConstraint = [NSLayoutConstraint constraintWithItem:self.detailView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:0];
	self.detailHeightConstraint.active = true;
	
	NSLayoutFormatOptions options = NSLayoutFormatAlignAllLeft | NSLayoutFormatAlignAllRight;
	[self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:titleViewHorizontal options:options metrics:nil views:viewBinding]];
	[self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:titleViewVertical options:options metrics:nil views:viewBinding]];
	[self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:detailViewHorizontal options:options metrics:nil views:viewBinding]];
	[self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:actionViewVertical options:options metrics:nil views:viewBinding]];
	[self closeDetailViewAnimation:false complete:nil];
}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
	UIView *view = [super hitTest:point withEvent:event];
	if (view == self) {
		return nil;
	}
	return view;
}

- (void)setTitleModelArray:(NSArray <HTDropBoxProtocol> *)titleModelArray {
	_titleModelArray = titleModelArray;
	[self.titleView setModelArray:titleModelArray];
}

- (void)reloadData {
	[self.titleView reloadData];
	[self closeDetailViewAnimation:false complete:nil];
}

- (void)closeDetailViewAnimation:(BOOL)animation complete:(HTDropBoxAnimationComplete)complete {
	self.willOpenDetailConstraint.active = false;
	self.willCloseDetailConstraint.active = true;
	
	[UIView animateWithDuration:animation ? 0.25 : 0 animations:^{
		self.backgroundView.alpha = 0;
		[self layoutIfNeeded];
	} completion:^(BOOL finished) {
		self.backgroundView.hidden = self.detailView.hidden = self.actionView.hidden = true;
		[self.titleModelArray enumerateObjectsUsingBlock:^(id <HTDropBoxProtocol> titleModel, NSUInteger index, BOOL * _Nonnull stop) {
			titleModel.isSelected = false;
		}];
		[self.titleView reloadData];
		if (complete) {
			complete();
		}
	}];
}

- (void)openDetailViewAnimation:(BOOL)animation complete:(HTDropBoxAnimationComplete)complete {
	self.willCloseDetailConstraint.active = false;
	self.willOpenDetailConstraint.active = true;
	self.backgroundView.hidden = self.detailView.hidden = self.actionView.hidden = false;

	[UIView animateWithDuration:animation ? 0.25 : 0 animations:^{
		self.backgroundView.alpha = 1;
		[self layoutIfNeeded];
	} completion:^(BOOL finished) {
		if (complete) {
			complete();
		}
	}];
}

- (void)detailBackgroundTapGesture:(UITapGestureRecognizer *)gesture {
	[self closeDetailViewAnimation:true complete:nil];
}

- (void)actionViewCancelButtonTaped {
	[self closeDetailViewAnimation:true complete:nil];
}

- (void)actionViewSureButtonTaped {
	
	__weak typeof(self) weakSelf = self;
	[self closeDetailViewAnimation:true complete:^{
		if (weakSelf.sureReloadBlock) {
			weakSelf.sureReloadBlock();
		}
	}];
}

- (HTDropBoxTitleView *)titleView {
	if (!_titleView) {
		_titleView = [[HTDropBoxTitleView alloc] init];
		
		__weak typeof(self) weakSelf = self;
		[_titleView setDidSelectedBlock:^(id <HTDropBoxProtocol> model) {
			if (model.isSelected) {
				NSMutableArray <HTDropBoxProtocol> *detailModelArray = model.selectedModelArray;
				CGFloat detailHeight = [weakSelf.detailView heightWithSetModelArray:detailModelArray];
				detailHeight = MIN(detailHeight, 300);
				weakSelf.detailHeightConstraint.constant = detailHeight;
				[weakSelf.detailView reloadData];
				[weakSelf openDetailViewAnimation:true complete:nil];
			} else {
				[weakSelf closeDetailViewAnimation:true complete:nil];
			}
		}];
	}
	return _titleView;
}

- (HTDropBoxDetailView *)detailView {
	if (!_detailView) {
		_detailView = [[HTDropBoxDetailView alloc] init];
	}
	return _detailView;
}

- (HTDropBoxActionView *)actionView {
	if (!_actionView) {
		_actionView = [[HTDropBoxActionView alloc] init];
		[_actionView.cancelNameButton addTarget:self action:@selector(actionViewCancelButtonTaped) forControlEvents:UIControlEventTouchUpInside];
		[_actionView.sureNameButton addTarget:self action:@selector(actionViewSureButtonTaped) forControlEvents:UIControlEventTouchUpInside];
	}
	return _actionView;
}

- (UIView *)backgroundView {
	if (!_backgroundView) {
		_backgroundView = [[UIView alloc] init];
		_backgroundView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.3];
		UITapGestureRecognizer *gestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(detailBackgroundTapGesture:)];
		[_backgroundView addGestureRecognizer:gestureRecognizer];
	}
	return _backgroundView;
}

@end
