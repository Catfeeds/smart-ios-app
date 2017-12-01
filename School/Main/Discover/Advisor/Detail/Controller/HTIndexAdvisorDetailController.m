//
//  HTIndexAdvisorDetailController.m
//  School
//
//  Created by hublot on 17/9/2.
//  Copyright © 2017年 hublot. All rights reserved.
//

#import "HTIndexAdvisorDetailController.h"
#import "HTWebController.h"
#import "HTIndexAdvisorDetailModel.h"
#import "HTAdvisorDetailInformationController.h"
#import "HTAdvisorDetailAnswerController.h"
#import "HTAdvisorDetailHeaderView.h"

@interface HTIndexAdvisorDetailController ()

@property (nonatomic, strong) UIButton *contactAdvisorButton;

@property (nonatomic, strong) HTIndexAdvisorDetailModel *model;

@property (nonatomic, strong) HTAdvisorDetailHeaderView *headerView;

@end

@implementation HTIndexAdvisorDetailController

- (void)loadView {
    self.view = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initializeDataSource];
    [self initializeUserInterface];
}

- (void)initializeDataSource {
    
    __weak typeof(self) weakSelf = self;
    self.magicView.sliderHeight = 1 / [UIScreen mainScreen].scale;
    self.magicView.sliderColor = [UIColor ht_colorStyle:HTColorStyleTintColor];
    self.magicView.headerHidden = false;
    self.magicView.headerHeight = self.headerView.ht_h;
    [self.magicView.headerView addSubview:self.headerView];
    NSArray *titleArray = @[@"顾问介绍", @"TA 的回答"];
    NSArray *controllerClassArray = @[NSStringFromClass([HTAdvisorDetailInformationController class]), NSStringFromClass([HTAdvisorDetailAnswerController class])];
    
    NSMutableArray *pageModelArray = [@[] mutableCopy];
    [titleArray enumerateObjectsUsingBlock:^(NSString *titleName, NSUInteger index, BOOL * _Nonnull stop) {
        HTPageModel *pageModel = [[HTPageModel alloc] init];
        pageModel.selectedTitle = titleName;
        pageModel.reuseControllerClass = NSClassFromString(controllerClassArray[index]);
        [pageModelArray addObject:pageModel];
    }];
    self.pageModelArray = pageModelArray;
    [self setModelArrayBlock:^(NSString *pageIndex, NSString *pageCount, NSString *currentPage, void (^modelArrayStatus)(NSArray <NSString *> *, HTError *)) {
        if (currentPage.integerValue > 1) {
            modelArrayStatus(@[], nil);
            return;
        }
        if (!weakSelf.model) {
            HTNetworkModel *networkModel = [HTNetworkModel modelForOnlyCacheNoInterfaceForScrollViewWithCacheStyle:HTCacheStyleAllUser];
            [HTRequestManager requestAdvisorDetailWithNetworkModel:networkModel advisorIdString:weakSelf.advisorIdString complete:^(id response, HTError *errorModel) {
                if (errorModel.existError) {
                    modelArrayStatus(nil, errorModel);
                    return;
                }
                HTIndexAdvisorDetailModel *model = [HTIndexAdvisorDetailModel mj_objectWithKeyValues:response];
                weakSelf.model = model;
				weakSelf.navigationItem.title = model.data.firstObject.name;
                [weakSelf.headerView setModel:model];
                NSArray *modelArray = [weakSelf filterArrayFromModel:model index:pageIndex.integerValue];
                modelArrayStatus(modelArray, nil);
            }];
        } else {
            NSArray *modelArray = [weakSelf filterArrayFromModel:weakSelf.model index:pageIndex.integerValue];
            modelArrayStatus(modelArray, nil);
        }
    }];
    [self.magicView reloadData];
}

- (void)magicView:(VTMagicView *)magicView viewDidAppear:(__kindof HTReuseController *)viewController atPage:(NSUInteger)pageIndex {
    UITableView *tableView = viewController.tableView;
    
    __weak typeof(self) weakSelf = self;
    [tableView ht_updateSection:0 sectionMakerBlock:^(HTTableViewSectionMaker *sectionMaker) {
        [sectionMaker willEndDraggingBlock:^(UIScrollView *scrollView, CGPoint contentOffSet, UIEdgeInsets contentInSet, CGPoint velocity, CGPoint targetContentOffSet) {
            if (velocity.y > 0.3) {
                if (!weakSelf.magicView.headerHidden) {
                    [weakSelf.magicView setHeaderHidden:true duration:0.4];
                }
            } else if (targetContentOffSet.y < 0 || velocity.y < - 1) {
                if (weakSelf.magicView.headerHidden) {
                    [weakSelf.magicView setHeaderHidden:false duration:0.4];
                }
            }
        }];
    }];
    
    [super magicView:magicView viewDidAppear:viewController atPage:pageIndex];
}

- (NSArray *)filterArrayFromModel:(HTIndexAdvisorDetailModel *)model index:(NSInteger)index {
    NSArray *modelArray = @[];
    switch (index) {
        case 0: {
            modelArray = model.data.firstObject.answer ? @[model.data.firstObject.answer] : @[];
            break;
        }
        case 1: {
			modelArray = model.answer;
            break;
        }
        default:
            break;
    }
    return modelArray;
}

- (void)initializeUserInterface {
    self.navigationItem.title = @"顾问详情";
    [self.view addSubview:self.magicView];
    [self.view addSubview:self.contactAdvisorButton];
    [self.contactAdvisorButton mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(self.view);
        make.height.mas_equalTo(49);
    }];
    [self.magicView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.mas_equalTo(self.view);
        make.bottom.mas_equalTo(self.contactAdvisorButton.mas_top);
    }];
}

- (HTAdvisorDetailHeaderView *)headerView {
    if (!_headerView) {
        _headerView = [[HTAdvisorDetailHeaderView alloc] initWithFrame:CGRectMake(0, 0, HTSCREENWIDTH, 220)];
    }
    return _headerView;
}


- (UIButton *)contactAdvisorButton {
    if (!_contactAdvisorButton) {
        _contactAdvisorButton = [[UIButton alloc] init];
        [_contactAdvisorButton setTitle:@"预约咨询" forState:UIControlStateNormal];
        _contactAdvisorButton.titleLabel.font = [UIFont systemFontOfSize:15];
        [_contactAdvisorButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        UIColor *normalColor = [UIColor ht_colorStyle:HTColorStyleTintColor];
        UIColor *highlightColor = [normalColor colorWithAlphaComponent:0.5];
        [_contactAdvisorButton setBackgroundImage:[UIImage ht_pureColor:normalColor] forState:UIControlStateNormal];
        [_contactAdvisorButton setBackgroundImage:[UIImage ht_pureColor:highlightColor] forState:UIControlStateHighlighted];
        
        __weak typeof(self) weakSelf = self;
        [_contactAdvisorButton ht_whenTap:^(UIView *view) {
            HTWebController *webController = [HTWebController contactAdvisorWebController];
            [weakSelf.navigationController pushViewController:webController animated:true];
        }];
    }
    return _contactAdvisorButton;
}


@end
