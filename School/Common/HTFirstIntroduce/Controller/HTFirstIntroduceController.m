//
//  HTFirstIntroduceController.m
//  School
//
//  Created by hublot on 2017/6/14.
//  Copyright © 2017年 hublot. All rights reserved.
//

#import "HTFirstIntroduceController.h"
#import "HTManagerController.h"

@interface HTFirstIntroduceController ()

@property (nonatomic, strong) UIImageView *logoImageView;

@property (nonatomic, strong) UIScrollView *scrollView;

@end

@implementation HTFirstIntroduceController

- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
	[[UIApplication sharedApplication] setStatusBarHidden:true withAnimation:UIStatusBarAnimationNone];
}

- (void)viewWillDisappear:(BOOL)animated {
	[super viewWillDisappear:animated];
	[[UIApplication sharedApplication] setStatusBarHidden:false withAnimation:UIStatusBarAnimationNone];
	[[HTManagerController defaultManagerController].tabBarController viewWillAppear:animated];
}

- (void)viewDidDisappear:(BOOL)animated {
	[super viewDidDisappear:animated];
	[[HTManagerController defaultManagerController].tabBarController viewDidAppear:animated];
}

- (void)viewDidLoad {
	if (self.loadViewBlock) {
		self.loadViewBlock(self.view);
	}
	[self.view addSubview:self.scrollView];
	[self.view addSubview:self.logoImageView];
	NSArray *imageArray = @[@"cn2_launch_introduce_1.png", @"cn2_launch_introduce_2.png", @"cn2_launch_introduce_3.png"];
	
	__weak HTFirstIntroduceController *weakSelf = self;
	[imageArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
		UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(idx * weakSelf.scrollView.ht_w, 0, weakSelf.scrollView.ht_w, weakSelf.scrollView.ht_h)];
		imageView.image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForAuxiliaryExecutable:imageArray[idx]]];
		[weakSelf.scrollView addSubview:imageView];
		if (idx == imageArray.count - 1) {
			imageView.userInteractionEnabled = true;
			[imageView ht_whenTap:^(UIView *view) {
				[UIView animateWithDuration:0.25 animations:^{
					weakSelf.view.ht_x -= weakSelf.scrollView.ht_w;
				} completion:^(BOOL finished) {
					[weakSelf removeFirstIntroduce];
				}];
			}];
		}
	}];
	self.scrollView.contentSize = CGSizeMake(self.scrollView.ht_w * imageArray.count, self.scrollView.ht_h);
}

- (void)removeFirstIntroduce {
	[self viewWillDisappear:true];
	[self removeFromParentViewController];
	[self.view removeFromSuperview];
	[self didMoveToParentViewController:nil];
	[self viewDidDisappear:true];
}

- (UIImageView *)logoImageView {
	if (!_logoImageView) {
		UIImage *image = [UIImage imageNamed:@"cn_leige_logo"];
		image = [image ht_resetSizeWithStandard:80 isMinStandard:false];
		_logoImageView = [[UIImageView alloc] initWithImage:image];
		_logoImageView.ht_x = 30;
		_logoImageView.ht_y = 30;
	}
	return _logoImageView;
}

- (UIScrollView *)scrollView {
	if (!_scrollView) {
		_scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
		_scrollView.pagingEnabled = true;
		_scrollView.showsVerticalScrollIndicator = false;
		_scrollView.showsHorizontalScrollIndicator = false;
		_scrollView.bounces = false;
	}
	return _scrollView;
}

@end
