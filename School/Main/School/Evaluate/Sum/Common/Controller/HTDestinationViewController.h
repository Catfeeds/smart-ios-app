//
//  HTDestinationViewController.h
//  School
//
//  Created by Charles Cao on 2017/12/6.
//  Copyright © 2017年 hublot. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HTMatriculateDynamicModel.h"

@protocol HTDestinationViewControllerDelegate <NSObject>

- (void)selectedCountryModel:(HTSchoolMatriculateSelectedModel *) country;

@end

@interface HTDestinationViewController : UIViewController

@property (nonatomic, assign) id<HTDestinationViewControllerDelegate> delegate;
@property (nonatomic, strong) NSString *selectedCountryID;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end
