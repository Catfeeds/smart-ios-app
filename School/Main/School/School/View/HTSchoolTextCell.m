//
//  HTSchoolTextCell.m
//  School
//
//  Created by hublot on 2017/9/21.
//  Copyright © 2017年 hublot. All rights reserved.
//

#import "HTSchoolTextCell.h"
#import "HTWebController.h"
#import <NSAttributedString+HTAttributedString.h>
#import <NSObject+HTTableRowHeight.h>

@interface HTSchoolTextCell () <UITextViewDelegate>

@property (nonatomic, strong) UITextView *textView;

@end

@implementation HTSchoolTextCell

- (void)didMoveToSuperview {
	[self addSubview:self.textView];
	[self.textView mas_updateConstraints:^(MASConstraintMaker *make) {
		make.edges.mas_equalTo(UIEdgeInsetsMake(15, 15, 15, 15));
	}];
}

- (void)setModel:(NSAttributedString *)model row:(NSInteger)row {
	self.textView.attributedText = model;
	CGFloat modelHeight = [self.textView.attributedText ht_attributedStringHeightWithWidth:HTSCREENWIDTH - 30 textView:self.textView];
	modelHeight += 30;
	[model ht_setRowHeightNumber:@(modelHeight) forCellClass:self.class];
}

- (UITextView *)textView {
	if (!_textView) {
		_textView = [[UITextView alloc] init];
//		_textView.scrollEnabled = false;
		_textView.textContainerInset = UIEdgeInsetsZero;
		_textView.selectable = true;
		_textView.editable = false;
		_textView.dataDetectorTypes = UIDataDetectorTypeLink | UIDataDetectorTypeAddress;
		_textView.delegate = self;
	}
	return _textView;
}

- (BOOL)textView:(UITextView *)textView shouldInteractWithURL:(NSURL *)URL inRange:(NSRange)characterRange interaction:(UITextItemInteraction)interaction {
	HTWebController *webController = [[HTWebController alloc] initWithURL:URL];
	[self.ht_controller.navigationController pushViewController:webController animated:true];
	return false;
}

- (BOOL)textView:(UITextView *)textView shouldInteractWithURL:(NSURL *)URL inRange:(NSRange)characterRange {
	return [self textView:textView shouldInteractWithURL:URL inRange:characterRange interaction:UITextItemInteractionInvokeDefaultAction];
}

@end
