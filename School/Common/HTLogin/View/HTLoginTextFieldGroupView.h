//
//  HTLoginTextFieldGroupView.h
//  School
//
//  Created by hublot on 2017/6/14.
//  Copyright © 2017年 hublot. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, HTLoginTextFieldGroupType) {
	HTLoginTextFieldGroupTypeRegister,
	HTLoginTextFieldGroupTypeForgetPassword,
	HTLoginTextFieldGroupTypeChangeUser
};

@interface HTLoginTextFieldGroupView : NSObject

@property (nonatomic, assign) HTLoginTextFieldGroupType textFieldGroupType;

@property (nonatomic, strong) UITextField *phoneEmailTextField;

@property (nonatomic, strong) UITextField *messageCodeTextField;

@property (nonatomic, strong) UITextField *usernameTextField;

@property (nonatomic, strong) UITextField *passwordTextField;

@property (nonatomic, strong) UITextField *surePasswordTextField;

@property (nonatomic, strong) UIButton *messageCodeButton;

+ (UITextField *)normalTextField;

- (void)resignFirstResponder;

@end
