//
//  HTSchoolMatriculateDetailController.m
//  School
//
//  Created by hublot on 2017/6/16.
//  Copyright © 2017年 hublot. All rights reserved.
//

#import "HTSchoolMatriculateDetailController.h"
#import "HTSchoolMatriculateModel.h"
#import <UITableView+HTSeparate.h>
#import "HTSchoolMatriculateCell.h"
#import "HTSchoolMatriculateHeaderView.h"
#import <UITableViewCell_HTSeparate.h>
#import <UITableViewHeaderFooterView_HTSeparate.h>
#import "HTSchoolMatriculateResultController.h"
#import <HTKeyboardController.h>
#import "HTUserManager.h"

@interface HTSchoolMatriculateDetailController ()

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSArray <HTSchoolMatriculateSectionModel *> *modelArray;

@property (nonatomic, strong) UIButton *submitMatriculateButton;

@end

@implementation HTSchoolMatriculateDetailController

- (void)viewDidLoad {
	[super viewDidLoad];
	[self initializeDataSource];
	[self initializeUserInterface];
}

- (void)initializeDataSource {
	
}

- (void)initializeUserInterface {
	self.navigationItem.title = @"选校测评";
	UIView *contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, HTSCREENWIDTH, 150)];
	[contentView addSubview:self.submitMatriculateButton];
	self.submitMatriculateButton.center = contentView.center;
	self.tableView.tableFooterView = contentView;
	[self.view addSubview:self.tableView];
	
	[self.tableView mas_updateConstraints:^(MASConstraintMaker *make) {
		make.edges.mas_equalTo(UIEdgeInsetsZero);
	}];
}

- (UITableView *)tableView {
	if (!_tableView) {
		_tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
		_tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
		_tableView.backgroundColor = [UIColor ht_colorString:@"f8f8f8"];
		[_tableView ht_whenTap:^(UIView *view) {
			[HTKeyboardController resignFirstResponder];
		}];
		
		__weak typeof(self) weakSelf = self;
		[self.modelArray enumerateObjectsUsingBlock:^(HTSchoolMatriculateSectionModel *sectionModel, NSUInteger index, BOOL * _Nonnull stop) {
			[weakSelf.tableView ht_updateSection:index sectionMakerBlock:^(HTTableViewSectionMaker *sectionMaker) {
				[[sectionMaker.cellClass([HTSchoolMatriculateCell class]).modelArray(sectionModel.matriculateModelArray).headerClass([HTSchoolMatriculateHeaderView class]).headerHeight(50).footerHeight(20) customHeaderBlock:^(UITableView *tableView, NSInteger section, __kindof HTSchoolMatriculateHeaderView *reuseView, __kindof NSArray *modelArray) {
					[reuseView setModelArray:sectionModel section:section];
					[reuseView setDidSelectedBlock:^{
						sectionModel.isSelected = !sectionModel.isSelected;
						[weakSelf.tableView ht_updateSection:section sectionMakerBlock:^(HTTableViewSectionMaker *sectionMaker) {
							sectionMaker.modelArray(sectionModel.matriculateModelArray);
						}];
					}];
				}] customCellBlock:^(UITableView *tableView, NSInteger row, __kindof HTSchoolMatriculateCell *cell, __kindof NSObject *model) {
					cell.cellEdgeInsets = UIEdgeInsetsMake(3, 0, 0, 0);
				}];
			}];
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
		
		__weak HTSchoolMatriculateDetailController *weakSelf = self;
		[_submitMatriculateButton ht_whenTap:^(UIView *view) {
			[HTUserManager surePermissionHighOrEqual:HTUserPermissionExerciseAbleUser passCompareBlock:^(HTUser *user) {
				@try {
					[HTSchoolMatriculateSectionModel packResultRequestParameterWithSectionModelArray:weakSelf.modelArray onlyForSingleSchool:false completeBlock:^(NSDictionary *parameter, NSString *errorString, NSIndexPath *errorIndexPath) {
						if (errorString.length) {
							[HTAlert title:errorString];
							[weakSelf.tableView scrollToRowAtIndexPath:errorIndexPath atScrollPosition:UITableViewScrollPositionTop animated:true];
							return;
						}
						HTNetworkModel *networkModel = [[HTNetworkModel alloc] init];
						networkModel.autoAlertString = @"上传智能选校";
						networkModel.autoShowError = true;
						networkModel.offlineCacheStyle = HTCacheStyleNone;
						[HTRequestManager requestSendSchoolMatriculateWithNetworkModel:networkModel parameter:parameter complete:^(id response, HTError *errorModel) {
							if (errorModel.existError) {
								return;
							}
							HTSchoolMatriculateResultController *resultController = [[HTSchoolMatriculateResultController alloc] init];
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

- (NSArray <HTSchoolMatriculateSectionModel *> *)modelArray {
	if (!_modelArray) {
		_modelArray = [HTSchoolMatriculateSectionModel packSectionModelArrayOnlyForSingleSchool:false];
	}
	return _modelArray;
}

@end
