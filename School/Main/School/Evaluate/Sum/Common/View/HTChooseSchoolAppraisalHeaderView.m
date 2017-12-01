//
//  HTChooseSchoolAppraisalHeaderView.m
//  School
//
//  Created by caoguochi on 2017/11/19.
//  Copyright © 2017年 hublot. All rights reserved.
//

#import "HTChooseSchoolAppraisalHeaderView.h"

@implementation HTChooseSchoolAppraisalHeaderView

- (void)awakeFromNib
{
    [super awakeFromNib];
    [[NSBundle mainBundle] loadNibNamed:@"ChooseSchoolHead" owner:self options:nil];
    
    [self addSubview:self.contentView];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
