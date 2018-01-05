//
//  HTStudyAbroadSelectorController.m
//  School
//
//  Created by Charles Cao on 2017/12/20.
//  Copyright © 2017年 hublot. All rights reserved.
//

#import "HTStudyAbroadSelectorController.h"

@interface HTStudyAbroadSelectorController ()

@end

@implementation HTStudyAbroadSelectorController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.tableView.tableHeaderView.frame = CGRectMake(0, 0, CGRectGetWidth(self.view.frame), 10);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)reloadDataModels:(NSArray *)models selecetdModelId:(NSString *)selectedModelId{
	
    CGFloat maxHeight = CGRectGetHeight(self.view.frame) / 4.0 * 3.0; //页面四分之三高度
    if ((models.count * 44) > maxHeight) {
        self.tableViewHeightLayoutConstraint.constant = maxHeight;
    }else{
        self.tableViewHeightLayoutConstraint.constant = models.count * 44;
    }
    
	self.models = models;
	self.selectedModelId = selectedModelId;
	[self.tableView reloadData];
}

//tap手势 点击空白处
- (IBAction)tapBlank:(id)sender {
    [self.delegate hiddenSelectorView];
}


#pragma mark -UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return self.models.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
	HTStudyAbroadSelectorModel *selectetorModel = self.models[indexPath.row];
	cell.textLabel.text = selectetorModel.name;
	cell.textLabel.textColor = [UIColor ht_colorString:@"333333"];
	cell.textLabel.font = [UIFont systemFontOfSize:17];
	cell.accessoryType = [self.selectedModelId isEqualToString:selectetorModel.ID] ? UITableViewCellAccessoryCheckmark : UITableViewCellAccessoryNone;
	return cell;
}

#pragma mark -UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	[self.delegate selectedModel:self.models[indexPath.row]];
    [self.delegate hiddenSelectorView];
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
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
