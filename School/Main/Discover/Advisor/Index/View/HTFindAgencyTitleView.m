//
//  HTFindAgencyTitleView.m
//  School
//
//  Created by Charles Cao on 2017/12/14.
//  Copyright © 2017年 hublot. All rights reserved.
//

#import "HTFindAgencyTitleView.h"

@implementation HTFindAgencyTitleView

- (void)awakeFromNib{
	[super awakeFromNib];
	
	[self clickAction:self.leftItem];
	
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)setSelectIndex:(NSInteger)index{
	UIButton *btn = index == 0 ? self.leftItem : self.rightItem;
	[self clickAction:btn];
}

- (IBAction)clickAction:(UIButton *)sender {
	if (sender != self.currentSelectButton) {
		[sender setBackgroundColor:[UIColor whiteColor]];
		[self.currentSelectButton setBackgroundColor:[UIColor clearColor]];
		self.currentSelectButton.selected = NO;
		sender.selected = YES;
		self.currentSelectButton = sender;
		[self.delegate clickAction:sender];
	}
}


@end
