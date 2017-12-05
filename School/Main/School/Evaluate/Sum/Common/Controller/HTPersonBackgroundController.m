//
//  HTPersonBackgroundController.m
//  School
//
//  Created by Charles Cao on 2017/11/27.
//  Copyright © 2017年 hublot. All rights reserved.
//

#import "HTPersonBackgroundController.h"
#import "HTSchoolMatriculatePickerView.h"

NSString *workExperienceHint = @"请如实填写跟申请方向相关的工作经验, 若没有完整工作经验, 请填写相关实习经验, 描述不少于30字, 可不填";
NSString *projectExperienceHint = @"请如实填写跟申请方向相关的项目经验, 如比赛经历, 商业项目, 试验项目, 论文发表等, 描述不少于30字, 可不填";
NSString *overseasHint = @"请如实填写海外留学经历, 如交换项目, 海外实践课程等, 可不填";
NSString *benefitActivityHint = @"请如实填写所参与公益项目, 可不填";
NSString *awardExperienceHint = @"请如实填写获奖经历, 可不填";

@interface HTPersonBackgroundController () <UITextViewDelegate, UITextFieldDelegate>
{
	NSArray *workUnitArray;
}


@end

@implementation HTPersonBackgroundController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
	self.contentHeight = 732.0f;
	workUnitArray = @[@"国内四大",@"500强",@"外企", @"国企", @"私企"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)previousAction:(id)sender {
	[self.delegate previous:self];
}
- (IBAction)nextAction:(id)sender {
	
	if (![self.workExperienceTextView.text isEqualToString:workExperienceHint]) {
		self.parameter.work = self.workExperienceTextView.text;
	}
	if (![self.projectExperienceTextView.text isEqualToString:projectExperienceHint]) {
		self.parameter.project = self.projectExperienceTextView.text;
	}
	if (![self.overseasTextView.text isEqualToString:overseasHint]) {
		self.parameter.studyTour = self.overseasTextView.text;
	}
	if (![self.benefitActivityTextView.text isEqualToString:benefitActivityHint]) {
		self.parameter.active = self.benefitActivityTextView.text;
	}
	if (![self.awardExperienceTextView.text isEqualToString:awardExperienceHint]) {
		self.parameter.price = self.awardExperienceTextView.text;
	}
	
	[self.delegate next:self];
}

#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
	
	[HTSchoolMatriculatePickerView showModelArray:@[workUnitArray] selectedRowArray:@[@(0)] didSelectedBlock:^(NSArray<NSArray *> *totalModelArray, NSArray *selectedModelArray, NSArray<NSNumber *> *selectedRowArray) {
		textField.text = selectedModelArray.firstObject;
		
		 if ([textField.text isEqualToString:@"国内四大"]) self.parameter.work = @"1";
	else if ([textField.text isEqualToString:@"500强"])   self.parameter.work = @"2";
	else if ([textField.text isEqualToString:@"外企"])  	  self.parameter.work = @"3";
	else if ([textField.text isEqualToString:@"国企"]) 	  self.parameter.work = @"4";
	else if ([textField.text isEqualToString:@"私企"]) 	  self.parameter.work = @"5";
		
	}];
	
	return NO;
}

#pragma mark - UITextViewDelegate

- (void)textViewDidBeginEditing:(UITextView *)textView{
	NSString *text = textView.text;
	BOOL flag = (textView == self.workExperienceTextView    && [text isEqualToString:workExperienceHint])   ||
				(textView == self.projectExperienceTextView && [text isEqualToString:projectExperienceHint])||
				(textView == self.overseasTextView 			&& [text isEqualToString:overseasHint])         ||
				(textView == self.benefitActivityTextView   && [text isEqualToString:benefitActivityHint])  ||
				(textView == self.awardExperienceTextView   && [text isEqualToString:awardExperienceHint]);
	if (flag) textView.text = @"";
	
}

- (void)textViewDidEndEditing:(UITextView *)textView{
	BOOL flag = StringNotEmpty(textView.text);
	if (!flag) {
		
		if (textView == self.workExperienceTextView)    textView.text = workExperienceHint;
		if (textView == self.projectExperienceTextView) textView.text = projectExperienceHint;
		if (textView == self.overseasTextView) 			textView.text = overseasHint;
		if (textView == self.benefitActivityTextView)   textView.text = benefitActivityHint;
		if (textView == self.awardExperienceTextView)   textView.text = awardExperienceHint;
			
	}
	
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
