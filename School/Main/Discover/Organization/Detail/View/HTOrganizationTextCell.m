//
//  HTOrganizationTextCell.m
//  School
//
//  Created by hublot on 2017/8/28.
//  Copyright © 2017年 hublot. All rights reserved.
//

#import "HTOrganizationTextCell.h"
#import "HTImageTextView.h"
#import "HTWebController.h"
#import <NSObject+HTTableRowHeight.h>
#import <NSObject+HTObjectCategory.h>

@interface HTOrganizationTextCell ()

@property (nonatomic, strong) HTImageTextView *textView;

@property (nonatomic, strong) id model;

@end

@implementation HTOrganizationTextCell

- (void)didMoveToSuperview {
	[self addSubview:self.textView];
	[self.textView mas_updateConstraints:^(MASConstraintMaker *make) {
		make.edges.mas_equalTo(UIEdgeInsetsZero);
	}];
}

- (void)setModel:(NSString *)model row:(NSInteger)row {
	if (_model == model) {
		return;
	}
	_model = model;
	__weak typeof(self) weakSelf = self;
	SEL attributedStringSelector = NSSelectorFromString(@"attributedStringSelector");
	NSAttributedString *attributedString = [model ht_valueForSelector:attributedStringSelector runtime:true];
	if (!attributedString) {
		dispatch_async(dispatch_get_global_queue(0, 0), ^{
			NSAttributedString *attributedString = [[model ht_htmlDecodeString] ht_handleFillPlaceHolderImageWithMaxWidth:HTSCREENWIDTH - 30 placeholderImage:HTPLACEHOLDERIMAGE];
			[model ht_setValue:attributedString forSelector:attributedStringSelector runtime:true];
			dispatch_async(dispatch_get_main_queue(), ^{
				[weakSelf setAttributedString:attributedString model:model];
			});
		});
	} else {
		[weakSelf setAttributedString:attributedString model:model];
	}
}

- (void)setAttributedString:(NSAttributedString *)attributedString model:(NSString *)model {
	__weak typeof(self) weakSelf = self;
	[self.textView setAttributedString:attributedString textViewMaxWidth:HTSCREENWIDTH - 30 appendImageBaseURLBlock:^NSString *(UITextView *textView, NSString *imagePath) {
		if (![imagePath containsString:@"http"]) {
			return SmartApplyResourse(imagePath);
		}
		return imagePath;
	} reloadHeightBlock:^(UITextView *textView, CGFloat contentHeight) {
		NSNumber *oldModelHeightNumber = [model ht_rowHeightNumberForCellClass:weakSelf.class];
		CGFloat newModelHeight = contentHeight;
		[model ht_setRowHeightNumber:@(newModelHeight) forCellClass:weakSelf.class];
		if (oldModelHeightNumber) {
			if (weakSelf.reloadTableRowBlock) {
				weakSelf.reloadTableRowBlock();
			}
		}
	} didSelectedURLBlock:^(UITextView *textView, NSURL *URL, NSString *titleName) {
		HTWebController *webController = [[HTWebController alloc] initWithURL:URL];
		[weakSelf.ht_controller.navigationController pushViewController:webController animated:true];
	}];
}

- (HTImageTextView *)textView {
	if (!_textView) {
		_textView = [[HTImageTextView alloc] initWithFrame:CGRectZero];
		_textView.alwaysBounceVertical = true;
		_textView.textContainerInset = UIEdgeInsetsMake(15, 15, 15, 15);
		_textView.scrollEnabled = false;
	}
	return _textView;
}


@end
