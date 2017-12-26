//
//  HTSignUpOpenCourseView.m
//  School
//
//  Created by Charles Cao on 2017/12/26.
//  Copyright © 2017年 hublot. All rights reserved.
//

#import "HTSignUpOpenCourseView.h"
#import "HTValidateManager.h"

@implementation HTSignUpOpenCourseView 

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (IBAction)submitAction:(id)sender {
	
	NSString *name = self.nameTextField.text;
	NSString *phone = self.phoneTextField.text;
	
	if (!StringNotEmpty(name)) {
		[HTAlert title:@"请填写姓名"];
		return;
	}
	
	if (![HTValidateManager ht_validateMobile:phone]) {
		[HTAlert title:@"请填正确电话号码"];
		return;
	}
	
	[self.delegate submit:name phone:phone];
}

- (IBAction)closeAction:(id)sender {
	[self removeFromSuperview];
}

#pragma mark - UITextFieldDelegate

- (void)textFieldDidEndEditing:(UITextField *)textField{
	[self.window setNeedsLayout];
	[self.window layoutIfNeeded];
}

@end
