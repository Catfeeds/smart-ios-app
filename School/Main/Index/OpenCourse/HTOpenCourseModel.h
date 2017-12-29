//
//  HTOpenCourseModel.h
//  School
//
//  Created by Charles Cao on 2017/12/22.
//  Copyright © 2017年 hublot. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HTOpenCourseModel : NSObject

@property (nonatomic, strong) NSString *ID;
@property (nonatomic, strong) NSString *image;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *cnName;
@property (nonatomic, strong) NSString *problemComplement;
@property (nonatomic, strong) NSString *viewCount;
@property (nonatomic, strong) NSString *alternatives;

@end
