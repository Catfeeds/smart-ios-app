//
//  HTSchoolRankModel.h
//  School
//
//  Created by hublot on 2017/9/11.
//  Copyright © 2017年 hublot. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HTSchoolRankModel : NSObject

@property (nonatomic, copy) NSString *ID;

@property (nonatomic, copy) NSString *answer;

@property (nonatomic, copy) NSString *alternatives;

@property (nonatomic, copy) NSString *catId;

@property (nonatomic, copy) NSString *show;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *userId;

@property (nonatomic, copy) NSString *image;

@property (nonatomic, copy) NSString *createTime;

@property (nonatomic, copy) NSString *viewCount;

@property (nonatomic, copy) NSString *article;

@property (nonatomic, copy) NSString *pid;

@property (nonatomic, copy) NSString *sort;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, copy) NSString *fabulous;



@property (nonatomic, copy) NSString *imageName;

@property (nonatomic, assign) UIEdgeInsets titleEdgeInsets;

@property (nonatomic, assign) CGSize imageSize;

@property (nonatomic, strong) UIColor *titleColor;

- (void)reloadModelImageWithIndex:(NSInteger)index;

@end
