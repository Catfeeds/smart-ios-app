//
//  HTStudyAbroadModel.h
//  School
//
//  Created by Charles Cao on 2017/12/20.
//  Copyright © 2017年 hublot. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, HTSelectorModelType) {
	HTSelectorModelServiceType,
	HTSelectorModelCountryType
};


@interface HTStudyAbroadSelectorModel : NSObject

@property (nonatomic, strong) NSString *ID;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, assign) HTSelectorModelType type;

@end

@interface HTStudyAbroadData : NSObject

@property (nonatomic, strong) NSString *ID;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *image;
@property (nonatomic, strong) NSString *price;
@property (nonatomic, strong) NSString *originalPrice;

@end

@interface HTStudyAbroadServiceType : HTStudyAbroadSelectorModel

@end

@interface HTStudyAbroadCountry : HTStudyAbroadSelectorModel


@end

@interface HTStudyAbroadModel : NSObject

@property (nonatomic, strong) NSArray<HTStudyAbroadData *> *data;
@property (nonatomic, strong) NSArray<HTStudyAbroadServiceType *> *serviceTypes;
@property (nonatomic, strong) NSArray<HTStudyAbroadCountry *> *countrys;

@end
