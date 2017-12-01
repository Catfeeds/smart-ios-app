//
//  HTChooseSchoolController.h
//  School
//
//  Created by Charles Cao on 2017/11/29.
//  Copyright © 2017年 hublot. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HTChooseSchoolEvaluationModel.h"

@protocol HTChooseSchoolEvaluationDelegate <NSObject>

- (void)next:(UIViewController *) controller;

- (void)previous:(UIViewController *) controller;

- (void)submit;

@end




@interface HTChooseSchoolController : UIViewController

@property (nonatomic, strong) HTChooseSchoolEvaluationModel *parameter;
@property (nonatomic, assign) CGFloat contentHeight;
@property (nonatomic, assign) id<HTChooseSchoolEvaluationDelegate> delegate;

@end

