//
//  HTSchoolMatriculateGradeController.m
//  School
//
//  Created by caoguochi on 2017/12/11.
//  Copyright © 2017年 hublot. All rights reserved.
//

#import "HTSchoolMatriculateGradeController.h"

@interface HTSchoolMatriculateGradeController ()

@end

@implementation HTSchoolMatriculateGradeController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.GPAField.layer.borderColor = [UIColor ht_colorString:@"e6e6e6"].CGColor;
    self.GMATField.layer.borderColor = [UIColor ht_colorString:@"e6e6e6"].CGColor;
    self.TOFELField.layer.borderColor = [UIColor ht_colorString:@"e6e6e6"].CGColor;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)nextAction:(id)sender {
    
    CGFloat gpa = self.GPAField.text.floatValue;
    CGFloat gmat_gre = self.GMATField.text.floatValue;
    CGFloat toefl_ielts = self.TOFELField.text.floatValue;

    NSString *errorString = @"";
    if ((gpa >= 2.5 && gpa <= 4.0) || (gpa >= 50 && gpa <= 100)) {
        self.parameter.gpa = @(gpa).stringValue;
    }else{
        errorString = @"gpa 成绩在 2.5 至 4.0 之间 或者 50 至 100 之间";
    }

    if ((gmat_gre >= 200 && gmat_gre <= 340) || (gmat_gre >= 400 && gmat_gre <= 800)) {
        self.parameter.gmat = @(gmat_gre).stringValue;
    }else if (gmat_gre == 0){
        self.parameter.gmat = @"";
    }else{
        errorString = @"gmat 成绩在 400 至 800 之间, gre 成绩在 200 至 340 之间";
    }

    if ((toefl_ielts >= 60 && toefl_ielts <= 120) || (toefl_ielts >= 5.0 && toefl_ielts <= 9.0)) {
        self.parameter.toefl = @(toefl_ielts).stringValue;
    }else{
        errorString = @"toefl 成绩在 60 至 120 之间, ielts 成绩在 5.0 至 9.0 之间";
    }

    if (errorString.length > 0) {
        [HTAlert title:errorString];
    }else{
        [self.delegate next:self];
    }
}

- (IBAction)previousAction:(id)sender {
    [self.delegate previous:self];
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
