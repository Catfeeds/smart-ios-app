//
//  HTUser.h
//  School
//
//  Created by hublot on 2017/6/14.
//  Copyright © 2017年 hublot. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, HTUserPermission) {
	HTUserPermissionExerciseAbleVisitor,
	HTUserPermissionExerciseAbleUser,
};

@interface HTUser : NSObject

@property (nonatomic, assign) HTUserPermission permission;


@property (nonatomic, copy) NSString *uid;



//@property (nonatomic, copy) NSString *username;

@property (nonatomic, copy) NSString *password;


@property (nonatomic, copy) NSString *openId;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, copy) NSString *iconUrl;



@property (nonatomic, assign) NSInteger storeCount;


@property (nonatomic, copy) NSString *ID;

@property (nonatomic, copy) NSString *major;

@property (nonatomic, copy) NSString *phone;

@property (nonatomic, copy) NSString *school;

@property (nonatomic, copy) NSString *userPass;

@property (nonatomic, copy) NSString *visitUrl;

@property (nonatomic, copy) NSString *userName;

@property (nonatomic, copy) NSString *createTime;

@property (nonatomic, copy) NSString *image;

@property (nonatomic, copy) NSString *remark;

@property (nonatomic, copy) NSString *nickname;

@property (nonatomic, copy) NSString *grade;

@property (nonatomic, copy) NSString *email;

@property (nonatomic, copy) NSString *follow;

@property (nonatomic, copy) NSString *fans;

@property (nonatomic, copy) NSString *questionNum;

@property (nonatomic, copy) NSString *answerNum;





@property (nonatomic, assign) BOOL boolean;

@end
