//
//  HTSchoolRankFilterView.h
//  School
//
//  Created by hublot on 2017/9/11.
//  Copyright © 2017年 hublot. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HTSchoolRankFilterModel.h"

typedef void(^HTFilterDidChangeBlock)(void);

@interface HTSchoolRankFilterView : UIView

- (void)reloadRankFilterHeight;

@property (nonatomic, copy) HTFilterDidChangeBlock filterDidChange;

- (NSString *)findSelectedModelIdWithType:(HTSchoolRankFilterType)type;


- (void)requestFilterClassComplete:(HTUserTaskCompleteBlock)complete;

@property (nonatomic, assign) BOOL isReloadClassSuccess;

@end
