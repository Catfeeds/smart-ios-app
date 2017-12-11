//
//  HTSchoolMatriculateExperienceController.h
//  School
//
//  Created by caoguochi on 2017/12/11.
//  Copyright © 2017年 hublot. All rights reserved.
//

#import "HTSchoolMatriculateController.h"

@interface HTSchoolMatriculateExperienceController : HTSchoolMatriculateController

@property (weak, nonatomic) IBOutlet UITableView *tableView;


@end

@interface WorkExperienceModel : NSObject

@property (nonatomic, strong) NSString *title;
@property (nonatomic, assign) BOOL isSelect;
@property (nonatomic, strong) NSString *key;

@end;
