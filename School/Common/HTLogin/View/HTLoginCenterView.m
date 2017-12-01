//
//  HTLoginCenterView.m
//  School
//
//  Created by hublot on 2017/6/15.
//  Copyright © 2017年 hublot. All rights reserved.
//

#import "HTLoginCenterView.h"

@interface HTLoginCenterView ()

@end

@implementation HTLoginCenterView

- (void)didMoveToSuperview {
	[self addSubview:self.titleNameButton];
	[self addSubview:self.usernameTextField];
	[self addSubview:self.passwordTextField];
	[self addSubview:self.loginButton];
	[self addSubview:self.registerButton];
	[self addSubview:self.forgetPasswordButton];
	
	[self.titleNameButton mas_makeConstraints:^(MASConstraintMaker *make) {
		make.left.right.top.mas_equalTo(self);
		make.height.mas_equalTo(150);
	}];
	[self.usernameTextField mas_makeConstraints:^(MASConstraintMaker *make) {
		make.top.mas_equalTo(self.titleNameButton.mas_bottom);
		make.left.right.mas_equalTo(self);
		make.height.mas_equalTo(30);
	}];
	[self.passwordTextField mas_makeConstraints:^(MASConstraintMaker *make) {
		make.top.mas_equalTo(self.usernameTextField.mas_bottom).offset(20);
		make.left.right.mas_equalTo(self);
		make.height.mas_equalTo(30);
	}];
	[self.loginButton mas_makeConstraints:^(MASConstraintMaker *make) {
		make.top.mas_equalTo(self.passwordTextField.mas_bottom).offset(30);
		make.left.right.mas_equalTo(self);
		make.height.mas_equalTo(40);
	}];
	[self.registerButton mas_makeConstraints:^(MASConstraintMaker *make) {
		make.left.mas_equalTo(self);
		make.top.mas_equalTo(self.loginButton.mas_bottom).offset(10);
	}];
	[self.forgetPasswordButton mas_makeConstraints:^(MASConstraintMaker *make) {
		make.right.mas_equalTo(self);
		make.centerY.mas_equalTo(self.registerButton);
	}];
}

- (void)layoutSubviews {
	[super layoutSubviews];
	self.loginButton.layer.cornerRadius = self.loginButton.bounds.size.height / 2;
}

- (UIButton *)titleNameButton {
	if (!_titleNameButton) {
		_titleNameButton = [[UIButton alloc] init];
		[_titleNameButton setTitle:@"雷哥网账号登录" forState:UIControlStateNormal];
		[_titleNameButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
		_titleNameButton.titleLabel.font = [UIFont systemFontOfSize:17];
		_titleNameButton.userInteractionEnabled = false;
	}
	return _titleNameButton;
}

- (HTLoginTextField *)usernameTextField {
	if (!_usernameTextField) {
		_usernameTextField = [[HTLoginTextField alloc] init];
		_usernameTextField.placeholder = @" 手机号/邮箱  ";
		UIImage *image = [UIImage imageNamed:@"cn2_login_icon_username"];
		image = [image ht_resetSizeZoomNumber:0.4];
		image = [image ht_insertColor:[UIColor clearColor] edge:UIEdgeInsetsMake(0, 10, 5, 10)];
		image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
		UIImageView *leftImageView = [[UIImageView alloc] initWithImage:image];
		leftImageView.tintColor = [UIColor whiteColor];
		_usernameTextField.leftView = leftImageView;
	}
	return _usernameTextField;
}


- (HTLoginTextField *)passwordTextField {
	if (!_passwordTextField) {
		_passwordTextField = [[HTLoginTextField alloc] init];
		_passwordTextField.placeholder = @" 密码  ";
		UIImage *image = [UIImage imageNamed:@"cn2_login_icon_password"];
		image = [image ht_resetSizeZoomNumber:0.5];
		image = [image ht_insertColor:[UIColor clearColor] edge:UIEdgeInsetsMake(0, 10, 5, 10)];
		image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
		UIImageView *leftImageView = [[UIImageView alloc] initWithImage:image];
		leftImageView.tintColor = [UIColor whiteColor];
		_passwordTextField.leftView = leftImageView;
		_passwordTextField.secureTextEntry = true;
	}
	return _passwordTextField;
}

- (UIButton *)loginButton {
	if (!_loginButton) {
		_loginButton = [[UIButton alloc] init];
		_loginButton.layer.masksToBounds = true;
		[_loginButton setTitle:@"登录" forState:UIControlStateNormal];
		[_loginButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
		_loginButton.titleLabel.font = [UIFont systemFontOfSize:17];
		UIColor *normalColor = [UIColor ht_colorStyle:HTColorStyleTintColor];
		UIColor *higlightColor = [normalColor colorWithAlphaComponent:0.4];
		[_loginButton setBackgroundImage:[UIImage ht_pureColor:normalColor] forState:UIControlStateNormal];
		[_loginButton setBackgroundImage:[UIImage ht_pureColor:higlightColor] forState:UIControlStateHighlighted];
	}
	return _loginButton;
}

- (UIButton *)registerButton {
	if (!_registerButton) {
		_registerButton = [[UIButton alloc] init];
		[_registerButton setTitle:@"注册账号>" forState:UIControlStateNormal];
		_registerButton.titleLabel.font = [UIFont systemFontOfSize:12];
		[_registerButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
		_registerButton.titleLabel.textAlignment = NSTextAlignmentLeft;
		_registerButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
	}
	return _registerButton;
}

- (UIButton *)forgetPasswordButton {
	if (!_forgetPasswordButton) {
		_forgetPasswordButton = [[UIButton alloc] init];
		[_forgetPasswordButton setTitle:@"忘记密码?" forState:UIControlStateNormal];
		_forgetPasswordButton.titleLabel.font = [UIFont systemFontOfSize:12];
		[_forgetPasswordButton setTitleColor:[UIColor ht_colorStyle:HTColorStyleTintColor] forState:UIControlStateNormal];
		_forgetPasswordButton.titleLabel.textAlignment = NSTextAlignmentRight;
		_forgetPasswordButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
	}
	return _forgetPasswordButton;
}

@end
