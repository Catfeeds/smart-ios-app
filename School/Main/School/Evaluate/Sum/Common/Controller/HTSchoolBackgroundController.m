//
//  HTSchoolBackgroundController.m
//  School
//
//  Created by Charles Cao on 2017/11/27.
//  Copyright © 2017年 hublot. All rights reserved.
//

#import "HTSchoolBackgroundController.h"
#import "HTSchoolMatriculatePickerView.h"
#import "HTChooseMajorViewController.h"
@interface HTSchoolBackgroundController () <UITextFieldDelegate, HTChooseMajorViewControllerDelegate>

@end

@implementation HTSchoolBackgroundController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.currenRducationalField.layer.borderColor = [UIColor ht_colorString:@"e6e6e6"].CGColor;
    self.currenSchoolField.layer.borderColor = [UIColor ht_colorString:@"e6e6e6"].CGColor;
    self.schoolNameField.layer.borderColor = [UIColor ht_colorString:@"e6e6e6"].CGColor;
    self.professionField.layer.borderColor = [UIColor ht_colorString:@"e6e6e6"].CGColor;
    
	self.contentHeight = 400.0f;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)previousAction:(id)sender {
	[self.delegate previous:self];
}
- (IBAction)nextAction:(id)sender {
	[self.delegate next:self];
}

#pragma mark - UITextFieldDelegate

- (BOOL) textFieldShouldBeginEditing:(UITextField *)textField{
    
    if (textField == self.currenRducationalField) {
		
        NSArray *array = @[@"博士",@"硕士",@"本科", @"专科", @"高中", @"初中"];
        [HTSchoolMatriculatePickerView showModelArray:@[array] selectedRowArray:@[@(0)] didSelectedBlock:^(NSArray<NSArray *> *totalModelArray, NSArray *selectedModelArray, NSArray<NSNumber *> *selectedRowArray) {
            NSLog(@"%@",selectedModelArray);
            textField.text = selectedModelArray.firstObject;
        }];
        return NO;
		
    }else if (textField == self.currenSchoolField){
		
        NSArray *array = @[@"清北复交浙大",@"985学校",@"211学校", @"非211本科", @"专科"];
        [HTSchoolMatriculatePickerView showModelArray:@[array] selectedRowArray:@[@(0)] didSelectedBlock:^(NSArray<NSArray *> *totalModelArray, NSArray *selectedModelArray, NSArray<NSNumber *> *selectedRowArray) {
            NSLog(@"%@",selectedModelArray);
            textField.text = selectedModelArray.firstObject;
         }];
        return NO;
		
    }else if (textField == self.professionField){
		
		HTChooseMajorViewController *chooseMajorViewController = STORYBOARD_VIEWCONTROLLER(@"Home", @"HTChooseMajorViewController");
		chooseMajorViewController.delegate = self;
		[self.parentViewController.navigationController pushViewController:chooseMajorViewController animated:YES];
        return NO;
		
    }else{
        
        return YES;
    }
    
}


#pragma mark - HTChooseMajorViewControllerDelegate

- (void)chooseMajor:(HTSchoolMatriculateSelectedModel *)majorModel detailMajor:(HTSchoolMatriculateSelectedModel *)detailMajor {
	self.parameter.major_top  	= majorModel.ID;
	self.parameter.major_name1  = detailMajor.name;
	self.parameter.school_major = detailMajor.ID;
	self.professionField.text = [NSString stringWithFormat:@"%@-%@",majorModel.name,detailMajor.name];
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
