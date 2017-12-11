//
//  HTProfessionDetailController.m
//  School
//
//  Created by caoguochi on 2017/12/11.
//  Copyright © 2017年 hublot. All rights reserved.
//

#import "HTProfessionDetailController.h"
#import "HTProfessionDetailCell.h"
#import "HTRequestManager.h"
#import "HTProfessionDetailModel.h"
#import "HTMajorSectionHeaderView.h"
#import "HTSchoolController.h"


#define headerIdentifier @"HTMajorSectionHeaderView"

@interface HTProfessionDetailController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) HTProfessionDetailModel *detailModel;

@end

@implementation HTProfessionDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self loadData];
}

- (void)loadInterface{
    self.navigationItem.title = self.detailModel.profession.name;
    [self.tableView registerClass:[HTMajorSectionHeaderView class] forHeaderFooterViewReuseIdentifier:headerIdentifier];
    [self.headerImageView sd_setImageWithURL:[NSURL URLWithString:SchoolResourse(self.detailModel.school.duration)] placeholderImage:HTPLACEHOLDERIMAGE];
    self.titleLabel.text = self.detailModel.profession.title;
    self.nameLabel.text = self.detailModel.profession.name;
    NSString *schoolName  =[NSString stringWithFormat:@"   %@>   ",self.detailModel.school.name];
    [self.schoolButton setTitle:schoolName forState:UIControlStateNormal];
    self.schoolButton.layer.borderColor = [UIColor whiteColor].CGColor;
    self.tableView.tableHeaderView.frame = CGRectMake(0, 0, HTSCREENWIDTH, 136);
}

- (void)loadData{
    HTNetworkModel *networkModel = [HTNetworkModel modelForOnlyCacheNoInterfaceForScrollViewWithCacheStyle:HTCacheStyleAllUser];
    [HTRequestManager requestProfessionalWithNetworkModel:networkModel professionalId:self.professionalId complete:^(id response, HTError *errorModel) {
        if (errorModel.errorString) {
            return;
        }
        
        self.detailModel = [HTProfessionDetailModel mj_objectWithKeyValues:response];
        [self loadInterface];
        [self.tableView reloadData];
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return section == 0 ? 4 : 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    HTProfessionDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HTProfessionDetailCell"];
    if (indexPath.section == 0) {
        NSMutableAttributedString *attributeString;
        if (indexPath.row == 0) {
            NSString *tempStr = [NSString stringWithFormat:@"%@( %@ )",self.detailModel.profession.name,self.detailModel.profession.title];
            attributeString = [self loadCellAttributeString:@"项目名称" detailStr:tempStr];
        }else if (indexPath.row == 1){
            attributeString = [self loadCellAttributeString:@"项目排名" detailStr:@"不晓得啊"];
        }else if (indexPath.row == 2){
            attributeString = [self loadCellAttributeString:@"项目网址" detailStr:self.detailModel.profession.url];
        }else if (indexPath.row == 3){
            attributeString = [self loadCellAttributeString:@"截止日期" detailStr:self.detailModel.profession.deadline];
        }
        
        cell.descriptionLabel.attributedText = attributeString;
        
    }else{
        
        cell.descriptionLabel.text = cell.detailTextLabel.text = self.detailModel.profession.catDirection;
    }
    return cell;
}

#pragma mark - UITableViewDelegate


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 40;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    HTMajorSectionHeaderView *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:headerIdentifier];
    [header setTitleName:section == 0 ? @"专业介绍" :@"专业详情"];
    return header;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark -
- (NSMutableAttributedString *)loadCellAttributeString:(NSString *)title detailStr:(NSString *)detailStr{
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@ : %@",title,detailStr]];
    [str addAttribute:NSForegroundColorAttributeName value:[UIColor ht_colorString:@"818181"] range:NSMakeRange(0, str.length)];
    [str addAttribute:NSForegroundColorAttributeName value:[UIColor ht_colorString:@"98BC36"] range:NSMakeRange(0, title.length + 2)];
    return str;
}

- (IBAction)pushToSchool:(id)sender {
    HTSchoolController *detailController = [[HTSchoolController alloc] init];
    detailController.schoolIdString = self.detailModel.school.ID;
    [self.navigationController pushViewController:detailController animated:YES];
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
