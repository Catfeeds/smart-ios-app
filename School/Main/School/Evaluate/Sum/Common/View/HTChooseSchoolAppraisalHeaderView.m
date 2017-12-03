//
//  HTChooseSchoolAppraisalHeaderView.m
//  School
//
//  Created by caoguochi on 2017/11/19.
//  Copyright © 2017年 hublot. All rights reserved.
//

#import "HTChooseSchoolAppraisalHeaderView.h"

@interface HTChooseSchoolAppraisalHeaderView()

@property (nonatomic, strong) NSArray *iconArray;
@property (nonatomic, strong) NSArray *titleLabelArray;
@property (nonatomic, strong) NSArray *stepNumberArray;
@property (nonatomic, strong) NSArray *progressLineArray;

@end

@implementation HTChooseSchoolAppraisalHeaderView

- (void)awakeFromNib
{
    [super awakeFromNib];
    [[NSBundle mainBundle] loadNibNamed:@"ChooseSchoolHead" owner:self options:nil];
    [self addSubview:self.contentView];
    
    self.iconArray = @[self.individualGradeIcon,self.schoolBackGroundIcon,self.individualBackGroundIcon,self.applyIcon];
    self.titleLabelArray = @[self.individualGradeLabel,self.schoolBackGroundLabel,self.individualLabel,self.applyLabel];
    self.stepNumberArray = @[self.step_1,self.step_2,self.step_3,self.step_4];
    self.progressLineArray = @[self.progress_1,self.progress_2,self.progress_3,self.progress_4];
    
}

- (void)setProgress:(HTChooseSchoolProgress)progress{
    _progress = progress;
    switch (progress) {
        case individualGrade:
            [self progressWithIndex:0];
            break;
        
        case schoolBackground:
            [self progressWithIndex:1];
            break;
            
        case individualBackGround:
            [self progressWithIndex:2];
            break;
            
        case applyBackground:
            [self progressWithIndex:3];
            break;
        default:
            break;
    }
}

- (void)progressWithIndex:(NSInteger)index{
    for (int i = 0; i<4; i++) {
        UIImageView *icon = self.iconArray[i];
        UILabel *titleLabel = self.titleLabelArray[i];
        UIButton *stepNumber = self.stepNumberArray[i];
        UIView *progress = self.progressLineArray[i];
        icon.highlighted = i<=index;
        titleLabel.highlighted = i<=index;
        stepNumber.selected = i<=index;
        progress.backgroundColor = i<=index ? [UIColor ht_colorString:@"74951A"] : [UIColor whiteColor];
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
