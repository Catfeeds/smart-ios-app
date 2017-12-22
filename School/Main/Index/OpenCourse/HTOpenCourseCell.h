//
//  HTOpenCourseCell.h
//  School
//
//  Created by Charles Cao on 2017/12/22.
//  Copyright © 2017年 hublot. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HTOpenCourseModel.h"

@protocol HTOpenCourseCellDelegate <NSObject>



@end

@interface HTOpenCourseCell : UITableViewCell


@property (nonatomic, strong) HTOpenCourseModel *courseModel;
@property (nonatomic, assign) id<HTOpenCourseCellDelegate>delegate;
@property (weak, nonatomic) IBOutlet UIImageView *courseImageView;
@property (weak, nonatomic) IBOutlet UILabel *courseTitleLabel;
//开课时间
@property (weak, nonatomic) IBOutlet UILabel *courseCreateTimeLabel;
//时长
@property (weak, nonatomic) IBOutlet UILabel *courseTimeLabel;
@property (weak, nonatomic) IBOutlet UIButton *goodButton;

@end
