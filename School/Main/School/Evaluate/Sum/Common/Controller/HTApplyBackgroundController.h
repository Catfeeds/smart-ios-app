//
//  HTApplyBackgroundController.h
//  School
//
//  Created by Charles Cao on 2017/11/27.
//  Copyright © 2017年 hublot. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HTChooseSchoolController.h"

@interface HTApplyBackgroundController : HTChooseSchoolController

//留学目的地
@property (weak, nonatomic) IBOutlet UITextField *destinationField;

//专业
@property (weak, nonatomic) IBOutlet UITextField *applyMajorField;

@end
