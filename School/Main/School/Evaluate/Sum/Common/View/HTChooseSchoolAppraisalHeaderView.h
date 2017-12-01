//
//  HTChooseSchoolAppraisalHeaderView.h
//  School
//
//  Created by caoguochi on 2017/11/19.
//  Copyright © 2017年 hublot. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface HTChooseSchoolAppraisalHeaderView : UIView

//个人成绩
@property (weak, nonatomic) IBOutlet UIImageView *individualGradeIcon;
@property (weak, nonatomic) IBOutlet UILabel *individualGradeLabel;
//学校背景
@property (weak, nonatomic) IBOutlet UIImageView *schoolBackGroundIcon;
@property (weak, nonatomic) IBOutlet UILabel *schoolBackGroundLabel;
//个人背景
@property (weak, nonatomic) IBOutlet UIImageView *individualBackGround;
@property (weak, nonatomic) IBOutlet UILabel *individualLabel;
//申请方向背景
@property (weak, nonatomic) IBOutlet UIImageView *applyIcon;
@property (weak, nonatomic) IBOutlet UILabel *applyLabel;

//进度
@property (weak, nonatomic) IBOutlet UIButton *step_2;
@property (weak, nonatomic) IBOutlet UIButton *step_3;
@property (weak, nonatomic) IBOutlet UIButton *step_4;

@property (weak, nonatomic) IBOutlet UIView *progress_2;
@property (weak, nonatomic) IBOutlet UIView *progress_3;
@property (weak, nonatomic) IBOutlet UIView *progress_4;


@property (strong, nonatomic) IBOutlet UIView *contentView;

@end
