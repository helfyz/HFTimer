//
//  ViewController.m
//  HFTimerDemo
//
//  Created by helfy on 16/7/9.
//  Copyright © 2016年 helfy. All rights reserved.
//

#import "ViewController.h"
#import <HFLibs.h>
#import <HFKit.h>
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self hft_setupPlainTableViw];
    [self setupData];
}

- (HFTableViewCellModel *)cellModelForTitle:(NSString *)title pushTo:(NSString *)className{
    HFTableViewCellModel*cellModel = [HFTableViewCellModel new];;
    [cellModel setConfigCellBlock:^(UITableViewCell *cell) {
        cell.textLabel.text = title;
    }];
    __weak ViewController *ws = self;
    [cellModel setCellDidSelectBlock:^(UITableViewCell *cell, HFTableViewCellModel *cellModel) {
        [ws hf_pushToViewControllerForName:className];
    }];
    return cellModel;
}
- (HFTableViewSectionModel *)sectionModelWithTitle:(NSString *)title
{
    HFTableViewSectionModel *sectionObj = [[HFTableViewSectionModel alloc] init];
    sectionObj.headHeigth = 30;
    sectionObj.headTitle = title;
    return sectionObj;
}

- (void)setupData
{

    HFTableViewSectionModel *sectionObj = [self sectionModelWithTitle:@"HFTierm"];
    [sectionObj addCellModel:[self cellModelForTitle:@"测试HFTimer" pushTo:@"HFTimerTestViewController"]];
    
    [self.hft_tableViewManger setupDataSourceModels:@[sectionObj] isAddmore:NO];
}
@end
