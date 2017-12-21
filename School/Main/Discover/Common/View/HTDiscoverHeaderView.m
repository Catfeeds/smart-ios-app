//
//  HTDiscoverHeaderView.m
//  School
//
//  Created by hublot on 2017/7/31.
//  Copyright © 2017年 hublot. All rights reserved.
//

#import "HTDiscoverHeaderView.h"
#import <HTScrollPageView.h>
#import "HTIndexModel.h"
#import "HTWebController.h"
#import "HTDiscoverActivityModel.h"
#import "HTDiscoverActivityDetailController.h"
#import <UITableView+HTSeparate.h>
#import "HTActivityTopLineCell.h"

@interface HTDiscoverHeaderView ()

@property (nonatomic, strong) HTScrollPageView *bannerView;

@property (nonatomic, strong) UIPageControl *pageControl;

@property (nonatomic, strong) UIImageView *topLineImageView;

@property (nonatomic, strong) UITableView *topLineTabelView;

@end

@implementation HTDiscoverHeaderView

+ (CGFloat)topLineCellHeight {
	return 25;
}

+ (NSInteger)topLineCellCount {
	return 3;
}

- (void)didMoveToSuperview {
	[self addSubview:self.bannerView];
	[self addSubview:self.pageControl];
	[self addSubview:self.topLineImageView];
	[self addSubview:self.topLineTabelView];
	
	[self.topLineTabelView mas_updateConstraints:^(MASConstraintMaker *make) {
		make.right.bottom.mas_equalTo(self);
		make.left.mas_equalTo(self);
		make.height.mas_equalTo([self.class topLineCellHeight] * [self.class topLineCellCount]);
	}];
	[self.topLineImageView mas_updateConstraints:^(MASConstraintMaker *make) {
		make.centerX.mas_equalTo(self);
		make.bottom.mas_equalTo(self.topLineTabelView.mas_top);
	}];
	[self.bannerView mas_updateConstraints:^(MASConstraintMaker *make) {
		make.top.left.right.mas_equalTo(self);
		make.bottom.mas_equalTo(self.topLineImageView.mas_top);
	}];
	[self.pageControl mas_updateConstraints:^(MASConstraintMaker *make) {
		make.left.right.bottom.mas_equalTo(self.bannerView);
		make.height.mas_equalTo(30);
	}];
}

- (void)setBannerModelArray:(NSArray *)bannerModelArray {
	_bannerModelArray = bannerModelArray;
	self.bannerView.numberOfRows = bannerModelArray.count;
	self.pageControl.numberOfPages = bannerModelArray.count;
	
	__weak typeof(self) weakSelf = self;
	[self.bannerView setButtonForIndexPath:^(UIButton *button, NSInteger index){
		HTDiscoverActivityModel *bannerModel = bannerModelArray[index];
		[button sd_setBackgroundImageWithURL:[NSURL URLWithString:SmartApplyResourse(bannerModel.image)] forState:UIControlStateNormal placeholderImage:HTPLACEHOLDERIMAGE];
	}];
	[self.bannerView setWillDisplayIndexPath:^(UIButton *button, NSInteger index){
		weakSelf.pageControl.currentPage = index;
	}];
	[self.bannerView setDidSelectedIndexPath:^(UIButton *button, NSInteger index){
		HTDiscoverActivityModel *bannerModel = bannerModelArray[index];
		HTDiscoverActivityDetailController *detailController = [[HTDiscoverActivityDetailController alloc] init];
		detailController.activityIdString = bannerModel.ID;
		[weakSelf.ht_controller.navigationController pushViewController:detailController animated:true];
	}];
	[self.bannerView reloadData];
}

- (void)setTopLineModelArray:(NSArray *)topLineModelArray {
	_topLineModelArray = topLineModelArray;
	if (_topLineModelArray.count > 3) {
		_topLineModelArray = [_topLineModelArray subarrayWithRange:NSMakeRange(0, 3)];
	} 
	
	__weak typeof(self) weakSelf = self;
	[self.topLineTabelView ht_updateSection:0 sectionMakerBlock:^(HTTableViewSectionMaker *sectionMaker) {
		sectionMaker.modelArray(weakSelf.topLineModelArray);
	}];
}

- (HTScrollPageView *)bannerView {
	if (!_bannerView) {
		_bannerView = [[HTScrollPageView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height - self.topLineTabelView.bounds.size.height)];
	}
	return _bannerView;
}

- (UIPageControl *)pageControl {
	if (!_pageControl) {
		_pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, self.bannerView.bounds.size.height - 30, self.bannerView.bounds.size.width, 30)];
		_pageControl.pageIndicatorTintColor = [UIColor whiteColor];
		_pageControl.currentPageIndicatorTintColor = [UIColor ht_colorStyle:HTColorStyleTintColor];
	}
	return _pageControl;
}

- (UIImageView *)topLineImageView {
	if (!_topLineImageView) {
		_topLineImageView = [[UIImageView alloc] init];
		UIImage *newsImage = [UIImage imageNamed:@"cn_activity_news"];
		newsImage = [newsImage ht_resetSizeZoomNumber:0.55];
		UIImage *topImage = [UIImage imageNamed:@"cn_activity_top"];
		topImage = [topImage ht_resetSizeZoomNumber:0.5];
		CGFloat centerEdge = 5;
		UIEdgeInsets edge = UIEdgeInsetsMake(7, 0, 7, 0);
		UIImage *image = [[UIImage alloc] init];
		image = [image ht_resetSize:CGSizeMake(newsImage.size.width + topImage.size.width + centerEdge, MAX(newsImage.size.height, topImage.size.height))];
		image = [image ht_appendImage:newsImage atRect:CGRectMake(0, (image.size.height - newsImage.size.height) / 2, newsImage.size.width, newsImage.size.height)];
		image = [image ht_appendImage:topImage atRect:CGRectMake(newsImage.size.width + centerEdge, (image.size.height - topImage.size.height) / 2, topImage.size.width, topImage.size.height)];
		image = [image ht_insertColor:[UIColor clearColor] edge:edge];
		_topLineImageView.image = image;
	}
	return _topLineImageView;
}

- (UITableView *)topLineTabelView {
	if (!_topLineTabelView) {
		CGFloat topLineCellHeight = [self.class topLineCellHeight];
		_topLineTabelView = [[UITableView alloc] initWithFrame:CGRectZero];
		_topLineTabelView.scrollEnabled = false;
		_topLineTabelView.separatorStyle = UITableViewCellSeparatorStyleNone;
		
		__weak typeof(self) weakSelf = self;
		[_topLineTabelView ht_updateSection:0 sectionMakerBlock:^(HTTableViewSectionMaker *sectionMaker) {
			[sectionMaker.cellClass([HTActivityTopLineCell class]).rowHeight(topLineCellHeight) didSelectedCellBlock:^(UITableView *tableView, NSInteger row, __kindof UITableViewCell *cell, __kindof HTDiscoverActivityModel *model) {
				HTDiscoverActivityDetailController *detailController = [[HTDiscoverActivityDetailController alloc] init];
				detailController.activityIdString = model.ID;
				[weakSelf.ht_controller.navigationController pushViewController:detailController animated:true];
			}];
		}];
	}
	return _topLineTabelView;
}

@end
