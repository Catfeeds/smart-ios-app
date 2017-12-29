//
//  HTSearchResultModel.h
//  School
//
//  Created by hublot on 2017/9/12.
//  Copyright © 2017年 hublot. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HTSearchItemModel.h"


@interface HTSearchMajorModel : NSObject

@property (nonatomic, strong) NSString *ID;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *answer;
@end

@interface HTSearchResultModel : NSObject

@property (nonatomic, assign) HTSearchType type;

@property (nonatomic, copy) NSString *ID;

@property (nonatomic, copy) NSString *image;

@property (nonatomic, copy) NSString *titleName;

@property (nonatomic, copy) NSString *detailName;

+ (NSArray *)packModelArrayWithResponse:(id)response type:(HTSearchType)type;

@end
