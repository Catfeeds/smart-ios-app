//
//  HTPersonBackgroundController.h
//  School
//
//  Created by Charles Cao on 2017/11/27.
//  Copyright © 2017年 hublot. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HTChooseSchoolController.h"

@interface HTPersonBackgroundController : HTChooseSchoolController

//工作单位
@property (weak, nonatomic) IBOutlet UITextField *workUnitField;

//工作经验
@property (weak, nonatomic) IBOutlet UITextView *workExperienceTextView;

//项目经验
@property (weak, nonatomic) IBOutlet UITextView *projectExperienceTextView;

//海外留学
@property (weak, nonatomic) IBOutlet UITextView *overseasTextView;

//公益活动
@property (weak, nonatomic) IBOutlet UITextView *benefitActivityTextView;

//获奖经历
@property (weak, nonatomic) IBOutlet UITextView *awardExperienceTextView;

@end
