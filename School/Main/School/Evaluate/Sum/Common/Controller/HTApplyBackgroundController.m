//
//  HTApplyBackgroundController.m
//  School
//
//  Created by Charles Cao on 2017/11/27.
//  Copyright © 2017年 hublot. All rights reserved.
//

#import "HTApplyBackgroundController.h"
#import "HTDestinationViewController.h"
#import "HTChooseMajorViewController.h"

@interface HTApplyBackgroundController ()<UITextFieldDelegate, HTDestinationViewControllerDelegate, HTChooseMajorViewControllerDelegate>

@property (nonatomic, strong) HTSchoolMatriculateSelectedModel *selectedCountry;
@property (nonatomic, strong) NSString *majorId;
@property (nonatomic, strong) NSString *detailMajorId;

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
	
	NSString *errorStr = nil;
	if (!self.selectedCountry) {
		errorStr = @"请填写你的留学目的地";
	}
	
	if (!StringNotEmpty(self.applyMajorField.text)) {
		errorStr = @"请选择你的目标专业";
	}
	
	if (errorStr) {
		[HTAlert title:errorStr];
	}else{
		[self.delegate submit];
	}
	
	
}

#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
	
	if (textField == self.destinationField) {
		HTDestinationViewController *destinationController = STORYBOARD_VIEWCONTROLLER(@"Home", @"HTDestinationViewController");
		destinationController.delegate = self;
		if (self.selectedCountry) {
			destinationController.selectedCountryID = self.selectedCountry.ID;
		}
		[self.navigationController pushViewController:destinationController animated:YES];
	}else {
		HTChooseMajorViewController *chooseMajorViewController = STORYBOARD_VIEWCONTROLLER(@"Home", @"HTChooseMajorViewController");
		chooseMajorViewController.delegate = self;
		chooseMajorViewController.selectedMajorId = self.majorId;
		chooseMajorViewController.selectedDetailMajorId = self.detailMajorId;
		[self.parentViewController.navigationController pushViewController:chooseMajorViewController animated:YES];
	}
	
	return NO;
}

#pragma mark - HTChooseMajorViewControllerDelegate

- (void)selectedCountryModel:(HTSchoolMatriculateSelectedModel *)country{
	self.selectedCountry = country;
	self.parameter.destination = self.selectedCountry.ID;
	self.destinationField.text = country.name;
}

#pragma mark - HTChooseMajorViewControllerDelegate

- (void)chooseMajor:(HTSchoolMatriculateSelectedModel *)majorModel detailMajor:(HTSchoolMatriculateSelectedModel *)detailMajor {
	self.parameter.major = detailMajor.ID;
	self.parameter.major_name2 = detailMajor.name;
	self.majorId = majorModel.ID;
	self.detailMajorId = detailMajor.ID;
	self.applyMajorField.text = [NSString stringWithFormat:@"%@-%@",majorModel.name,detailMajor.name];	
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
