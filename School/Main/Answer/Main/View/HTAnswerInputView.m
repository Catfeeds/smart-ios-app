//
//  HTAnswerInputView.m
//  School
//
//  Created by Charles Cao on 2017/12/21.
//  Copyright © 2017年 hublot. All rights reserved.
//

#import "HTAnswerInputView.h"

@implementation HTAnswerInputView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

#pragma mark - UITextViewDelegate
- (void)textViewDidBeginEditing:(UITextView *)textView {
	
}

- (void)textViewDidEndEditing:(UITextView *)textView {
	[self.window setNeedsLayout];
	[self.window layoutIfNeeded];
}


#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
	CGFloat contentHeight = scrollView.contentSize.height;
	if (contentHeight < 150 && contentHeight > 33) {
		self.textViewHeightLayoutConstraint.constant = contentHeight;
	}
}

@end
