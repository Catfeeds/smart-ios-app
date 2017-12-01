//
//  HTSchoolMatriculateSingleController.m
//  School
//
//  Created by hublot on 2017/6/21.
//  Copyright © 2017年 hublot. All rights reserved.
//

#import "HTSchoolMatriculateSingleController.h"
#import "HTSchoolMatriculateModel.h"
#import "HTSchoolMatriculateCell.h"
#import "HTSchoolMatriculateHeaderView.h"
#import "HTSchoolMatriculateSingleResultView.h"
#import <UITableViewCell_HTSeparate.h>
#import <UITableViewHeaderFooterView_HTSeparate.h>
#import "HTKeyboardController.h"
#import "HTSchoolCell.h"
#import "HTMatriculateRecordModel.h"
#import "HTUserManager.h"

@interface HTSchoolMatriculateSingleController ()

@property (nonatomic, strong) UIButton *footerNameButton;

@property (nonatomic, strong) NSArray <HTSchoolMatriculateSectionModel *> *modelArray;

@property (nonatomic, strong) HTSchoolModel *schoolModel;

@end

@implementation HTSchoolMatriculateSingleController

@synthesize tableView = _tableView, pageModel = _pageModel;

- (void)viewDidLoad {
	[super viewDidLoad];
	[self initializeDataSource];
	[self initializeUserInterface];
}

- (void)viewWillDisappear:(BOOL)animated {
	[super viewWillDisappear:animated];
	[HTKeyboardController resignFirstResponder];
}

- (void)initializeDataSource {
	if (!self.schoolModel) {
		HTSchoolModel *schoolModel = [[HTSchoolModel alloc] init];
		self.schoolModel = schoolModel;
	}
}

- (void)initializeUserInterface {
	self.navigationItem.title = @"学校录取测评";
	[self.view addSubview:self.tableView];
	[self.view addSubview:self.footerNameButton];
	
	[self.footerNameButton mas_remakeConstraints:^(MASConstraintMaker *make) {
		make.left.right.bottom.mas_equalTo(self.view);
		make.height.mas_equalTo(49);
	}];
	
	[self.tableView mas_remakeConstraints:^(MASConstraintMaker *make) {
		make.left.top.right.mas_equalTo(self.view);
		make.bottom.mas_equalTo(self.footerNameButton.mas_top);
	}];
}

- (void)setPageModel:(HTPageModel *)pageModel {
	self.schoolModel = pageModel.modelArray.firstObject;
}

- (void)setEvaluationSchool:(HTSchoolModel *)evaluationSchool{
    _evaluationSchool = evaluationSchool;
	
}

- (void)viewWillAppear:(BOOL)animated{
	if (!self.modelArray) {
		self.modelArray = [HTSchoolMatriculateSectionModel packSectionModelArrayOnlyForSingleSchool:true];
	}
	[self.modelArray enumerateObjectsUsingBlock:^(HTSchoolMatriculateSectionModel *sectionModel, NSUInteger idx, BOOL * _Nonnull stop) {
		if (sectionModel.sectionType == HTSchoolMatriculateSectionTypeSingle) {
			[sectionModel.matriculateModelArray enumerateObjectsUsingBlock:^(HTSchoolMatriculateModel *model, NSUInteger index, BOOL * _Nonnull stop) {
				if (model.type == HTSchoolMatriculateTypeSingleSchool) {
					if (model.pickerModelArray.count == 0 && self.evaluationSchool) {
						self.evaluationSchool.isSelected = YES;
						model.pickerModelArray = @[self.evaluationSchool];
					}
				}
			}];
		}
	}];
}

- (void)setSchoolModel:(HTSchoolModel *)schoolModel {
	if (!schoolModel) {
		_schoolModel = [[HTSchoolModel alloc] init];
	} else {
		_schoolModel = schoolModel;
	}
	[self createModelArrayWithSchoolModel:self.schoolModel];
	
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

- (UITableView *)tableView {
	if (!_tableView) {
		_tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
		_tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
		_tableView.backgroundColor = [UIColor ht_colorString:@"f8f8f8"];
		[_tableView ht_whenTap:^(UIView *view) {
			[HTKeyboardController resignFirstResponder];
		}];
	}
	return _tableView;
}

- (UIButton *)footerNameButton {
	if (!_footerNameButton) {
		_footerNameButton = [[UIButton alloc] init];
		[_footerNameButton setTitle:@"立即评估" forState:UIControlStateNormal];
		_footerNameButton.titleLabel.font = [UIFont systemFontOfSize:17];
		[_footerNameButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
		UIColor *normalColor = [UIColor ht_colorStyle:HTColorStyleTintColor];
		UIColor *higlightColor = [normalColor colorWithAlphaComponent:0.5];
		[_footerNameButton setBackgroundImage:[UIImage ht_pureColor:normalColor] forState:UIControlStateNormal];
		[_footerNameButton setBackgroundImage:[UIImage ht_pureColor:higlightColor] forState:UIControlStateHighlighted];
		
        __weak typeof(self) weakSelf = self;
		[_footerNameButton ht_whenTap:^(UIView *view) {
			[HTUserManager surePermissionHighOrEqual:HTUserPermissionExerciseAbleUser passCompareBlock:^(HTUser *user) {
				@try {
					[HTSchoolMatriculateSectionModel packResultRequestParameterWithSectionModelArray:weakSelf.modelArray onlyForSingleSchool:true completeBlock:^(NSDictionary *parameter, NSString *errorString, NSIndexPath *errorIndexPath) {
						if (errorString.length) {
							[HTAlert title:errorString];
							[weakSelf.tableView scrollToRowAtIndexPath:errorIndexPath atScrollPosition:UITableViewScrollPositionTop animated:true];
							return;
						}
						HTNetworkModel *networkModel = [[HTNetworkModel alloc] init];
						networkModel.autoShowError = true;
						networkModel.autoAlertString = @"获取学校录取测评中";
						networkModel.offlineCacheStyle = HTCacheStyleNone;
						[HTRequestManager requestSchoolSingleMatriculateResultWithNetworkModel:networkModel parameter:parameter complete:^(id response, HTError *errorModel) {
							if (errorModel.existError) {
								return;
							}
							[HTRequestManager requestSchoolMatriculateSingleResultListWithNetworkModel:networkModel resultIdString:nil complete:^(id response, HTError *errorModel) {
								if (errorModel.existError) {
									return;
								}
								HTMatriculateSingleSchoolModel *model = [HTMatriculateSingleSchoolModel mj_objectWithKeyValues:response[@"data"]];
								[HTSchoolMatriculateSingleResultView showResultViewWithResultModel:model];
							}];
						}];
					}];
				} @catch (NSException *exception) {
					
				} @finally {
					
				}
			}];
		}];
	}
	return _footerNameButton;
}

- (void)createModelArrayWithSchoolModel:(HTSchoolModel *)schoolModel {
	if (!self.modelArray) {
		self.modelArray = [HTSchoolMatriculateSectionModel packSectionModelArrayOnlyForSingleSchool:true];
	}
	
	__weak typeof(self) weakSelf = self;
	[self.modelArray enumerateObjectsUsingBlock:^(HTSchoolMatriculateSectionModel *sectionModel, NSUInteger idx, BOOL * _Nonnull stop) {
		if (sectionModel.sectionType == HTSchoolMatriculateSectionTypeSingle) {
			[sectionModel.matriculateModelArray enumerateObjectsUsingBlock:^(HTSchoolMatriculateModel *model, NSUInteger index, BOOL * _Nonnull stop) {
				if (model.type == HTSchoolMatriculateTypeSingleSchool) {
					
					__weak typeof(model) weakModel = model;
					[model bk_removeAllBlockObservers];
					[model bk_addObserverForKeyPath:NSStringFromSelector(@selector(pickerModelArray)) task:^(id target) {
						if (model.pickerSelectedIndex == 0) {
							weakSelf.schoolModel = (HTSchoolModel *)weakModel.pickerModelArray.firstObject;
						}
					}];
				} else if (model.type == HTSchoolMatriculateTypeSingleMajor) {
					NSMutableArray *majorModelArray = [@[] mutableCopy];
					[schoolModel.major enumerateObjectsUsingBlock:^(HTSchoolProfessionalModel *majorModel, NSUInteger idx, BOOL * _Nonnull stop) {
						HTSchoolMatriculateSelectedModel *professionalSelectedModel = [[HTSchoolMatriculateSelectedModel alloc] init];
						professionalSelectedModel.ID = [NSString stringWithFormat:@"%ld", majorModel.ID];
						professionalSelectedModel.name = majorModel.name;
						[majorModelArray addObject:professionalSelectedModel];
					}];
					model.pickerModelArray = majorModelArray;
				}
			}];
		}
	}];
}

@end
