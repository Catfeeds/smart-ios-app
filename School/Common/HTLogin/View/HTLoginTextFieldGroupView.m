//
//  HTLoginTextFieldGroupView.m
//  School
//
//  Created by hublot on 2017/6/14.
//  Copyright © 2017年 hublot. All rights reserved.
//

#import "HTLoginTextFieldGroupView.h"
#import <HTValidateManager.h>

@interface HTLoginTextFieldGroupView ()

@property (nonatomic, strong) NSTimer *timer;

@end

@implementation HTLoginTextFieldGroupView

- (void)resignFirstResponder {
	[self.phoneEmailTextField resignFirstResponder];
	[self.usernameTextField resignFirstResponder];
	[self.messageCodeTextField resignFirstResponder];
	[self.passwordTextField resignFirstResponder];
	[self.surePasswordTextField resignFirstResponder];
}

- (void)dealloc {
	[self.timer invalidate];
}

- (UITextField *)phoneEmailTextField {
	if (!_phoneEmailTextField) {
		_phoneEmailTextField = [HTLoginTextFieldGroupView normalTextField];
		_phoneEmailTextField.placeholder = @" 请输入手机号/邮箱";
	}
	return _phoneEmailTextField;
}

- (UITextField *)messageCodeTextField {
	if (!_messageCodeTextField) {
		_messageCodeTextField = [HTLoginTextFieldGroupView normalTextField];
		_messageCodeTextField.placeholder = @" 请输入验证码";
	}
	return _messageCodeTextField;
}

- (UITextField *)usernameTextField {
	if (!_usernameTextField) {
		_usernameTextField = [HTLoginTextFieldGroupView normalTextField];
		_usernameTextField.placeholder = @" 请输入手机号/邮箱";
	}
	return _usernameTextField;
}

- (UITextField *)passwordTextField {
	if (!_passwordTextField) {
		_passwordTextField = [HTLoginTextFieldGroupView normalTextField];
		_passwordTextField.placeholder = @" 请输入密码(支持数字和大小写字母)";
		_passwordTextField.secureTextEntry = true;
	}
	return _passwordTextField;
}

- (UITextField *)surePasswordTextField {
	if (!_surePasswordTextField) {
		_surePasswordTextField = [HTLoginTextFieldGroupView normalTextField];
		_surePasswordTextField.placeholder = @" 请确认你的密码";
		_surePasswordTextField.secureTextEntry = true;
	}
	return _surePasswordTextField;
}

- (UIButton *)messageCodeButton {
	if (!_messageCodeButton) {
		_messageCodeButton = [UIButton buttonWithType:UIButtonTypeCustom];
		_messageCodeButton.frame = CGRectMake(0, 0, 100, 40);
		[_messageCodeButton setBackgroundImage:[UIImage ht_pureColor:[UIColor ht_colorString:@"f1c100"]] forState:UIControlStateNormal];
		[_messageCodeButton setBackgroundImage:[UIImage ht_pureColor:[UIColor ht_colorStyle:HTColorStylePrimarySeparate]] forState:UIControlStateDisabled];
		_messageCodeButton.layer.cornerRadius = 3;
		_messageCodeButton.layer.masksToBounds = true;
		[_messageCodeButton setTitle:@"验证码" forState:UIControlStateNormal];
		_messageCodeButton.titleLabel.font = [UIFont systemFontOfSize:15];
		
		HTNetworkModel *networkModel = [HTNetworkModel modelForOnlyCacheNoInterfaceForScrollViewWithCacheStyle:HTCacheStyleNone];
		[HTRequestManager requestMessageCodeSurePersonWithNetworkModel:networkModel complete:^(id response, HTError *errorModel) {
			
		}];
		
		__weak HTLoginTextFieldGroupView *weakSelf = self;
		[_messageCodeButton ht_whenTap:^(UIView *view) {
			if ([HTValidateManager ht_validateMobile:weakSelf.phoneEmailTextField.text]) {
			} else if ([HTValidateManager ht_validateEmail:weakSelf.phoneEmailTextField.text]) {
			} else {
				[HTAlert title:@"手机号或邮箱格式不大对哦"];
				return;
			}
			HTNetworkModel *networkModel = [[HTNetworkModel alloc] init];
			networkModel.autoAlertString = @"获取验证码中";
			networkModel.offlineCacheStyle = HTCacheStyleNone;
			networkModel.autoShowError = true;
			[HTRequestManager requestRegisterOrForgetPasswordOrUpdataUserMessageCodeWithNetworkModel:networkModel phoneOrEmailString:weakSelf.phoneEmailTextField.text requestMessageCodeStyle:weakSelf.textFieldGroupType complete:^(id response, HTError *errorModel) {
				if (errorModel.existError) {
					return;
				}
				[HTAlert title:@"验证码已发送"];
				weakSelf.messageCodeButton.enabled = false;
				[weakSelf.messageCodeTextField becomeFirstResponder];
				[weakSelf.messageCodeButton setTitle:@"59" forState:UIControlStateNormal];
				[weakSelf.timer invalidate];
				weakSelf.timer = [NSTimer bk_timerWithTimeInterval:1 block:^(NSTimer *timer) {
					NSInteger currentTime = [[weakSelf.messageCodeButton titleForState:UIControlStateNormal] integerValue];
					[weakSelf.messageCodeButton setTitle:[NSString stringWithFormat:@"%ld", currentTime - 1]  forState:UIControlStateNormal];
					if ([[weakSelf.messageCodeButton titleForState:UIControlStateNormal] isEqualToString:@"0"]) {
						weakSelf.messageCodeButton.enabled = true;
						[weakSelf.messageCodeButton setTitle:@"验证码" forState:UIControlStateNormal];
						[weakSelf.timer invalidate];
					}
				} repeats:true];
				[[NSRunLoop currentRunLoop] addTimer:weakSelf.timer forMode:NSRunLoopCommonModes];
			}];
		}];
	}
	return _messageCodeButton;
}

+ (UITextField *)normalTextField {
	UITextField *textField = [[UITextField alloc] init];
	textField.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 20, 0)];
	textField.leftViewMode = UITextFieldViewModeAlways;
	textField.backgroundColor = [UIColor ht_colorString:@"f1f1f1"];
	textField.textColor = [UIColor ht_colorStyle:HTColorStylePrimaryTitle];
	textField.font = [UIFont systemFontOfSize:13];
	textField.layer.cornerRadius = 5;
	textField.layer.masksToBounds = true;
	textField.layer.borderWidth = 1;
	textField.layer.borderColor = [UIColor ht_colorStyle:HTColorStylePrimarySeparate].CGColor;
	
	__weak UITextField *weakTextField = textField;
	[textField bk_addObserverForKeyPath:@"placeholder" options:NSKeyValueObservingOptionInitial task:^(id obj, NSDictionary *change) {
		if (weakTextField.placeholder) {
			weakTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:weakTextField.placeholder attributes:@{NSForegroundColorAttributeName:[UIColor colorWithWhite:0 alpha:0.3], NSFontAttributeName:weakTextField.font}];
		}
	}];
	return textField;
}

@end
