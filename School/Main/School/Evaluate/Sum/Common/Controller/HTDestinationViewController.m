//
//  HTDestinationViewController.m
//  School
//
//  Created by Charles Cao on 2017/12/6.
//  Copyright © 2017年 hublot. All rights reserved.
//

#import "HTDestinationViewController.h"
#import "HTDestinationCell.h"

@interface HTDestinationViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSArray *countryArray;

@end

@implementation HTDestinationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
	[self loadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loadData{
	HTNetworkModel *networkModel = [HTNetworkModel modelForOnlyCacheNoInterfaceForScrollViewWithCacheStyle:HTCacheStyleAllUser];
	[HTRequestManager requestSchoolMatriculateCountryListAndMajorListWithNetworkModel:networkModel complete:^(id response, HTError *errorModel) {
		if (errorModel.existError) {
			
		}
		HTMatriculateDynamicModel *model = [HTMatriculateDynamicModel mj_objectWithKeyValues:response];
		self.countryArray = model.country;
		if (self.selectedCountryID) {
			[self.countryArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
				HTMatriculateCountryModel *country = (HTMatriculateCountryModel*)obj;
				if ([country.ID isEqualToString:self.selectedCountryID]) {
					country.isSelected = YES;
					*stop = YES;
				}
			}];
		}
		[self.tableView reloadData];
	}];
}

#pragma mark -UITableViewDataSource


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return self.countryArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	HTDestinationCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HTDestinationCell"];
	HTSchoolMatriculateSelectedModel *selectedModel = self.countryArray[indexPath.row];
	cell.textLabel.textColor = [UIColor ht_colorString:@"525252"];
	cell.textLabel.font = [UIFont systemFontOfSize:14];
	cell.textLabel.text = selectedModel.name;
	cell.accessoryType = selectedModel.isSelected ? UITableViewCellAccessoryCheckmark : UITableViewCellAccessoryNone;
	
	return cell;
}

#pragma mark -UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
	[self.delegate selectedCountryModel:self.countryArray[indexPath.row]];
	[self.navigationController popViewControllerAnimated:YES];
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
