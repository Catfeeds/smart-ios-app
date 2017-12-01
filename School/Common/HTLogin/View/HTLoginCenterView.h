//
//  HTLoginCenterView.h
//  School
//
//  Created by hublot on 2017/6/15.
//  Copyright © 2017年 hublot. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HTLoginTextField.h"

@interface HTLoginCenterView : UIView

@property (nonatomic, strong) UIButton *titleNameButton;

@property (nonatomic, strong) HTLoginTextField *usernameTextField;

@property (nonatomic, strong) HTLoginTextField *passwordTextField;

@property (nonatomic, strong) UIButton *loginButton;

@property (nonatomic, strong) UIButton *registerButton;

@property (nonatomic, strong) UIButton *forgetPasswordButton;

@end
