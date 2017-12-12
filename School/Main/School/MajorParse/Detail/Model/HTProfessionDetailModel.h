//
//  HTProfessionDetailModel.h
//  School
//
//  Created by caoguochi on 2017/12/11.
//  Copyright © 2017年 hublot. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HTProfessionSchoolModel : NSObject

@property (nonatomic, strong) NSString *ID;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *duration;
@property (nonatomic, strong) NSString *article;

@end

@interface HTProfessionModel : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *url;
@property (nonatomic, strong) NSString *deadline;
@property (nonatomic, strong) NSString *catDirection;

@end

@interface HTProfessionDetailModel : NSObject

@property (nonatomic, strong) HTProfessionModel *profession;
@property (nonatomic, strong) HTProfessionSchoolModel *school;

@end

