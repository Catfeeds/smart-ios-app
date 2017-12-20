//
//  HTStudyAbroadSelectorController.h
//  School
//
//  Created by Charles Cao on 2017/12/20.
//  Copyright © 2017年 hublot. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HTStudyAbroadModel.h"

@protocol HTSelectorDelegate <NSObject>

- (void)selectedModel:(HTStudyAbroadSelectorModel *)selectedMoel;


@end

@interface HTStudyAbroadSelectorController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSString *selectedModelId;
@property (nonatomic, strong) NSArray *models;
@property (nonatomic, assign) id<HTSelectorDelegate> delegate;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

- (void)reloadDataModels:(NSArray *)models selecetdModelId:(NSString *)selectedModelId;

@end
