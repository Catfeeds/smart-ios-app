//
//  HTMinePreferenceInputCell.m
//  School
//
//  Created by hublot on 17/9/3.
//  Copyright © 2017年 hublot. All rights reserved.
//

#import "HTMinePreferenceInputCell.h"

@implementation HTMinePreferenceInputCell

- (void)didMoveToSuperview {
    self.backgroundColor = [UIColor clearColor];
}

- (void)setFrame:(CGRect)frame {
    frame.origin.x += 40;
    frame.origin.y += 20;
    frame.size.width -= 80;
    frame.size.height -= 20;
    [super setFrame:frame];
}

@end
