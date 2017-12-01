//
//  HTSchoolModel.m
//  School
//
//  Created by hublot on 2017/7/26.
//  Copyright © 2017年 hublot. All rights reserved.
//

#import "HTSchoolModel.h"
#import <NSString+HTString.h>
#import <NSAttributedString+HTAttributedString.h>
#import <NSMutableAttributedString+HTMutableAttributedString.h>

@implementation HTSchoolModel


+ (NSDictionary *)objectClassInArray {
    return @{@"major" : [HTSchoolProfessionalModel class]};
}

- (void)mj_keyValuesDidFinishConvertingToObject {
	
}

- (NSAttributedString *)schoolDescriptionAttributedString {
	if (!_schoolDescriptionAttributedString) {
		NSMutableAttributedString *descriptionAttributedString = [[self.cnName ht_attributedStringNeedDispatcher:nil] mutableCopy];
		[descriptionAttributedString ht_EnumerateAttribute:NSFontAttributeName usingBlock:^(UIFont *normalFont, NSRange range, BOOL *stop) {
			UIFont *customFont = [UIFont fontWithDescriptor:normalFont.fontDescriptor size:MAX(15, normalFont.pointSize)];
			[descriptionAttributedString addAttributes:@{NSFontAttributeName:customFont} range:range];
		}];
		[descriptionAttributedString ht_changeColorWithColorAlpha:0.7];
		[descriptionAttributedString ht_clearPrefixBreakLine];
		[descriptionAttributedString ht_clearSuffixBreakLine];
		_schoolDescriptionAttributedString = descriptionAttributedString;
	}
	return _schoolDescriptionAttributedString;
}

- (NSAttributedString *)schoolInformationAttributedString {
	if (!_schoolInformationAttributedString) {
		NSDictionary *titleNameDictionary = @{NSForegroundColorAttributeName:[UIColor ht_colorStyle:HTColorStylePrimaryTitle],
											  NSFontAttributeName:[UIFont systemFontOfSize:16]};
		NSDictionary *detailNormalDictionary = @{NSForegroundColorAttributeName:[UIColor ht_colorStyle:HTColorStyleSecondaryTitle],
												 NSFontAttributeName:[UIFont systemFontOfSize:16]};
		NSDictionary *detailSelectedDictionary = @{NSForegroundColorAttributeName:[UIColor ht_colorStyle:HTColorStyleTintColor],
												   NSFontAttributeName:[UIFont systemFontOfSize:16]};
		NSArray *titleNameArray = @[@"所在地: ", [NSString stringWithFormat:@"%@\n", self.answer],
									@"地理位置: ", [NSString stringWithFormat:@"%@\n", self.alternatives],
									@"学校排名: ", [NSString stringWithFormat:@"%@\n", self.article],
									@"官网: ", [NSString stringWithFormat:@"%@", self.listeningFile]];
		NSArray *detailDictionaryArray = @[titleNameDictionary, detailNormalDictionary,
										   titleNameDictionary, detailNormalDictionary,
										   titleNameDictionary, detailSelectedDictionary,
										   titleNameDictionary, detailNormalDictionary];
		NSMutableAttributedString *informationAttributedString = [[[NSAttributedString alloc] initWithString:@""] mutableCopy];
		[titleNameArray enumerateObjectsUsingBlock:^(NSString *titleName, NSUInteger idx, BOOL * _Nonnull stop) {
			NSDictionary *dictionary = detailDictionaryArray[idx];
			NSAttributedString *appendAttributedString = [[NSAttributedString alloc] initWithString:titleName attributes:dictionary];
			[informationAttributedString appendAttributedString:appendAttributedString];
		}];
		
		CGFloat lineSpace = 10;
		NSMutableParagraphStyle *paragraphStyle = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
		paragraphStyle.lineSpacing = lineSpace;
		[informationAttributedString addAttributes:@{NSParagraphStyleAttributeName:paragraphStyle} range:NSMakeRange(0, informationAttributedString.length)];
		_schoolInformationAttributedString = informationAttributedString;
	}
	return _schoolInformationAttributedString;
}

- (NSArray<HTSchoolBaseDataModel *> *)baseDataArray {
	if (!_baseDataArray) {
		NSString *titleNameKey = @"titleNameKey";
		NSString *detailNameKey = @"detailNameKey";
		NSArray *keyValueArray = @[
									   @{titleNameKey:@"排名", detailNameKey:self.article},
									   @{titleNameKey:@"年总费用", detailNameKey:HTPlaceholderString(self.sentenceNumber, @"暂无详情内容")}
							     ];
		NSMutableArray *modelArray = [@[] mutableCopy];
		[keyValueArray enumerateObjectsUsingBlock:^(NSDictionary *dictionary, NSUInteger index, BOOL * _Nonnull stop) {
			HTSchoolBaseDataModel *model = [[HTSchoolBaseDataModel alloc] init];
			model.titleName = dictionary[titleNameKey];
			model.detailName = dictionary[detailNameKey];
			[modelArray addObject:model];
		}];
		_baseDataArray = modelArray;
	}
	return _baseDataArray;
}

@end

@implementation HTSchoolProfessionalModel

+ (NSDictionary *)objectClassInArray{
    return @{@"content" : [HTSchoolProfessionalSubModel class]};
}

- (NSArray<HTSchoolProfessionalSubModel *> *)content {
	if (self.sectionIsSelected) {
		return @[];
	}
	return _content;
}

@end


@implementation HTSchoolProfessionalSubModel

@end

@implementation HTSchoolBaseDataModel

@end

