//
//  YLLetfViewController.m
//  YLPrivateFinancialManagement
//
//  Created by 千锋 on 16/1/23.
//  Copyright (c) 2016年 mobiletrain. All rights reserved.
//

#import "YLLetfViewController.h"
#import "YLAboutUsViewController.h"
#import "YLCostModelSetViewController.h"
#import "YLRESideViewController.h"
#import "YLSonOfCostModelSetViewController.h"
#import "YLDataManagerViewController.h"
@interface YLLetfViewController ()

@end

@implementation YLLetfViewController
- (IBAction)costModelSet:(UIButton *)sender {
   YLSonOfCostModelSetViewController *costModelSetVC=[[YLSonOfCostModelSetViewController alloc ]init];
    UINavigationController * navi=[[UINavigationController alloc]initWithRootViewController:costModelSetVC];
    [self presentViewController:navi animated:YES completion:nil];
}
- (IBAction)getModelSet:(UIButton *)sender {
    YLRESideViewController *getModelSetVC=[[YLRESideViewController alloc]init];
    [self presentViewController:getModelSetVC animated:YES completion:nil];
}
- (IBAction)aboutUsAction:(UIButton *)sender {
    YLAboutUsViewController *aboutUsVC=[[YLAboutUsViewController alloc]init];
    [self presentViewController:aboutUsVC animated:YES completion:nil];
    
    
    
}
- (IBAction)dataManagerButtonClieked:(UIButton *)sender {
    YLDataManagerViewController *costModelSetVC=[[YLDataManagerViewController alloc ]init];
    UINavigationController * navi=[[UINavigationController alloc]initWithRootViewController:costModelSetVC];
    [self presentViewController:navi animated:YES completion:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
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
