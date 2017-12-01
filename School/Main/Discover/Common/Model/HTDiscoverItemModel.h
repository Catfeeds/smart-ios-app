//
//  HTDiscoverItemModel.h
//  School
//
//  Created by hublot on 2017/7/31.
//  Copyright © 2017年 hublot. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HTIndexHeaderCollectionModel.h"

typedef NS_ENUM(NSInteger, HTDiscoverItemType) {
	HTDiscoverItemTypeBeforeApply,
	HTDiscoverItemTypeApplying,
	HTDiscoverItemTypeAfterApply,
	HTDiscoverItemTypeApplyVideo,
};

@interface HTDiscoverItemModel : HTIndexHeaderCollectionModel

@property (nonatomic, assign) Class controllerClass;

@end
