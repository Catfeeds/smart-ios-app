//
//  HTSchoolMatriculateSchoolBackgroundController.m
//  School
//
//  Created by caoguochi on 2017/12/11.
//  Copyright © 2017年 hublot. All rights reserved.
//

#import "HTSchoolMatriculateSchoolBackgroundController.h"
#import "HTSchoolMatriculatePickerView.h"
#import "HTChooseMajorViewController.h"

@interface HTSchoolMatriculateSchoolBackgroundController ()<UITextFieldDelegate, HTChooseMajorViewControllerDelegate>

@property (nonatomic, strong) NSString *majorId;
@property (nonatomic, strong) NSString *detailMajorId;

@end

@implementation HTSchoolMatriculateSchoolBackgroundController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
	self.currenRducationalField.layer.borderColor = [UIColor ht_colorString:@"e6e6e6"].CGColor;
	self.currenSchoolField.layer.borderColor = [UIColor ht_colorString:@"e6e6e6"].CGColor;
	self.schoolNameField.layer.borderColor = [UIColor ht_colorString:@"e6e6e6"].CGColor;
	self.professionField.layer.borderColor = [UIColor ht_colorString:@"e6e6e6"].CGColor;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)previousAction:(id)sender {
    [self.delegate previous:self];
}
- (IBAction)nextAction:(id)sender {
    self.parameter.attendSchool = self.schoolNameField.text;
    NSString *errorStr = nil;
    if (self.parameter.education == nil) {
        errorStr = @"请选择你的目前学历";
    }else if (self.parameter.school == nil){
        errorStr = @"请选择你的院校等级";
    }else if (!StringNotEmpty(self.parameter.attendSchool)){
        errorStr = @"请填写你的学校名称";
    }else if (self.parameter.major_top == nil || self.parameter.major == nil ){
        errorStr = @"请选择你的当前专业";
    }
	
    if (errorStr) {
        [HTAlert title:errorStr];
    }else{
        [self.delegate next:self];
    }

}

#pragma mark - UITextFieldDelegate

- (BOOL) textFieldShouldBeginEditing:(UITextField *)textField{
    
    if (textField == self.currenRducationalField) {
        
        NSArray *array = @[@"博士",@"硕士",@"本科", @"专科", @"高中", @"初中"];
        [HTSchoolMatriculatePickerView showModelArray:@[array] selectedRowArray:@[@(0)] didSelectedBlock:^(NSArray<NSArray *> *totalModelArray, NSArray *selectedModelArray, NSArray<NSNumber *> *selectedRowArray) {
            NSLog(@"%@",selectedModelArray);
            textField.text = selectedModelArray.firstObject;
            self.parameter.education = textField.text;
        }];
        return NO;
    }else if (textField == self.currenSchoolField){
        NSArray *array = @[@"清北复交浙大",@"985学校",@"211学校", @"非211本科", @"专科"];
        [HTSchoolMatriculatePickerView showModelArray:@[array] selectedRowArray:@[@(0)] didSelectedBlock:^(NSArray<NSArray *> *totalModelArray, NSArray *selectedModelArray, NSArray<NSNumber *> *selectedRowArray) {
            NSLog(@"%@",selectedModelArray);
            NSString *str = selectedModelArray.firstObject;
            textField.text = str;
            
            if ([str isEqualToString:@"清北复交浙大"]) {
                self.parameter.school = @"1";
            }else if ([str isEqualToString:@"985学校"]){
                self.parameter.school = @"2";
            }else if ([str isEqualToString:@"211学校"]){
                self.parameter.school = @"3";
            }else if ([str isEqualToString:@"非211本科"]){
                self.parameter.school = @"4";
            }else if ([str isEqualToString:@"专科"]){
                self.parameter.school = @"5";
            }
        }];
        return NO;
    }else if (textField == self.professionField){
        
        HTChooseMajorViewController *chooseMajorViewController = STORYBOARD_VIEWCONTROLLER(@"Home", @"HTChooseMajorViewController");
        chooseMajorViewController.delegate = self;
        chooseMajorViewController.selectedMajorId = self.majorId;
        chooseMajorViewController.selectedDetailMajorId = self.detailMajorId;
        [self.parentViewController.navigationController pushViewController:chooseMajorViewController animated:YES];
        return NO;
        
    }else{
        
        return YES;
    }
    
}


#pragma mark - HTChooseMajorViewControllerDelegate

- (void)chooseMajor:(HTSchoolMatriculateSelectedModel *)majorModel detailMajor:(HTSchoolMatriculateSelectedModel *)detailMajor {
    self.parameter.major_top = majorModel.ID;
    self.parameter.major 	 = detailMajor.name;
    self.majorId 			 = majorModel.ID;
    self.detailMajorId 	     = detailMajor.ID;
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
