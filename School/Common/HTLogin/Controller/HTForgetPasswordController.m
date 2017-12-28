//
//  HTForgetPasswordController.m
//  School
//
//  Created by hublot on 2017/6/15.
//  Copyright © 2017年 hublot. All rights reserved.
//

#import "HTForgetPasswordController.h"
#import "HTLoginTextFieldGroupView.h"
#import <UITableView+HTSeparate.h>
#import "HTLoginTextFieldCell.h"
#import <HTValidateManager.h>
#import <NSObject+HTTableRowHeight.h>
#import "HTLoginManager.h"

@interface HTForgetPasswordController ()

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) HTLoginTextFieldGroupView *textFieldGroup;

@property (nonatomic, strong) UIButton *sureButton;

@end

@implementation HTForgetPasswordController

- (void)viewDidLoad {
	[super viewDidLoad];
	[self initializeDataSource];
	[self initializeUserInterface];
}

- (void)viewDidLayoutSubviews {
	[super viewDidLayoutSubviews];
	self.sureButton.layer.cornerRadius = self.sureButton.bounds.size.height / 2;
}

- (void)initializeDataSource {
	[HTRequestManager requestMessageCodeSurePersonWithNetworkModel:nil complete:^(id response, HTError *errorModel) {
		
	}];
}

- (void)initializeUserInterface {
	self.navigationItem.title = @"找回密码";
	[self.view addSubview:self.tableView];
	
	__weak HTForgetPasswordController *weakSelf = self;
	NSArray *textFieldArray = @[self.textFieldGroup.phoneEmailTextField, self.textFieldGroup.messageCodeTextField, self.textFieldGroup.passwordTextField, self.sureButton];
	self.textFieldGroup.passwordTextField.placeholder = @"请输入新的密码(支持数字和大小写字母)";
	
	[self.tableView ht_updateSection:0 sectionMakerBlock:^(HTTableViewSectionMaker *sectionMaker) {
		[sectionMaker.cellClass([HTLoginTextFieldCell class]).modelArray(textFieldArray) customCellBlock:^(UITableView *tableView, NSInteger row, __kindof UITableViewCell *cell, __kindof UIView *model) {
			[cell addSubview:model];
			CGFloat rowHeight = 50;
			if (row == 1) {
				[cell addSubview:weakSelf.textFieldGroup.messageCodeButton];
				[model mas_makeConstraints:^(MASConstraintMaker *make) {
					make.left.top.bottom.mas_equalTo(cell);
					make.width.mas_equalTo(cell).multipliedBy(0.6);
				}];
				[weakSelf.textFieldGroup.messageCodeButton mas_makeConstraints:^(MASConstraintMaker *make) {
					make.right.mas_equalTo(cell);
					make.top.mas_equalTo(cell).offset(2);
					make.bottom.mas_equalTo(cell).offset(- 2);
					make.left.mas_equalTo(model.mas_right).offset(10);
				}];
			} else if (row == 3) {
				rowHeight = 80;
				[model mas_updateConstraints:^(MASConstraintMaker *make) {
					make.height.mas_equalTo(40);
					make.centerY.left.right.mas_equalTo(cell);
				}];
			} else {
				[model mas_makeConstraints:^(MASConstraintMaker *make) {
					make.edges.mas_equalTo(UIEdgeInsetsZero);
				}];
			}
			[model ht_setRowHeightNumber:@(rowHeight) forCellClass:cell.class];
		}];
	}];
	[self.tableView ht_whenTap:^(UIView *view) {
		[weakSelf.textFieldGroup resignFirstResponder];
	}];
	__block NSString *forgetType = @"1";
	[self.sureButton ht_whenTap:^(UIView *view) {
		if (!([HTValidateManager ht_validateMobile:weakSelf.textFieldGroup.phoneEmailTextField.text] || [HTValidateManager ht_validateEmail:weakSelf.textFieldGroup.phoneEmailTextField.text])) {
			[HTAlert title:@"手机号或邮箱格式不大对哦"];
		} else if (!weakSelf.textFieldGroup.messageCodeTextField.text.length) {
			[HTAlert title:@"你还没有填写验证码"];
		} else if (![HTValidateManager ht_validatePassword:weakSelf.textFieldGroup.passwordTextField.text]) {
			[HTAlert title:@"密码格式不大对哦" message:@"6-20个字符, 支持数字和大小写字母"];
		} else {
			if ([HTValidateManager ht_validateMobile:weakSelf.textFieldGroup.phoneEmailTextField.text]) {
				forgetType = @"1";
			} else if ([HTValidateManager ht_validateEmail:weakSelf.textFieldGroup.phoneEmailTextField.text]) {
				forgetType = @"2";
			}
			HTNetworkModel *networkModel = [[HTNetworkModel alloc] init];
			networkModel.autoAlertString = @"重置密码中";
			networkModel.offlineCacheStyle = HTCacheStyleNone;
			networkModel.autoShowError = true;
			[HTRequestManager requestResetPasswordWithNetworkModel:networkModel phoneOrEmailString:weakSelf.textFieldGroup.phoneEmailTextField.text resetPassword:weakSelf.textFieldGroup.passwordTextField.text messageCode:weakSelf.textFieldGroup.messageCodeTextField.text complete:^(id response, HTError *errorModel) {
				if (errorModel.existError) {
					return;
				}
				[HTAlert title:@"重置密码成功"];
				[HTLoginManager loginUsername:weakSelf.textFieldGroup.phoneEmailTextField.text password:weakSelf.textFieldGroup.passwordTextField.text alert:false complete:^(BOOL success, NSString *alertString) {
					if (success) {
						if (weakSelf.tapLoginSuccess) {
							weakSelf.tapLoginSuccess();
						}
						[weakSelf dismissViewControllerAnimated:true completion:nil];
					} else {
						[weakSelf.navigationController popViewControllerAnimated:true];
					}
				}];
			}];
		}
	}];
}

- (UIButton *)sureButton {
	if (!_sureButton) {
		_sureButton = [[UIButton alloc] init];
		_sureButton.layer.masksToBounds = true;
		[_sureButton setTitle:@"确定" forState:UIControlStateNormal];
		[_sureButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
		_sureButton.titleLabel.font = [UIFont systemFontOfSize:17];
		UIColor *normalColor = [UIColor ht_colorStyle:HTColorStyleTintColor];
		UIColor *higlightColor = [normalColor colorWithAlphaComponent:0.4];
		[_sureButton setBackgroundImage:[UIImage ht_pureColor:normalColor] forState:UIControlStateNormal];
		[_sureButton setBackgroundImage:[UIImage ht_pureColor:higlightColor] forState:UIControlStateHighlighted];
	}
	return _sureButton;
}

- (UITableView *)tableView {
	if (!_tableView) {
		_tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
		_tableView.backgroundColor = [UIColor whiteColor];
		_tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
		_tableView.allowsSelection = false;
	}
	return _tableView;
}

- (HTLoginTextFieldGroupView *)textFieldGroup {
	if (!_textFieldGroup) {
		_textFieldGroup = [[HTLoginTextFieldGroupView alloc] init];
		_textFieldGroup.textFieldGroupType = HTLoginTextFieldGroupTypeForgetPassword;
	}
	return _textFieldGroup;
}

@end
