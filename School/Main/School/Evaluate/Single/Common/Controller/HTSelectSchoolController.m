//
//  HTSelectSchoolController.m
//  School
//
//  Created by caoguochi on 2017/12/10.
//  Copyright © 2017年 hublot. All rights reserved.
//

#import "HTSelectSchoolController.h"
#import "HTSchoolMatriculateSelectMajorController.h"

@interface HTSelectSchoolController () <UITextFieldDelegate, HTSelectMajorDelegate>


@end

@implementation HTSelectSchoolController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.selectMajorField.layer.borderColor = [UIColor ht_colorString:@"cccccc"].CGColor;
    self.selectSchoolField.layer.borderColor = [UIColor ht_colorString:@"cccccc"].CGColor;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setSelectedSchool:(HTSchoolModel *)selectedSchool{
	_selectedSchool = selectedSchool;
	self.selectSchoolField.text = selectedSchool.name;
	self.selectMajorField.text = @"";
	self.selectedMajor = nil;
	
	self.parameter.schoolName = selectedSchool.name;
	self.parameter.country = selectedSchool.country;
}

- (void)setSelectedMajor:(HTSchoolProfessionalModel *)selectedMajor{
	_selectedMajor = selectedMajor;
	
	if (selectedMajor) {
		self.selectMajorField.text = selectedMajor.name;
		self.parameter.majorName = selectedMajor.name;
	}else{
		self.selectMajorField.text = @"";
		self.parameter.majorName = nil;
	}
}

- (IBAction)nextAction:(id)sender {
	
	NSString *error;
	if (!StringNotEmpty(self.parameter.majorName)) {
		error = @"请选择要进行测评的专业";
	}
	
	if (!StringNotEmpty(self.parameter.schoolName)) {
		error = @"请选择要进行测评的学校";
	}
	
	if (error) {
		[HTAlert title:error];
	}else{
		[self.delegate next:self];
	}	
}

#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
	
	if (textField == self.selectSchoolField) {
		[HTMatriculateSearchController presentSearchControllerAnimated:true matriculateModel:nil selectedBlock:^(HTSchoolModel *schoolModel) {
			self.selectedSchool = schoolModel;
		}];
	}else{
		[self performSegueWithIdentifier:@"selectToMajor" sender:nil];
	}
	
    return NO;
}

#pragma mark - HTSelectMajorDelegate
-(void)selectedMajor:(HTSchoolProfessionalModel *)major{
	major.isSelected = YES;
	if (self.selectedMajor) {
		self.selectedMajor.isSelected = NO;
	}
	self.selectedMajor = major;
}



#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
	HTSchoolMatriculateSelectMajorController *controller = [segue destinationViewController];
	controller.delegate = self;
	if (self.selectedSchool) {
		controller.majorArray = self.selectedSchool.major;
	}
	
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}


@end
