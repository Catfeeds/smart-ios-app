//
//  HTChooseMajorViewController.h
//  School
//
//  Created by Charles Cao on 2017/12/4.
//  Copyright © 2017年 hublot. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HTMatriculateDynamicModel.h"

typedef NS_ENUM(NSUInteger, HTMajorType) {
	HTMajorFirstType,
	HTMajorSecondType
	
};

@protocol HTChooseMajorViewControllerDelegate <NSObject>

//所选专业  majorModel第一层专业  detailMajor详细专业
- (void)chooseMajor:(HTSchoolMatriculateSelectedModel *)majorModel detailMajor:(HTSchoolMatriculateSelectedModel *)detailMajor;

@end

@interface HTChooseMajorViewController : UIViewController

@property (nonatomic, assign) id<HTChooseMajorViewControllerDelegate> delegate;
@property (nonatomic, assign)HTMajorType type;
@property (nonatomic, strong)NSArray *majorArray;
@property (nonatomic, strong) HTMatriculateMajorModel *selectMajorModel;

@end
