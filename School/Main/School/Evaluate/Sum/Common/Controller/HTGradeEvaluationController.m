//
//  HTGradeEvaluationController.m
//  School
//
//  Created by Charles Cao on 2017/11/27.
//  Copyright © 2017年 hublot. All rights reserved.
//

#import "HTGradeEvaluationController.h"

@interface HTGradeEvaluationController ()

@end

@implementation HTGradeEvaluationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
	self.contentHeight = 340.0f;
	self.GPALabel.layer.borderColor = [UIColor ht_colorString:@"e6e6e6"].CGColor;
	self.GMATLabel.layer.borderColor = [UIColor ht_colorString:@"e6e6e6"].CGColor;
	self.TOFELLabel.layer.borderColor = [UIColor ht_colorString:@"e6e6e6"].CGColor;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)nextAction:(id)sender {
	
	CGFloat gpa = self.GPALabel.text.floatValue;
	CGFloat gmat_gre = self.GMATLabel.text.floatValue;
	CGFloat toefl_ielts = self.TOFELLabel.text.floatValue;
	
	NSString *errorString = @"";
	if (gpa >= 2.5 && gpa <=4.0) {
		self.parameter.result_gpa = @(gpa).stringValue;
	}else{
		errorString = @"gpa 成绩在 2.5 至 4.0 之间";
	}
	
	if (gmat_gre >= 200 && gmat_gre <= 340) {
		self.parameter.gre = @(gmat_gre).stringValue;
		self.parameter.result_gmat = @"";
	}else if (gmat_gre >= 400 && gmat_gre <= 780){
		self.parameter.result_gmat = @(gmat_gre).stringValue;
		self.parameter.gre = @"";
	}else {
		errorString = @"gmat 成绩在 400 至 700 之间, gre 成绩在 200 至 340 之间";
	}
	
	if (toefl_ielts >= 60 && toefl_ielts <= 120) {
		self.parameter.result_toefl = @(toefl_ielts).stringValue;
		self.parameter.ielts = @"";
	}else if (toefl_ielts >= 5.0 && toefl_ielts <= 9.0){
		self.parameter.ielts = @(toefl_ielts).stringValue;
		self.parameter.result_toefl = @"";
	}else{
		errorString = @"toefl 成绩在 60 至 120 之间, ielts 成绩在 5.0 至 9.0 之间";
	}
	
//	if (errorString.length > 0) {
//		[HTAlert title:errorString];
//	}else{
//		[self.delegate next:self];
//	}
	
	[self.delegate next:self];
	
	
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
