//
//  HTProfessionalModel.m
//  School
//
//  Created by hublot on 2017/7/26.
//  Copyright © 2017年 hublot. All rights reserved.
//

#import "HTProfessionalModel.h"
#import <NSString+HTString.h>
#import <NSAttributedString+HTAttributedString.h>
#import <NSMutableAttributedString+HTMutableAttributedString.h>

@implementation HTProfessionalModel


+ (NSDictionary *)objectClassInArray{
    return @{@"school" : [HTProfessionalSchoolModel class], @"data" : [HTProfessionalDetailModel class], @"link" : [HTProfessionLinkModel class]};
}

- (NSAttributedString *)professionalBaseAttributedString {
	if (!_professionalBaseAttributedString) {
		HTProfessionalDetailModel *professionalModel = self.data.firstObject;
		NSString *chineseTitleKey = @"chineseTitleKey";
		NSString *englishTitleKey = @"englishTitleKey";
		NSString *chineseDetailKey = @"chineseDetailKey";
		NSArray *keyValueArray = @[
								   @{chineseTitleKey:@"项目名称", englishTitleKey:@"(Project name)", chineseDetailKey:[NSString stringWithFormat:@": %@(%@)\n", professionalModel.title, professionalModel.name]},
								   @{chineseTitleKey:@"项目网址", englishTitleKey:@"(Project site)", chineseDetailKey:[NSString stringWithFormat:@": %@\n", professionalModel.url]},
								   @{chineseTitleKey:@"项目时期", englishTitleKey:@"(Project period)", chineseDetailKey:[NSString stringWithFormat:@": %@\n", professionalModel.admissionTime]},
								   @{chineseTitleKey:@"截止日期", englishTitleKey:@"(As of the date)", chineseDetailKey:[NSString stringWithFormat:@": %@\n", professionalModel.deadline]},
								   ];
		NSMutableAttributedString *attributedString = [[[NSAttributedString alloc] initWithString:@""] mutableCopy];
		
		UIImage *image = [UIImage ht_pureColor:[UIColor ht_colorStyle:HTColorStyleTintColor]];
		UIFont *normalFont = [UIFont systemFontOfSize:15];
		image = [image ht_resetSize:CGSizeMake(2, normalFont.pointSize - 2)];
		
		UIImage *backgroundImage = [UIImage ht_pureColor:[UIColor clearColor]];
		CGFloat appendBackgroundWidth = 20;
		backgroundImage = [backgroundImage ht_resetSize:CGSizeMake(image.size.width + appendBackgroundWidth, image.size.height)];
		backgroundImage = [backgroundImage ht_appendImage:image atRect:CGRectMake(appendBackgroundWidth / 2, 0, image.size.width, image.size.height)];
		
		NSTextAttachment *textAttachment = [[NSTextAttachment alloc] init];
		textAttachment.image = backgroundImage;
		textAttachment.bounds = CGRectMake(0, - 1.5, backgroundImage.size.width, backgroundImage.size.height);
		NSDictionary *normalDictionary = @{NSForegroundColorAttributeName:[UIColor ht_colorStyle:HTColorStylePrimaryTitle],
										   NSFontAttributeName:normalFont};
		NSDictionary *selectedDictionary = @{NSForegroundColorAttributeName:[UIColor ht_colorStyle:HTColorStyleSecondaryTitle],
											 NSFontAttributeName:[UIFont systemFontOfSize:13]};
		
		
		[keyValueArray enumerateObjectsUsingBlock:^(NSDictionary *dictionary, NSUInteger idx, BOOL * _Nonnull stop) {
			NSString *chineseTitleString = dictionary[chineseTitleKey];
			NSString *englishTitleString = dictionary[englishTitleKey];
			NSString *chineseDetailString = dictionary[chineseDetailKey];
			
			NSAttributedString *appendAttributedString = [NSAttributedString attributedStringWithAttachment:textAttachment];
			[attributedString appendAttributedString:appendAttributedString];
			appendAttributedString = [[NSAttributedString alloc] initWithString:chineseTitleString attributes:normalDictionary];
			[attributedString appendAttributedString:appendAttributedString];
			appendAttributedString = [[NSAttributedString alloc] initWithString:englishTitleString attributes:selectedDictionary];
			[attributedString appendAttributedString:appendAttributedString];
			appendAttributedString = [[NSAttributedString alloc] initWithString:chineseDetailString attributes:normalDictionary];
			[attributedString appendAttributedString:appendAttributedString];
		}];
		NSMutableParagraphStyle *paragraphStyle = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
		paragraphStyle.paragraphSpacing = 10;
		[attributedString addAttributes:@{NSParagraphStyleAttributeName:paragraphStyle} range:NSMakeRange(0, attributedString.length)];
		_professionalBaseAttributedString = attributedString;
	}
	return _professionalBaseAttributedString;
}

- (NSAttributedString *)professionalApplyAttributedString {
	if (!_professionalApplyAttributedString) {
		HTProfessionalDetailModel *professionalModel = self.data.firstObject;
		NSMutableAttributedString *attributedString = [[professionalModel.performance ht_attributedStringNeedDispatcher:nil] mutableCopy];
		[attributedString ht_clearPrefixBreakLine];
		[attributedString ht_clearSuffixBreakLine];
		[attributedString ht_EnumerateAttribute:NSFontAttributeName usingBlock:^(UIFont *normalFont, NSRange range, BOOL *stop) {
			UIFont *selectedFont = [UIFont fontWithDescriptor:normalFont.fontDescriptor size:MAX(normalFont.pointSize, 14)];
			[attributedString addAttributes:@{NSFontAttributeName:selectedFont} range:range];
		}];
		_professionalApplyAttributedString = attributedString;
	}
	return _professionalApplyAttributedString;
}

- (NSAttributedString *)professionalLinkAttributedString {
	if (!_professionalLinkAttributedString) {
		UIImage *image = [UIImage imageNamed:@"cn2_school_professional_left_link"];
		image = [image ht_resetSizeWithStandard:12 isMinStandard:false];
		image = [image ht_insertColor:[UIColor clearColor] edge:UIEdgeInsetsMake(0, 0, 0, 5)];
		NSTextAttachment *textAttachment = [[NSTextAttachment alloc] init];
		textAttachment.image = image;
		textAttachment.bounds = CGRectMake(0, 0, image.size.width, image.size.height);
		
		NSMutableAttributedString *attributedString = [[[NSAttributedString alloc] initWithString:@""] mutableCopy];
		NSDictionary *normalDictionary = @{NSForegroundColorAttributeName:[UIColor ht_colorStyle:HTColorStylePrimaryTitle],
										   NSFontAttributeName:[UIFont systemFontOfSize:14]};
		NSDictionary *selectedDictionary = @{NSForegroundColorAttributeName:[UIColor ht_colorStyle:HTColorStyleSecondaryTitle],
											 NSFontAttributeName:[UIFont systemFontOfSize:14]};
		
		
		[self.link enumerateObjectsUsingBlock:^(HTProfessionLinkModel *linkModel, NSUInteger index, BOOL * _Nonnull stop) {
			NSAttributedString *appendAttributedString = [NSAttributedString attributedStringWithAttachment:textAttachment];
			[attributedString appendAttributedString:appendAttributedString];
			appendAttributedString = [[NSAttributedString alloc] initWithString:linkModel.name attributes:normalDictionary];
			[attributedString appendAttributedString:appendAttributedString];
			appendAttributedString = [[NSAttributedString alloc] initWithString:@": " attributes:selectedDictionary];
			[attributedString appendAttributedString:appendAttributedString];
			appendAttributedString = [[NSAttributedString alloc] initWithString:linkModel.url attributes:selectedDictionary];
			[attributedString appendAttributedString:appendAttributedString];
			appendAttributedString = [[NSAttributedString alloc] initWithString:@"\n" attributes:selectedDictionary];
			[attributedString appendAttributedString:appendAttributedString];
		}];
		NSMutableParagraphStyle *paragraphStyle = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
		paragraphStyle.paragraphSpacing = 8;
		[attributedString addAttributes:@{NSParagraphStyleAttributeName:paragraphStyle} range:NSMakeRange(0, attributedString.length)];
		_professionalLinkAttributedString = attributedString;
	}
	return _professionalLinkAttributedString;
}

@end
@implementation HTProfessionalSchoolModel

@end


@implementation HTProfessionalDetailModel

@end


@implementation HTProfessionLinkModel

@end


