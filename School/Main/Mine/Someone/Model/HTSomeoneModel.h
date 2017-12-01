//
//  HTSomeoneModel.h
//  School
//
//  Created by hublot on 17/9/3.
//  Copyright © 2017年 hublot. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HTUser.h"

typedef NS_ENUM(NSInteger, HTSomeoneType) {
    HTSomeoneTypeAnswer,
    HTSomeoneTypeSolution,
    HTSomeoneTypeFans,
    HTSomeoneTypeLike,
};

@interface HTSomeoneModel : NSObject

@property (nonatomic, assign) HTSomeoneType type;

@property (nonatomic, assign) NSString *titleName;

@property (nonatomic, strong) NSString *imageName;

@property (nonatomic, strong) NSString *detailCount;

+ (NSArray <HTSomeoneModel *> *)packModelArrayWithUser:(HTUser *)user;

@end
