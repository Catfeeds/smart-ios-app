//
//  HTDiscoverItemModel.m
//  School
//
//  Created by hublot on 2017/7/31.
//  Copyright © 2017年 hublot. All rights reserved.
//

#import "HTDiscoverItemModel.h"
#import "HTLibraryApplyController.h"
#import "HTLibraryVideoController.h"
#import "HTLibraryAnalysisController.h"

@implementation HTDiscoverItemModel

+ (NSArray <HTDiscoverItemModel *> *)packModelArray {
	NSString *titleNameKey = @"titleNameKey";
	NSString *imageNameKey = @"imageNameKey";
	NSString *controllerClassKey = @"controllerClassKey";
	NSArray *keyValueArray = @[
								 @{titleNameKey:@"申请前", imageNameKey:@"cn_discover_header_item_before", controllerClassKey:NSStringFromClass([HTLibraryApplyController class])},
								 @{titleNameKey:@"申请中", imageNameKey:@"cn_discover_header_item_ing", controllerClassKey:NSStringFromClass([HTLibraryApplyController class])},
								 @{titleNameKey:@"申请后", imageNameKey:@"cn_discover_header_item_after", controllerClassKey:NSStringFromClass([HTLibraryApplyController class])},
								 @{titleNameKey:@"申请项目视频解析", imageNameKey:@"cn_discover_header_item_video", controllerClassKey:NSStringFromClass([HTLibraryVideoController class])},
								 @{titleNameKey:@"留学规划视频解析", imageNameKey:@"cn_discover_header_item_video", controllerClassKey:NSStringFromClass([HTLibraryAnalysisController class])},
							 ];
	NSMutableArray *modelArray = [@[] mutableCopy];
	[keyValueArray enumerateObjectsUsingBlock:^(NSDictionary *dictionary, NSUInteger index, BOOL * _Nonnull stop) {
		HTDiscoverItemModel *model = [[HTDiscoverItemModel alloc] init];
		model.titleName = dictionary[titleNameKey];
		model.imageName = dictionary[imageNameKey];
		model.controllerClass = NSClassFromString(dictionary[controllerClassKey]);
		[modelArray addObject:model];
	}];
	return modelArray;
}

@end
