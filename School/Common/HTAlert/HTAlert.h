//
//  HTAlert.h
//  TingApp
//
//  Created by hublot on 2017/5/24.
//  Copyright © 2017年 thinku. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HTOctopusAlertView.h"
#import "HTCenterLabelAlert.h"
#import "HTCircleLabelAlert.h"

@interface HTAlert : NSObject

+ (void)showProgress;

+ (void)hideProgress;



+ (void)title:(NSString *)title;

+ (void)title:(NSString *)title message:(NSString *)message;



+ (void)title:(NSString *)title sureAction:(void(^)(void))sureAction;

+ (void)title:(NSString *)title message:(NSString *)message sureAction:(void(^)(void))sureAction cancelAction:(void(^)(void))cancelAction animated:(BOOL)animated completion:(void(^)(void))completion;


+ (void)title:(NSString *)title message:(NSString *)message sureAction:(void(^)(void))sureAction;



+ (HTOctopusAlertView *)title:(NSString *)title message:(NSString *)message tryAgainTitle:(NSString *)tryAgainTitle tryAgainBlock:(void(^)(void))tryAgainBlock;

+ (void)tryAgaginDismissAlert;


+ (HTCenterLabelAlert *)centerTitle:(NSString *)centerTitle;

+ (HTCircleLabelAlert *)circleTitle:(NSString *)circleTitle superView:(UIView *)superView;

@end
