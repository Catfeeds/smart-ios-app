//
//  HTRegisterController.m
//  School
//
//  Created by hublot on 2017/6/15.
//  Copyright © 2017年 hublot. All rights reserved.
//

#import "HTRegisterController.h"
#import "HTLoginTextFieldGroupView.h"
#import <UITableView+HTSeparate.h>
#import "HTLoginTextFieldCell.h"
#import <HTValidateManager.h>
#import <NSObject+HTTableRowHeight.h>
#import "HTLoginManager.h"
#import "HTUserProtocolViewController.h"

@interface HTRegisterController ()

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) HTLoginTextFieldGroupView *textFieldGroup;

@property (nonatomic, strong) UIButton *registerButton;

@property (nonatomic, strong) UIView *agreementView;

@property (nonatomic, strong) UILabel *loginLabel;
@property (nonatomic, strong) UIButton *agreeButton;

@end

@implementation HTRegisterController

- (void)viewDidLoad {
	[super viewDidLoad];
	[self initializeDataSource];
	[self initializeUserInterface];
}

- (void)viewDidLayoutSubviews {
	[super viewDidLayoutSubviews];
	self.registerButton.layer.cornerRadius = self.registerButton.bounds.size.height / 2;
}



- (void)initializeDataSource {
	[HTRequestManager requestMessageCodeSurePersonWithNetworkModel:nil complete:^(id response, HTError *errorModel) {
		
	}];
}

- (void)initializeUserInterface {
	self.navigationItem.title = @"注册";
	[self.view addSubview:self.tableView];
	
	__weak HTRegisterController *weakSelf = self;
	NSArray *textFieldArray = @[self.textFieldGroup.phoneEmailTextField, self.textFieldGroup.messageCodeTextField, self.textFieldGroup.passwordTextField, self.textFieldGroup.surePasswordTextField, self.registerButton, self.loginLabel,self.agreementView];
	
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
			} else if (row == 4) {
				rowHeight = 80;
				[model mas_updateConstraints:^(MASConstraintMaker *make) {
					make.height.mas_equalTo(40);
					make.centerY.left.right.mas_equalTo(cell);
				}];
			} else if (row == 5) {
				rowHeight = 30;
				[model mas_makeConstraints:^(MASConstraintMaker *make) {
					make.edges.mas_equalTo(UIEdgeInsetsZero);
				}];
			}else if (row == 6){
				rowHeight = 30;
				[model mas_updateConstraints:^(MASConstraintMaker *make) {
					make.centerX.mas_equalTo(cell);
					make.top.bottom.mas_equalTo(0);
					make.width.mas_equalTo(180);
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
	[self.loginLabel ht_whenTap:^(UIView *view) {
		[weakSelf.navigationController popViewControllerAnimated:true];
	}];
	[self.registerButton ht_whenTap:^(UIView *view) {
		if (!self.agreeButton.selected) {
			[HTAlert title:@"请阅读并同意《用户协议》"];
			return ;
		}
		if (!([HTValidateManager ht_validateMobile:weakSelf.textFieldGroup.phoneEmailTextField.text] || [HTValidateManager ht_validateEmail:weakSelf.textFieldGroup.phoneEmailTextField.text])) {
			[HTAlert title:@"手机号或邮箱格式不大对哦"];
		} else if (!weakSelf.textFieldGroup.messageCodeTextField.text.length) {
			[HTAlert title:@"你还没有填写验证码"];
//		} else if (![HTValidateManager ht_validateUserName:weakSelf.textFieldGroup.usernameTextField.text]) {
//			[HTAlert title:@"用户名格式不对哦" message:@"6-20个字符, 必须包含英文字母和数字"];
		} else if (![HTValidateManager ht_validatePassword:weakSelf.textFieldGroup.passwordTextField.text]) {
			[HTAlert title:@"密码格式不大对哦" message:@"6-20个字符, 支持数字和大小写字母"];
		} else if (![weakSelf.textFieldGroup.passwordTextField.text isEqualToString:weakSelf.textFieldGroup.surePasswordTextField.text]) {
			[HTAlert title:@"两次密码不一致哦"];
		} else {
			HTNetworkModel *networkModel = [[HTNetworkModel alloc] init];
			networkModel.autoAlertString = @"注册用户中";
			networkModel.offlineCacheStyle = HTCacheStyleNone;
			networkModel.autoShowError = true;
			[HTRequestManager requestRegisterWithNetworkModel:networkModel phoneOrEmailString:weakSelf.textFieldGroup.phoneEmailTextField.text registerPassword:weakSelf.textFieldGroup.passwordTextField.text messageCode:weakSelf.textFieldGroup.messageCodeTextField.text usernameString:weakSelf.textFieldGroup.usernameTextField.text complete:^(id response, HTError *errorModel) {
				if (errorModel.existError) {
					return;
				}
				[HTAlert title:@"注册成功"];
				[HTLoginManager loginUsername:weakSelf.textFieldGroup.phoneEmailTextField.text password:weakSelf.textFieldGroup.passwordTextField.text alert:true complete:^(BOOL success, NSString *alertString) {
					if (success) {
						if (weakSelf.tapLoginSuccess) {
							weakSelf.tapLoginSuccess();
						}
						[weakSelf.navigationController dismissViewControllerAnimated:true completion:nil];
					} else {
						[weakSelf.navigationController popViewControllerAnimated:true];
					}
				}];
			}];
		}
	}];
}

- (UIButton *)registerButton {
	if (!_registerButton) {
		_registerButton = [[UIButton alloc] init];
		_registerButton.layer.masksToBounds = true;
		[_registerButton setTitle:@"注册" forState:UIControlStateNormal];
		[_registerButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
		_registerButton.titleLabel.font = [UIFont systemFontOfSize:17];
		UIColor *normalColor = [UIColor ht_colorStyle:HTColorStyleTintColor];
		UIColor *higlightColor = [normalColor colorWithAlphaComponent:0.4];
		[_registerButton setBackgroundImage:[UIImage ht_pureColor:normalColor] forState:UIControlStateNormal];
		[_registerButton setBackgroundImage:[UIImage ht_pureColor:higlightColor] forState:UIControlStateHighlighted];
	}
	return _registerButton;
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
		_textFieldGroup.textFieldGroupType = HTLoginTextFieldGroupTypeRegister;
	}
	return _textFieldGroup;
}

- (UIView *)agreementView{
	if (!_agreementView) {
		_agreementView = [[UIView alloc]init];
		self.agreeButton = [[UIButton alloc]init];
		[self.agreeButton setImage:[UIImage imageNamed:@"dx-2"] forState:UIControlStateSelected];
		[self.agreeButton setImage:[UIImage imageNamed:@"dx"] forState:UIControlStateNormal];
		self.agreeButton.selected = YES;
		[self.agreeButton addTarget:self action:@selector(agreeAction:) forControlEvents:UIControlEventTouchUpInside];
		UILabel *label = [[UILabel alloc]init];
		label.text = @"已阅读并同意《用户协议》";
		label.font = [UIFont systemFontOfSize:13];
		label.textColor = [UIColor ht_colorStyle:HTColorStylePrimaryTitle];
		[label ht_whenTap:^(UIView *view) {
			HTUserProtocolViewController *viewController = STORYBOARD_VIEWCONTROLLER(@"Login", @"HTUserProtocolViewController");
			[self.navigationController pushViewController:viewController animated:YES];
		}];
		
		[_agreementView addSubview:self.agreeButton];
		[_agreementView addSubview:label];
		
		[self.agreeButton mas_updateConstraints:^(MASConstraintMaker *make) {
			make.left.mas_equalTo(_agreementView);
			make.centerY.mas_equalTo(_agreementView);
			make.height.width.mas_equalTo(20);
		}];
		[label mas_updateConstraints:^(MASConstraintMaker *make) {
			make.centerY.mas_equalTo(_agreementView);
			make.left.mas_equalTo(self.agreeButton.mas_right).offset(10);
		}];
		
	}
	return _agreementView;
}

- (UILabel *)loginLabel {
	if (!_loginLabel) {
		_loginLabel = [[UILabel alloc] init];
		_loginLabel.textAlignment = NSTextAlignmentCenter;
		NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:@"*已经注册雷哥网在线账号? 登录" attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13], NSForegroundColorAttributeName:[UIColor ht_colorStyle:HTColorStylePrimaryTitle]}];
		[attributedString addAttributes:@{NSForegroundColorAttributeName:[UIColor ht_colorStyle:HTColorStyleTintColor]} range:NSMakeRange(attributedString.length - 2, 2)];
		_loginLabel.attributedText = attributedString;
	}
	return _loginLabel;
}

- (void)agreeAction:(UIButton *)btn{
	btn.selected = !btn.selected;
}

@end
