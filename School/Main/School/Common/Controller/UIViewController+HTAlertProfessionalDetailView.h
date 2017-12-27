//
//  UIViewController+HTAlertProfessionalDetailView.h
//  School
//
//  Created by Charles Cao on 2017/12/27.
//  Copyright © 2017年 hublot. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HTProfessionalDetailAlertView.h"

@interface UIViewController (HTAlertProfessionalDetailView) <HTProfessionalDetailAlertViewDelegate>

- (void)showProfessionDetailView:(NSString *)professionId;

@end


