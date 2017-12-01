//
//  HTMinePreferenceController.m
//  School
//
//  Created by hublot on 17/9/3.
//  Copyright © 2017年 hublot. All rights reserved.
//

#import "HTMinePreferenceController.h"
#import "HTMinePreferenceCell.h"
#import "HTMinePreferenceModel.h"
#import <UITableView+HTSeparate.h>
#import "HTLoginManager.h"
#import "HTUserManager.h"
#import "HTMinePreferenceInputController.h"
#import <HTCacheManager.h>
#import "HTDevicePermissionManager.h"
#import "HTMineFontSizeController.h"
#import "HTNetworkManager+HTNetworkCache.h"
#import "HTAnswerTagController.h"
#import "HTIssueController.h"

@interface HTMinePreferenceController ()

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) UIButton *exitButton;

@end

@implementation HTMinePreferenceController

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initializeDataSource];
    [self initializeUserInterface];
}

- (void)initializeDataSource {
    [self LoginChange];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(LoginChange) name:kHTLoginNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(LoginChange) name:kHTFontChangeNotification object:nil];
}

- (void)initializeUserInterface {
    self.navigationItem.title = @"个人中心";
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.exitButton];
}

- (void)LoginChange {
    [self.tableView ht_updateSection:0 sectionMakerBlock:^(HTTableViewSectionMaker *sectionMaker) {
        sectionMaker.modelArray([HTMinePreferenceModel packUserInformationModelArray]);
    }];
    [self.tableView ht_updateSection:1 sectionMakerBlock:^(HTTableViewSectionMaker *sectionMaker) {
        sectionMaker.modelArray([HTMinePreferenceModel packAppInformationModelArray]);
    }];
	[self.tableView ht_updateSection:2 sectionMakerBlock:^(HTTableViewSectionMaker *sectionMaker) {
		sectionMaker.modelArray([HTMinePreferenceModel packClearModelArray]);
	}];
    self.exitButton.selected = [HTUserManager currentUser].permission < HTUserPermissionExerciseAbleUser;
}

- (void)changeHeadImageWithCell:(UITableViewCell *)cell {
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
    imagePickerController.allowsEditing = true;
    imagePickerController.navigationBar.barTintColor = self.navigationController.navigationBar.barTintColor;
    imagePickerController.navigationBar.tintColor = self.navigationController.navigationBar.tintColor;
    imagePickerController.navigationBar.titleTextAttributes = self.navigationController.navigationBar.titleTextAttributes;
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    __weak typeof(self) weakSelf = self;
    [alertController addAction:[UIAlertAction actionWithTitle:@"拍摄照片" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
        [HTDevicePermissionManager ht_sureDevicePermissionStyle:HTDevicePermissionStyleCamera authorized:^{
            [weakSelf willPresentImagePickerController:imagePickerController];
        } everDenied:^(void (^openUrlBlock)(void)) {
            if (openUrlBlock) {
                [HTAlert title:@"没有相机访问权限哦😲" sureAction:^{
                    openUrlBlock();
                }];
            }
        } nowDenied:^(void (^openUrlBlock)(void)) {
            if (openUrlBlock) {
                [HTAlert title:@"没有相机访问权限哦😲" sureAction:^{
                    openUrlBlock();
                }];
            }
        } restricted:^{
            [HTAlert title:@"没有相机访问权限哦😲" sureAction:^{
                
            }];
        }];
    }]];
    [alertController addAction:[UIAlertAction actionWithTitle:@"选择已有照片" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        [HTDevicePermissionManager ht_sureDevicePermissionStyle:HTDevicePermissionStylePhotos authorized:^{
            [weakSelf willPresentImagePickerController:imagePickerController];
        } everDenied:^(void (^openUrlBlock)(void)) {
            if (openUrlBlock) {
                [HTAlert title:@"没有相册访问权限哦😲" sureAction:^{
                    openUrlBlock();
                }];
            }
        } nowDenied:^(void (^openUrlBlock)(void)) {
            if (openUrlBlock) {
                [HTAlert title:@"没有相册访问权限哦😲" sureAction:^{
                    openUrlBlock();
                }];
            }
        } restricted:^{
            [HTAlert title:@"没有相册访问权限哦😲" sureAction:^{
                
            }];
        }];
    }]];
    [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
    }]];
    UIPopoverPresentationController *popover = alertController.popoverPresentationController;
    if (popover) {
        popover.sourceView = cell;
        popover.sourceRect = cell.bounds;
    }
    [self presentViewController:alertController animated:true completion:nil];
}

- (void)willPresentImagePickerController:(UIImagePickerController *)imagePickerController {
    [imagePickerController setBk_didFinishPickingMediaBlock:^(UIImagePickerController *imagePickerController, NSDictionary *dictionary) {
        UIImage *image = dictionary[UIImagePickerControllerEditedImage];
        NSData *imageData = UIImageJPEGRepresentation(image, 1);
        HTNetworkModel *networkModel = [[HTNetworkModel alloc] init];
        networkModel.autoAlertString = @"更新用户信息中";
        networkModel.offlineCacheStyle = HTCacheStyleNone;
        networkModel.autoShowError = true;
        
        HTUploadModel *uploadModel = [[HTUploadModel alloc] init];
        uploadModel.uploadData = imageData;
        uploadModel.uploadType = HTUploadFileDataTypeJpg;
        networkModel.uploadModelArray = @[uploadModel];
        [HTRequestManager requestUploadUserHeadImageWithNetworkModel:networkModel complete:^(id response, HTError *errorModel) {
            if (errorModel.existError) {
                return;
            }
            [imagePickerController dismissViewControllerAnimated:true completion:nil];
            [HTUserManager updateUserDetailComplete:^(BOOL success) {
                if (!success) {
                    [HTAlert title:@"更新用户信息失败"];
                }
            }];
        }];
    }];
    [imagePickerController setBk_didCancelBlock:^(UIImagePickerController *imagePickerController) {
        [imagePickerController dismissViewControllerAnimated:true completion:^{
            
        }];
    }];
    [self presentViewController:imagePickerController animated:true completion:nil];
}

- (void)changeInputDetailWithRow:(NSInteger)row {
    HTMinePreferenceInputController *inputController = [[HTMinePreferenceInputController alloc] init];
    inputController.type = row;
    [self.navigationController pushViewController:inputController animated:true];
}

- (void)tableSelectedBlockWithTableView:(UITableView *)tableView cell:(UITableViewCell *)cell model:(HTMinePreferenceModel *)model {
    UIViewController *viewController;
    switch (model.dataSourceType) {
        case HTMinePreferenceModelDataSourceTypeDetail: {
            
            break;
        }
        case HTMinePreferenceModelDataSourceTypeHeadImage: {
            [self changeHeadImageWithCell:cell];
            break;
        }
        case HTMinePreferenceModelDataSourceTypeNickname: {
            [self changeInputDetailWithRow:HTMinePreferenceInputTypeName];
            break;
        }
        case HTMinePreferenceModelDataSourceTypePhoneCode: {
            [self changeInputDetailWithRow:HTMinePreferenceInputTypePhone];
            break;
        }
        case HTMinePreferenceModelDataSourceTypeEmailCode: {
            [self changeInputDetailWithRow:HTMinePreferenceInputTypeEmail];
            break;
        }
        case HTMinePreferenceModelDataSourceTypePassword: {
            [self changeInputDetailWithRow:HTMinePreferenceInputTypePassword];
            break;
        }
        case HTMinePreferenceModelDataSourceTypeAnswerTag: {
            HTAnswerTagController *tagController = [[HTAnswerTagController alloc] init];
            viewController = tagController;
            break;
        }
        case HTMinePreferenceModelDataSourceTypeIssue: {
            HTIssueController *issueController = [[HTIssueController alloc] init];
            viewController = issueController;
            break;
        }
        case HTMinePreferenceModelDataSourceTypeStar: {
            [HTRequestManager requestOpenAppStore];
            break;
        }
        case HTMinePreferenceModelDataSourceTypeClearCache: {
            [HTAlert showProgress];
            [HTCacheManager ht_clearCacheComplete:^{
                [HTAlert hideProgress];
                HTMinePreferenceCell *subCell = (HTMinePreferenceCell *)cell;
                HTMinePreferenceModel *subModel = (HTMinePreferenceModel *)model;
                subModel.detailName = @"0.0M";
                subCell.detailNameLabel.text = subModel.detailName;
            }];
            break;
        }
    }
    if (viewController) {
        [self.navigationController pushViewController:viewController animated:true];
    }
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.ht_w, self.view.ht_h - 49) style:UITableViewStyleGrouped];
        _tableView.separatorColor = [UIColor ht_colorStyle:HTColorStyleCompareBackground];
        __weak typeof(self) weakSelf = self;
        [_tableView ht_updateSection:0 sectionMakerBlock:^(HTTableViewSectionMaker *sectionMaker) {
            [sectionMaker.cellClass([HTMinePreferenceCell class]) didSelectedCellBlock:^(UITableView *tableView, NSInteger row, UITableViewCell *cell, HTMinePreferenceModel *model) {
                [weakSelf tableSelectedBlockWithTableView:tableView cell:cell model:model];
            }];
        }];
        [_tableView ht_updateSection:1 sectionMakerBlock:^(HTTableViewSectionMaker *sectionMaker) {
            [sectionMaker.cellClass([HTMinePreferenceCell class])
             .rowHeight(HTADAPT568(45))
             .headerHeight(15)
             .footerHeight(20) didSelectedCellBlock:^(UITableView *tableView, NSInteger row, UITableViewCell *cell, id model) {
                 [weakSelf tableSelectedBlockWithTableView:tableView cell:cell model:model];
             }];
        }];
		[_tableView ht_updateSection:2 sectionMakerBlock:^(HTTableViewSectionMaker *sectionMaker) {
			[sectionMaker.cellClass([HTMinePreferenceCell class]) didSelectedCellBlock:^(UITableView *tableView, NSInteger row, UITableViewCell *cell, HTMinePreferenceModel *model) {
				[weakSelf tableSelectedBlockWithTableView:tableView cell:cell model:model];
			}];
		}];
    }
    return _tableView;
}

- (UIButton *)exitButton {
    if (!_exitButton) {
        _exitButton = [[UIButton alloc] initWithFrame:CGRectMake(0, self.view.ht_h - 49, self.view.ht_w, 49)];
        _exitButton.titleLabel.font = [UIFont systemFontOfSize:15];
        [_exitButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        UIColor *normalBackgroundColor = [UIColor ht_colorStyle:HTColorStyleTintColor];
        UIColor *highlightBackgroundColor = [normalBackgroundColor colorWithAlphaComponent:0.5];
        [_exitButton setBackgroundImage:[UIImage ht_pureColor:normalBackgroundColor] forState:UIControlStateNormal];
        [_exitButton setBackgroundImage:[UIImage ht_pureColor:highlightBackgroundColor] forState:UIControlStateHighlighted];
		[_exitButton setTitle:@"退出当前账户" forState:UIControlStateNormal];
        [_exitButton setTitle:@"退出当前账户" forState:UIControlStateNormal | UIControlStateHighlighted];
		[_exitButton setTitle:@"马上登录" forState:UIControlStateSelected];
        [_exitButton setTitle:@"马上登录" forState:UIControlStateSelected | UIControlStateHighlighted];
        __weak typeof(self) weakSelf = self;
        [_exitButton ht_whenTap:^(UIView *view) {
            if (weakSelf.exitButton.selected) {
                [HTLoginManager presentAndLoginSuccess:nil];
            } else {
                [HTAlert title:@"确定要退出本次登录吗" sureAction:^{
                    [HTLoginManager exitLoginWithComplete:^{
                        [weakSelf.navigationController popViewControllerAnimated:true];
                    }];
                }];
            }
        }];
    }
    return _exitButton;
}

@end
