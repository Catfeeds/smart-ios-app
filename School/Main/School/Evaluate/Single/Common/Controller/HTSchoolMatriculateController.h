//
//  HTSchoolMatriculateController.h
//  School
//
//  Created by caoguochi on 2017/12/10.
//  Copyright © 2017年 hublot. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TSchoolMatriculateDelegate <NSObject>

- (void)next:(UIViewController *) controller;

- (void)previous:(UIViewController *) controller;

- (void)submit;

@end

@interface HTSchoolMatriculateController : UIViewController

//@property (nonatomic, strong) HTChooseSchoolEvaluationModel *parameter;
@property (nonatomic, assign) CGFloat contentHeight;
@property (nonatomic, assign) id<TSchoolMatriculateDelegate> delegate;

@end
