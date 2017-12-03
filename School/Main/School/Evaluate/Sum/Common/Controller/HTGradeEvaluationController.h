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

@property (weak, nonatomic) IBOutlet UITextField *GPAField;
@property (weak, nonatomic) IBOutlet UITextField *GMATField;
@property (weak, nonatomic) IBOutlet UITextField *TOFELField;

@end
