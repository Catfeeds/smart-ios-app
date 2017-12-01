//
//  HTGradeEvaluationController.h
//  School
//
//  Created by Charles Cao on 2017/11/27.
//  Copyright © 2017年 hublot. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HTChooseSchoolController.h"

@interface HTGradeEvaluationController : HTChooseSchoolController

@property (weak, nonatomic) IBOutlet UITextField *GPALabel;
@property (weak, nonatomic) IBOutlet UITextField *GMATLabel;
@property (weak, nonatomic) IBOutlet UITextField *TOFELLabel;

@end
