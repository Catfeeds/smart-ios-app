//
//  HTCommunityIssueController.m
//  GMat
//
//  Created by hublot on 2016/10/26.
//  Copyright © 2016年 thinku. All rights reserved.
//

#import "HTCommunityIssueController.h"
#import "HTPlaceholderTextView.h"
#import <UITableView+HTSeparate.h>
#import "HTPhotoCollectionView.h"
#import "HTLoginManager.h"
#import "HTManagerController.h"
#import "UIScrollView+HTRefresh.h"
#import "YYImageCoder.h"
#import <NSObject+HTTableRowHeight.h>
#import "HTUserManager.h"

@interface HTCommunityIssueController ()

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) UITextField *titleNameTextField;

@property (nonatomic, strong) HTPlaceholderTextView *detailNameTextView;

@property (nonatomic, strong) HTPhotoCollectionView *pictureCollectionView;

@property (nonatomic, strong) UIButton *sureIssueButton;

@end

@implementation HTCommunityIssueController

- (void)viewDidLoad {
	[super viewDidLoad];
	[self initializeDataSource];
	[self initializeUserInterface];
}

- (void)initializeDataSource {
	
}

- (void)initializeUserInterface {
	self.navigationItem.title = @"发表帖子";
	[self.view addSubview:self.tableView];
//	[self ht_addFallowKeyBoardView:self.detailNameTextView style:HTKeyBoardStyleHeight customKeyBoardHeight:nil];
//	[self ht_addFallowKeyBoardView:self.sureIssueButton style:HTKeyBoardStylePoint customKeyBoardHeight:nil];
//	[self ht_addFallowKeyBoardView:self.pictureCollectionView style:HTKeyBoardStylePoint customKeyBoardHeight:nil];
}

- (UITableView *)tableView {
	if (!_tableView) {
		_tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
		_tableView.allowsSelection = false;
		_tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
		__weak HTCommunityIssueController *weakSelf = self;
		[_tableView ht_updateSection:0 sectionMakerBlock:^(HTTableViewSectionMaker *sectionMaker) {
			[sectionMaker.modelArray(@[weakSelf.titleNameTextField, weakSelf.detailNameTextView, weakSelf.pictureCollectionView, weakSelf.sureIssueButton]) customCellBlock:^(UITableView *tableView, NSInteger row, __kindof UITableViewCell *cell, __kindof UIView *model) {
				[cell addSubview:model];
				if (row > 0) {
					cell.separatorInset = UIEdgeInsetsMake(0, HTSCREENWIDTH, 0, 0);
				}
				
				CGFloat modelHeigth = model.ht_h;
                [model ht_setRowHeightNumber:@(modelHeigth) forCellClass:cell.class];
			}];
		}];
	}
	return _tableView;
}


- (UITextField *)titleNameTextField {
	if (!_titleNameTextField) {
		_titleNameTextField = [[UITextField alloc] initWithFrame:CGRectMake(15, 0, self.view.ht_w - 30, 50)];
		_titleNameTextField.font = [UIFont systemFontOfSize:14];
		_titleNameTextField.textColor = [UIColor ht_colorStyle:HTColorStylePrimaryTitle];
		_titleNameTextField.placeholder = @" 请输入标题";
		NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:@" 请输入标题" attributes:@{NSForegroundColorAttributeName:[UIColor ht_colorStyle:HTColorStyleSecondaryTitle], NSFontAttributeName:[UIFont systemFontOfSize:14]}];
		_titleNameTextField.attributedPlaceholder = attributedString;
	}
	return _titleNameTextField;
}

- (HTPlaceholderTextView *)detailNameTextView {
	if (!_detailNameTextView) {
		_detailNameTextView = [[HTPlaceholderTextView alloc] initWithFrame:CGRectMake(10, 0, self.view.ht_w - 20, 230)];
		_detailNameTextView.font = [UIFont systemFontOfSize:14];
		_detailNameTextView.textColor = [UIColor ht_colorStyle:HTColorStylePrimaryTitle];
		_detailNameTextView.ht_placeholder = @" 写点什么...";
	}
	return _detailNameTextView;
}

- (HTPhotoCollectionView *)pictureCollectionView {
	if (!_pictureCollectionView) {
		UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
		flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
		_pictureCollectionView = [[HTPhotoCollectionView alloc] initWithFrame:CGRectMake(0, 0, self.view.ht_w, HTADAPT568(80)) collectionViewLayout:flowLayout];
	}
	return _pictureCollectionView;
}

- (UIButton *)sureIssueButton {
	if (!_sureIssueButton) {
		CGFloat width = self.view.ht_w - HTADAPT568(100);
		CGFloat height = 40;
		_sureIssueButton = [[UIButton alloc] initWithFrame:CGRectMake((HTSCREENWIDTH - width) / 2, 0, width, height)];
		_sureIssueButton.layer.cornerRadius = _sureIssueButton.ht_h / 2;
		_sureIssueButton.layer.masksToBounds = true;
		_sureIssueButton.titleLabel.font = [UIFont systemFontOfSize:14];
		[_sureIssueButton setTitle:@"发表" forState:UIControlStateNormal];
		[_sureIssueButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
		[_sureIssueButton setBackgroundImage:[UIImage ht_pureColor:[UIColor ht_colorStyle:HTColorStylePrimaryTheme]] forState:UIControlStateNormal];
		[_sureIssueButton setBackgroundImage:[UIImage ht_pureColor:[UIColor ht_colorString:@"5f88c1"]] forState:UIControlStateHighlighted];
		[_sureIssueButton setBackgroundImage:[UIImage ht_pureColor:[UIColor lightGrayColor]] forState:UIControlStateDisabled];
		
		__weak HTCommunityIssueController *weakSelf = self;
		[self.titleNameTextField bk_addEventHandler:^(id sender) {
			weakSelf.sureIssueButton.enabled = weakSelf.detailNameTextView.hasText && weakSelf.titleNameTextField.hasText;
		} forControlEvents:UIControlEventEditingChanged];
		[self.detailNameTextView bk_addObserverForKeyPath:NSStringFromSelector(@selector(ht_currentText)) options:NSKeyValueObservingOptionInitial task:^(id obj, NSDictionary *change) {
			weakSelf.sureIssueButton.enabled = weakSelf.detailNameTextView.hasText && weakSelf.titleNameTextField.hasText;
		}];
		[_sureIssueButton ht_whenTap:^(UIView *view) {
			[HTUserManager surePermissionHighOrEqual:HTUserPermissionExerciseAbleUser passCompareBlock:^(HTUser *user) {
				[HTAlert showProgress];
				[weakSelf.tableView endEditing:true];
				NSMutableArray *uploadSuccessImageArray = [@[] mutableCopy];
				if (weakSelf.pictureCollectionView.imageModelArray.count) {
					[weakSelf.pictureCollectionView.imageModelArray enumerateObjectsUsingBlock:^(UIImage * _Nonnull image, NSUInteger idx, BOOL * _Nonnull stop) {
						NSData *imageData = [image imageDataRepresentation];
						HTUploadFileDataType uploadFileDataType = HTUploadFileDataTypeJpg;
						if ([UIImage ht_imageStyleWithData:imageData] == HTImageTypeGif) {
							uploadFileDataType = HTUploadFileDataTypeGif;
						}
						HTNetworkModel *networkModel = [[HTNetworkModel alloc] init];
						networkModel.autoAlertString = nil;
						networkModel.offlineCacheStyle = HTCacheStyleNone;
						networkModel.autoShowError = true;
						
						HTUploadModel *uploadModel = [[HTUploadModel alloc] init];
						uploadModel.uploadData = imageData;
						uploadModel.uploadType = uploadFileDataType;
						networkModel.uploadModelArray = @[uploadModel];
						[HTRequestManager requestGossipUploadGossipImageWithNetworkModel:networkModel complete:^(id response, HTError *errorModel) {
							if (errorModel.existError) {
								[HTAlert hideProgress];
								return;
							}
							[uploadSuccessImageArray addObject:response[@"image"]];
							if (uploadSuccessImageArray.count == weakSelf.pictureCollectionView.imageModelArray.count) {
								[weakSelf issueArticleWithImageArray:uploadSuccessImageArray];
							}
						}];
					}];
				} else {
					[weakSelf issueArticleWithImageArray:uploadSuccessImageArray];
				}
			}];
		}];
	}
	return _sureIssueButton;
}

- (void)issueArticleWithImageArray:(NSArray *)imageArray {
	__weak HTCommunityIssueController *weakSelf = self;
	HTNetworkModel *networkModel = [[HTNetworkModel alloc] init];
	networkModel.autoAlertString = nil;
	networkModel.offlineCacheStyle = HTCacheStyleNone;
	networkModel.autoShowError = true;
	[HTRequestManager requestGossipSendGossipWithNetworkModel:networkModel gossipTitleString:self.titleNameTextField.text gossipDetailString:self.detailNameTextView.text imageSourceArray:imageArray complete:^(id response, HTError *errorModel) {
		[HTAlert hideProgress];
		if (errorModel.existError) {
			return;
		}
		[HTAlert title:@"发表成功"];
		HTCommunityController *communityController = [HTManagerController defaultManagerController].communityController;
		[weakSelf.navigationController popViewControllerAnimated:true];
		[communityController.tableView ht_startRefreshHeader];
	}];
}

@end
