//
//  HTLibraryModel.h
//  School
//
//  Created by hublot on 2017/8/15.
//  Copyright © 2017年 hublot. All rights reserved.
//

#import <Foundation/Foundation.h>

@class HTLibraryApplyTypeModel,HTLibraryApplyHeaderModel,HTLibraryApplyContentModel,HTLibrarySchoolVideoModel,HTLibraryProjectVideoHeaderModel,HTLibraryProjectVideoContentModel;

@interface HTLibraryModel : NSObject

@property (nonatomic, strong) NSArray<HTLibraryApplyTypeModel *> *apply;

@property (nonatomic, strong) NSArray<HTLibrarySchoolVideoModel *> *videoAnalysis;

@property (nonatomic, strong) NSArray<HTLibraryProjectVideoHeaderModel *> *applyVideo;

@end
@interface HTLibraryApplyTypeModel : NSObject

@property (nonatomic, copy) NSString *ID;

@property (nonatomic, copy) NSString *Description;

@property (nonatomic, copy) NSString *secondClass;

@property (nonatomic, copy) NSString *isShow;

@property (nonatomic, copy) NSString *sort;

@property (nonatomic, copy) NSString *Relatedcatid;

@property (nonatomic, copy) NSString *userId;

@property (nonatomic, copy) NSString *image;

@property (nonatomic, copy) NSString *createTime;

@property (nonatomic, strong) NSArray<HTLibraryApplyHeaderModel *> *child;

@property (nonatomic, copy) NSString *pid;

@property (nonatomic, copy) NSString *can;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, copy) NSString *isMajor;

@end

@interface HTLibraryApplyHeaderModel : NSObject

@property (nonatomic, copy) NSString *ID;

@property (nonatomic, copy) NSString *Description;

@property (nonatomic, copy) NSString *secondClass;

@property (nonatomic, copy) NSString *isShow;

@property (nonatomic, copy) NSString *sort;

@property (nonatomic, copy) NSString *Relatedcatid;

@property (nonatomic, copy) NSString *userId;

@property (nonatomic, copy) NSString *image;

@property (nonatomic, copy) NSString *createTime;

@property (nonatomic, strong) NSArray<HTLibraryApplyContentModel *> *data;

@property (nonatomic, copy) NSString *pid;

@property (nonatomic, copy) NSString *can;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, copy) NSString *isMajor;

@end

@interface HTLibraryApplyContentModel : NSObject

@property (nonatomic, copy) NSString *ID;

@property (nonatomic, copy) NSString *catId;

@property (nonatomic, copy) NSString *show;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *userId;

@property (nonatomic, copy) NSString *image;

@property (nonatomic, copy) NSString *createTime;

@property (nonatomic, copy) NSString *viewCount;

@property (nonatomic, copy) NSString *catName;

@property (nonatomic, copy) NSString *pid;

@property (nonatomic, copy) NSString *sort;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, copy) NSString *fabulous;

@property (nonatomic, copy) NSString *answer;

@end

@interface HTLibrarySchoolVideoModel : NSObject

@property (nonatomic, copy) NSString *ID;

@property (nonatomic, copy) NSString *duration;

@property (nonatomic, copy) NSString *catId;

@property (nonatomic, copy) NSString *show;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *userId;

@property (nonatomic, copy) NSString *image;

@property (nonatomic, copy) NSString *createTime;

@property (nonatomic, copy) NSString *viewCount;

@property (nonatomic, copy) NSString *catName;

@property (nonatomic, copy) NSString *pid;

@property (nonatomic, copy) NSString *sort;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, copy) NSString *fabulous;

@property (nonatomic, copy) NSString *url;

@end

@interface HTLibraryProjectVideoHeaderModel : NSObject

@property (nonatomic, copy) NSString *ID;

@property (nonatomic, copy) NSString *Description;

@property (nonatomic, copy) NSString *secondClass;

@property (nonatomic, copy) NSString *isShow;

@property (nonatomic, copy) NSString *sort;

@property (nonatomic, copy) NSString *Relatedcatid;

@property (nonatomic, copy) NSString *userId;

@property (nonatomic, copy) NSString *image;

@property (nonatomic, copy) NSString *createTime;

@property (nonatomic, strong) NSArray<HTLibraryProjectVideoContentModel *> *data;

@property (nonatomic, copy) NSString *pid;

@property (nonatomic, copy) NSString *can;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, copy) NSString *isMajor;

@end

@interface HTLibraryProjectVideoContentModel : NSObject

@property (nonatomic, copy) NSString *ID;

@property (nonatomic, copy) NSString *duration;

@property (nonatomic, copy) NSString *catId;

@property (nonatomic, copy) NSString *show;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *userId;

@property (nonatomic, copy) NSString *image;

@property (nonatomic, copy) NSString *createTime;

@property (nonatomic, copy) NSString *viewCount;

@property (nonatomic, copy) NSString *catName;

@property (nonatomic, copy) NSString *pid;

@property (nonatomic, copy) NSString *sort;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, copy) NSString *fabulous;

@property (nonatomic, copy) NSString *url;

@end

