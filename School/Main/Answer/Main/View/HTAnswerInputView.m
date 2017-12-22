//
//  HTAnswerInputView.m
//  School
//
//  Created by Charles Cao on 2017/12/21.
//  Copyright © 2017年 hublot. All rights reserved.
//

#import "HTAnswerInputView.h"

#define DefaultPlaceholderStr @"请输入要回答的内容"

@implementation HTAnswerInputView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)showInputViewWithPlaceholder:(NSString *)placeholder sendText:(SendTextBlock)completeBlock{
	
	self.sendTextBlock = completeBlock;
	self.placeholderLabel.text = StringNotEmpty(placeholder) ? placeholder : DefaultPlaceholderStr;
    [self.inputTextView becomeFirstResponder];
}

#pragma mark - UITextViewDelegate

- (void)textViewDidEndEditing:(UITextView *)textView {
	if (!textView.hasText) {
		self.placeholderLabel.text = DefaultPlaceholderStr;
	}
	[self.window setNeedsLayout];
	[self.window layoutIfNeeded];
}

- (void)textViewDidChange:(UITextView *)textView{
    CGSize bestSize = [textView sizeThatFits:CGSizeMake(textView.frame.size.width, 200)];
    CGFloat height = 33;
    if (bestSize.height > 150)
        height = 150;
    else if (bestSize.height < 33)
        height = 33;
    else
        height = bestSize.height;
    
    [self mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(height+20);
    }];
	self.placeholderLabel.hidden = textView.hasText;
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"]){
		self.sendTextBlock(textView.text);
        [textView resignFirstResponder];
        return NO;
    }
    
    return YES;
}

@end
@implementation HTInputTextView

- (BOOL)canPerformAction:(SEL)action withSender:(id)sender{
    if (action == @selector(copy:))
    {
        return YES;
    }
    else if (action == @selector(select:))
    {
        return YES;
    }
    else if (action == @selector(selectAll:))
    {
        return YES;
    }
    else if (action == @selector(cut:))
    {
        return YES;
    }
    else if (action == @selector(paste:))
    {
        return YES;
    }
    
    return NO;
}

- (BOOL)canBecomeFirstResponder{
    return YES;
}


@end
