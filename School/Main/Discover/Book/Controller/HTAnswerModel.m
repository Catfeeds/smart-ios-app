//
//  HTAnswerModel.m
//  School
//
//  Created by hublot on 17/8/13.
//  Copyright © 2017年 hublot. All rights reserved.
//

#import "HTAnswerModel.h"
#import <NSString+HTString.h>
#import <NSMutableAttributedString+HTMutableAttributedString.h>

@implementation HTAnswerModel


+ (NSDictionary *)objectClassInArray{
    return @{@"answer" : [HTAnswerSolutionModel class], @"tags" : [HTAnswerTagModel class]};
}

- (void)mj_keyValuesDidFinishConvertingToObject {
	NSMutableAttributedString *attributedString = [[[self.content ht_htmlDecodeString] ht_handleFillPlaceHolderImageWithMaxWidth:HTSCREENWIDTH - 30 placeholderImage:HTPLACEHOLDERIMAGE] mutableCopy];
    [attributedString ht_clearPrefixBreakLine];
    [attributedString ht_clearSuffixBreakLine];
	self.contentAttributedString = attributedString;
}

@end

@implementation HTAnswerSolutionModel

+ (NSDictionary *)objectClassInArray{
	return @{@"reply" : [HTAnswerReplyModel class]};
}

- (void)mj_keyValuesDidFinishConvertingToObject {
	NSMutableAttributedString *attributedString = [[[self.content ht_htmlDecodeString] ht_handleFillPlaceHolderImageWithMaxWidth:HTSCREENWIDTH - 30 placeholderImage:HTPLACEHOLDERIMAGE] mutableCopy];
    [attributedString ht_clearPrefixBreakLine];
    [attributedString ht_clearSuffixBreakLine];
	[attributedString ht_changeFontWithZoomNumber:1.1];
	[attributedString ht_changeColorWithColorAlpha:0.6];
	self.contentAttributedString = attributedString;
}

@end

@implementation HTAnswerReplyModel

@end
