//
//  HTBackgroundController.m
//  School
//
//  Created by hublot on 2017/8/30.
//  Copyright © 2017年 hublot. All rights reserved.
//

#import "HTBackgroundController.h"
#import <HTKeyboardController.h>
#import <UITableView+HTSeparate.h>
#import "HTSchoolMatriculateCell.h"
#import "HTSchoolMatriculateModel.h"
#import "HTBackgroundResultController.h"
#import "HTUserManager.h"

@interface HTBackgroundController ()

@property (nonatomic, strong) UIImageView *backgroundImageView;

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) HTSchoolMatriculateSectionModel *backgroundSectionModel;

@property (nonatomic, strong) UIButton *submitMatriculateButton;

@end

@implementation HTBackgroundController

- (void)viewDidLoad {
	[super viewDidLoad];
	[self initializeDataSource];
	[self initializeUserInterface];
}

- (void)initializeDataSource {
	
}

- (void)initializeUserInterface {
	self.navigationItem.title = @"背景测评";
	UIView *contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, HTSCREENWIDTH, 150)];
	[contentView addSubview:self.submitMatriculateButton];
	self.submitMatriculateButton.center = contentView.center;
	self.tableView.tableFooterView = contentView;
	[self.view addSubview:self.backgroundImageView];
	[self.view addSubview:self.tableView];
	
	[self.tableView mas_updateConstraints:^(MASConstraintMaker *make) {
		make.edges.mas_equalTo(UIEdgeInsetsZero);
	}];
}

- (UIImageView *)backgroundImageView {
	if (!_backgroundImageView) {
		
		UIImage *image = [UIImage imageNamed:@"cn_school_background_result_header"];
		CGFloat scale = HTSCREENWIDTH / image.size.width;
		image = [image ht_resetSizeZoomNumber:scale];
		UIEdgeInsets imageCatInsets = UIEdgeInsetsMake(image.size.height * 0.75, 0, 0, 0);
		UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, imageCatInsets.top)];
		self.tableView.tableHeaderView = headerView;
		
		_backgroundImageView = [[UIImageView alloc] init];
		image = [image resizableImageWithCapInsets:imageCatInsets resizingMode:UIImageResizingModeStretch];
		_backgroundImageView.image = image;
	}
	return _backgroundImageView;
}

- (UITableView *)tableView {
	if (!_tableView) {
		_tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
		_tableView.backgroundColor = [UIColor clearColor];
		_tableView.separatorColor = [[UIColor ht_colorStyle:HTColorStyleTintColor] colorWithAlphaComponent:0.2];
		_tableView.allowsSelection = false;
		
		[_tableView ht_whenTap:^(UIView *view) {
			[HTKeyboardController resignFirstResponder];
		}];
		
		__weak typeof(self) weakSelf = self;
		[_tableView ht_updateSection:0 sectionMakerBlock:^(HTTableViewSectionMaker *sectionMaker) {
			[sectionMaker.cellClass([HTSchoolMatriculateCell class]).modelArray(weakSelf.backgroundSectionModel.matriculateModelArray) customCellBlock:^(UITableView *tableView, NSInteger row, __kindof HTSchoolMatriculateCell *cell, __kindof NSObject *model) {
				cell.backgroundColor = [UIColor clearColor];
				cell.cellEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 10);
				cell.separatorInset = UIEdgeInsetsMake(0, 10, 0, 10);
			}];
		}];
		
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

- (UIButton *)submitMatriculateButton {
	if (!_submitMatriculateButton) {
		_submitMatriculateButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 250, 40)];
		_submitMatriculateButton.layer.cornerRadius = _submitMatriculateButton.bounds.size.height / 2;
		_submitMatriculateButton.layer.masksToBounds = true;
		[_submitMatriculateButton setTitle:@"点击提交" forState:UIControlStateNormal];
		[_submitMatriculateButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
		UIColor *normalColor = [UIColor ht_colorStyle:HTColorStyleTintColor];
		UIColor *higlightColor = [normalColor colorWithAlphaComponent:0.5];
		UIImage *normalImage = [UIImage ht_pureColor:normalColor];
		UIImage *higlightImage = [UIImage ht_pureColor:higlightColor];
		[_submitMatriculateButton setBackgroundImage:normalImage forState:UIControlStateNormal];
		[_submitMatriculateButton setBackgroundImage:higlightImage forState:UIControlStateHighlighted];
		
		__weak typeof(self) weakSelf = self;
		[_submitMatriculateButton ht_whenTap:^(UIView *view) {
			[HTUserManager surePermissionHighOrEqual:HTUserPermissionExerciseAbleUser passCompareBlock:^(HTUser *user) {
				@try {
					[HTSchoolMatriculateSectionModel packResultRequestParameterWithSectionModelArray:@[weakSelf.backgroundSectionModel] onlyForSingleSchool:false completeBlock:^(NSDictionary *parameter, NSString *errorString, NSIndexPath *errorIndexPath) {
						if (errorString.length) {
							[HTAlert title:errorString];
							[weakSelf.tableView scrollToRowAtIndexPath:errorIndexPath atScrollPosition:UITableViewScrollPositionTop animated:true];
							return;
						}
						HTNetworkModel *networkModel = [[HTNetworkModel alloc] init];
						networkModel.autoAlertString = @"提交背景测评";
						networkModel.autoShowError = true;
						networkModel.offlineCacheStyle = HTCacheStyleNone;
						[HTRequestManager requestBackgroundResultWithNetworkModel:networkModel parameter:parameter complete:^(id response, HTError *errorModel) {
							if (errorModel.existError) {
								return;
							}
							HTBackgroundResultController *resultController = [[HTBackgroundResultController alloc] init];
							resultController.parameter = parameter;
							[weakSelf.navigationController pushViewController:resultController animated:true];
						}];
					}];
				} @catch (NSException *exception) {
					
				} @finally {
					
				}
			}];
		}];
	}
	return _submitMatriculateButton;
}

- (HTSchoolMatriculateSectionModel *)backgroundSectionModel {
	if (!_backgroundSectionModel) {
		_backgroundSectionModel = [HTSchoolMatriculateSectionModel packBackgroundSectionModelArray].firstObject;
	}
	return _backgroundSectionModel;
}

@end
