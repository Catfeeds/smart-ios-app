//
//  HTLoginController.m
//  School
//
//  Created by hublot on 2017/6/15.
//  Copyright © 2017年 hublot. All rights reserved.
//

#import "HTLoginController.h"
#import "HTLoginCenterView.h"
#import <HTValidateManager.h>
#import "HTForgetPasswordController.h"
#import "HTRegisterController.h"
#import "HTLoginManager.h"

@interface HTLoginController ()

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) HTLoginCenterView *centerLoginView;

@end

@implementation HTLoginController

- (void)viewDidLoad {
	[super viewDidLoad];
	[self initializeDataSource];
	[self initializeUserInterface];
}

- (void)viewDidAppear:(BOOL)animated {
	[super viewDidAppear:animated];
	self.centerLoginView.usernameTextField.text = [HTLoginManager userDefaultsUserName];
	self.centerLoginView.passwordTextField.text = [HTLoginManager userDefaultsPassword];
	[self validateInputGuard];
}

- (void)initializeDataSource {
	
}

- (void)initializeUserInterface {
	UIImage *image = [[UIImage alloc] init];
	[self.navigationController.navigationBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
	[self.navigationController.navigationBar setShadowImage:image];
	
	[self.view addSubview:self.tableView];
	
	UIImage *backgroundImage = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForAuxiliaryExecutable:@"cn2_login_background.png"]];
	UIImageView *backgrundImageView = [[UIImageView alloc] initWithImage:backgroundImage];
	
	UIImageView *darkAlphaImageView = [[UIImageView alloc] initWithFrame:backgrundImageView.bounds];
	darkAlphaImageView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.6];
	[backgrundImageView addSubview:darkAlphaImageView];
	
	self.tableView.backgroundView = backgrundImageView;
	
	__weak typeof(self) weakSelf = self;
	
	[self.tableView addSubview:self.centerLoginView];

	[self.tableView ht_whenTap:^(UIView *view) {
		[weakSelf.centerLoginView.usernameTextField resignFirstResponder];
		[weakSelf.centerLoginView.passwordTextField resignFirstResponder];
	}];
	[self.centerLoginView.loginButton ht_whenTap:^(UIView *view) {
		if (!([HTValidateManager ht_validateEmail:weakSelf.centerLoginView.usernameTextField.text] || [HTValidateManager ht_validateMobile:weakSelf.centerLoginView.usernameTextField.text] || [HTValidateManager ht_validateUserName:weakSelf.centerLoginView.usernameTextField.text])) {
			[HTAlert title:@"手机号/邮箱格式不对" message:@""];
		} else if (![HTValidateManager ht_validatePassword:weakSelf.centerLoginView.passwordTextField.text]) {
			[HTAlert title:@"请输入正确的密码格式" message:@"6-20个字符, 支持数字和大小写字母"];
		} else {
			[HTLoginManager loginUsername:weakSelf.centerLoginView.usernameTextField.text password:weakSelf.centerLoginView.passwordTextField.text alert:true complete:^(BOOL success, NSString *alertString) {
				if (success) {
					[weakSelf dismissViewControllerAnimated:true completion:nil];
				}
			}];
		}
	}];
	[self.centerLoginView.registerButton ht_whenTap:^(UIView *view) {
		HTRegisterController *registerController = [[HTRegisterController alloc] init];
		[weakSelf.navigationController pushViewController:registerController animated:true];
	}];
	[self.centerLoginView.forgetPasswordButton ht_whenTap:^(UIView *view) {
		HTForgetPasswordController *forgetPasswordController = [[HTForgetPasswordController alloc] init];
		[weakSelf.navigationController pushViewController:forgetPasswordController animated:true];
	}];
}

- (void)validateInputGuard {
	self.centerLoginView.loginButton.selected = !(([HTValidateManager ht_validateMobile:self.centerLoginView.usernameTextField.text] || [HTValidateManager ht_validateEmail:self.centerLoginView.usernameTextField.text] || [HTValidateManager ht_validateUserName:self.centerLoginView.usernameTextField.text]) && [HTValidateManager ht_validatePassword:self.centerLoginView.passwordTextField.text]);
}

- (UITableView *)tableView {
	if (!_tableView) {
		_tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
		_tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
		_tableView.allowsSelection = false;
	}
	return _tableView;
}

- (HTLoginCenterView *)centerLoginView {
	if (!_centerLoginView) {
		_centerLoginView = [[HTLoginCenterView alloc] initWithFrame:CGRectMake(40, HTADAPT568(100) - 64, self.view.ht_w - 80, 350)];
		_centerLoginView.usernameTextField.text = [HTLoginManager userDefaultsUserName];
		_centerLoginView.passwordTextField.text = [HTLoginManager userDefaultsPassword];
	}
	return _centerLoginView;
}

@end
