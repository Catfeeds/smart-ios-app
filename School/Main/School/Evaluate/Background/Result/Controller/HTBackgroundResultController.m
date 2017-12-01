//
//  HTBackgroundResultController.m
//  School
//
//  Created by hublot on 2017/8/30.
//  Copyright © 2017年 hublot. All rights reserved.
//

#import "HTBackgroundResultController.h"
#import "HTBackgroundResultView.h"

@interface HTBackgroundResultController ()

@property (nonatomic, strong) UIImageView *backgroundImageView;

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) HTBackgroundResultView *headerResultView;

@end

@implementation HTBackgroundResultController

- (void)viewDidLoad {
	[super viewDidLoad];
	[self initializeDataSource];
	[self initializeUserInterface];
}

- (void)initializeDataSource {
	
}

- (void)initializeUserInterface {
	self.navigationItem.title = @"测评结果";
	[self.view addSubview:self.backgroundImageView];
	[self.view addSubview:self.tableView];
}

- (UIImageView *)backgroundImageView {
	if (!_backgroundImageView) {
		
		UIImage *image = [UIImage imageNamed:@"cn_school_background_result_header"];
		CGFloat scale = HTSCREENWIDTH / image.size.width;
		image = [image ht_resetSizeZoomNumber:scale];
		UIEdgeInsets imageCatInsets = UIEdgeInsetsMake(image.size.height * 0.75, 0, 0, 0);

		UIView *headerContentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, HTSCREENWIDTH, imageCatInsets.top)];
		self.headerResultView.ht_y = imageCatInsets.top;
		headerContentView.ht_h += self.headerResultView.intrinsicContentSize.height;
		self.tableView.tableHeaderView = headerContentView;
		[headerContentView addSubview:self.headerResultView];

		_backgroundImageView = [[UIImageView alloc] init];
		image = [image resizableImageWithCapInsets:imageCatInsets resizingMode:UIImageResizingModeStretch];
		_backgroundImageView.image = image;
	}
	return _backgroundImageView;
}

- (UITableView *)tableView {
	if (!_tableView) {
		_tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
		_tableView.backgroundColor = [UIColor clearColor];
		
		__weak typeof(self) weakSelf = self;
		[_tableView bk_addObserverForKeyPath:NSStringFromSelector(@selector(contentOffset)) options:NSKeyValueObservingOptionInitial task:^(id obj, NSDictionary *change) {
			weakSelf.backgroundImageView.ht_y = - weakSelf.tableView.contentOffset.y;
		}];
		
		[_tableView bk_addObserverForKeyPath:NSStringFromSelector(@selector(contentSize)) options:NSKeyValueObservingOptionInitial task:^(id obj, NSDictionary *change) {
			weakSelf.backgroundImageView.ht_size = weakSelf.tableView.contentSize;
			weakSelf.backgroundImageView.ht_h += [UIScreen mainScreen].bounds.size.height;
		}];
	}
	return _tableView;
}

- (HTBackgroundResultView *)headerResultView {
	if (!_headerResultView) {
		_headerResultView = [[HTBackgroundResultView alloc] initWithFrame:CGRectMake(0, 0, HTSCREENWIDTH, 0)];
	}
	return _headerResultView;
}


@end
