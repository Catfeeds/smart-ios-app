//
//  HTBroadCastModel.h
//  School
//
//  Created by hublot on 2017/6/14.
//  Copyright © 2017年 hublot. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSString *const kHTBroadCastImage64Key;

@interface HTBroadCastModel : NSObject

@property (nonatomic, copy) NSString *word;

@property (nonatomic, assign) BOOL judge;

@property (nonatomic, copy) NSString *image;

@property (nonatomic, copy) NSString *url;

@property (nonatomic, assign) NSInteger time;

@property (nonatomic, strong) NSString *ht_image_64;

@end
