//
//  HTProfessionalDetailAlertView.h
//  School
//
//  Created by Charles Cao on 2017/12/27.
//  Copyright © 2017年 hublot. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HTProfessionalModel.h"

@protocol HTProfessionalDetailAlertViewDelegate <NSObject>

- (void)oddsTestAction:(HTProfessionalModel *)professionalModel;
- (void)detailAction:(HTProfessionalModel *)professionalModel;

@end

@interface HTProfessionalDetailAlertView : UIView

@property (nonatomic, assign) id<HTProfessionalDetailAlertViewDelegate> delegate;

@property (nonatomic, strong) HTProfessionalModel *professionalModel;
@property (weak, nonatomic) IBOutlet UILabel *professionalTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *professionalEnglishNameLabel;
@property (weak, nonatomic) IBOutlet UIButton *detailButton;
@property (weak, nonatomic) IBOutlet UIButton *collectionButton;

//弹框底部距离
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *alertViewBottomLayoutConstraint;

@end
