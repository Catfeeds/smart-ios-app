//
//  HTApplyBackgroundController.m
//  School
//
//  Created by Charles Cao on 2017/11/27.
//  Copyright © 2017年 hublot. All rights reserved.
//

#import "HTApplyBackgroundController.h"

@interface HTApplyBackgroundController ()<UITextFieldDelegate>

@end

@implementation HTApplyBackgroundController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
	
	self.destinationField.layer.borderColor = [UIColor ht_colorString:@"e6e6e6"].CGColor;
	self.applyMajorField.layer.borderColor = [UIColor ht_colorString:@"e6e6e6"].CGColor;
	
	self.contentHeight = 310.0f;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)previousAction:(id)sender {
	[self.delegate previous:self];
}

- (IBAction)submitAction:(id)sender {
	[self.delegate submit];
}

#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
	
	if (textField == self.destinationField) {
		
	}else {
		
	}
	
	return NO;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
