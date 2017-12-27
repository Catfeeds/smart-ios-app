//
//  HTLikeModel.h
//  School
//
//  Created by hublot on 17/9/3.
//  Copyright © 2017年 hublot. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HTLikeModel : NSObject

@property (nonatomic, copy) NSString *uid;

@property (nonatomic, copy) NSString *image;
@property (nonatomic, strong) NSString *followUser;
@property (nonatomic, copy) NSString *username;

@property (nonatomic, copy) NSString *nickname;

@property (nonatomic, assign) BOOL boolean;

@end
