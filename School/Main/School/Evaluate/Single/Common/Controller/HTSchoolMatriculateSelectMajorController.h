//
//  HTSchoolMatriculateSelectMajorController.h
//  School
//
//  Created by Charles Cao on 2017/12/11.
//  Copyright © 2017年 hublot. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HTSchoolModel.h"

@protocol HTSelectMajorDelegate <NSObject>

- (void)selectedMajor:(HTSchoolProfessionalModel *)major;

@end

@interface HTSchoolMatriculateSelectMajorController : UIViewController

@property (nonatomic, assign) id<HTSelectMajorDelegate>delegate;
@property (nonatomic, strong) NSArray<HTSchoolProfessionalModel *> *majorArray;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end
