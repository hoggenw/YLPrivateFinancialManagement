//
//  YLRESideViewController.m
//  YLPrivateFinancialManagement
//
//  Created by 千锋 on 16/1/25.
//  Copyright (c) 2016年 mobiletrain. All rights reserved.
//

#import "YLRESideViewController.h"

@interface YLRESideViewController ()

@end

@implementation YLRESideViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIButton *button=[UIButton buttonWithType:UIButtonTypeCustom];
    button.frame=CGRectMake(20, 24, 60, 40);
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.view addSubview:button];
    [button setTitle:@"返回" forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:@"button_barbar"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(rebackButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    
}
-(void)rebackButtonAction:(UIButton *)sernder{
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
