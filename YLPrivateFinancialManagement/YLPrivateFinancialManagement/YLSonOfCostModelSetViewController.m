//
//  YLSonOfCostModelSetViewController.m
//  YLPrivateFinancialManagement
//
//  Created by 千锋 on 16/1/25.
//  Copyright (c) 2016年 mobiletrain. All rights reserved.
//

#import "YLSonOfCostModelSetViewController.h"

@interface YLSonOfCostModelSetViewController ()

@end

@implementation YLSonOfCostModelSetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self customTabBarButtonTitle:@"返回" image:@"button_barbar" target:self action:@selector(onLeftClicked:)  isLeft:YES];
}
-(void)onLeftClicked:(UIButton*)sender{
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
