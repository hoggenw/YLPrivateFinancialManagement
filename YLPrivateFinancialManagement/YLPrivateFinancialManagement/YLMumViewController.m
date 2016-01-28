//
//  YLMumViewController.m
//  YLPrivateFinancialManagement
//
//  Created by 千锋 on 16/1/11.
//  Copyright (c) 2016年 mobiletrain. All rights reserved.
//

#import "YLMumViewController.h"
#import "YLRightViewController.h"

@interface YLMumViewController ()

@end

@implementation YLMumViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    //设置导航栏
    self.title=@"旺旺记账";
    self.view.backgroundColor=[UIColor whiteColor];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"navi_back"] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[UIImage imageNamed:@"navi_back"]];
    
    
    [self customTabBarButtonTitle:@"设置" image:@"button_barbar" target:self action:@selector(onLeftClicked:)  isLeft:YES];
    [self customTabBarButtonTitle:@"消息" image:@"button_barbar" target:self action:@selector(onRightClicked:)  isLeft:NO];
}
-(void)onLeftClicked:(UIButton*)sender{
     [self.sideMenuViewController presentLeftMenuViewController];
}
-(void)onRightClicked:(UIButton*)sender{
    YLRightViewController *rightVc=[[YLRightViewController alloc]init];
    [self.navigationController pushViewController:rightVc animated:YES];

}
-(void)customTabBarButtonTitle:(NSString *)title image:(NSString *)imageName target:(id)taget action:(SEL)selector isLeft:(BOOL)isLeft{
    UIButton *button=[UIButton buttonWithType:UIButtonTypeSystem];
    [button setBackgroundImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [button setTitle:title forState:UIControlStateNormal];
    [button addTarget:taget action:selector forControlEvents:UIControlEventTouchDown];
    button.frame=CGRectMake(0, 0, 68, 35);
    button.layer.cornerRadius=5;
    button.clipsToBounds=YES;
    button.titleLabel.font=[UIFont boldSystemFontOfSize:22];
    //判断是否为左侧按钮
    UIBarButtonItem *buttonItem=[[UIBarButtonItem alloc]initWithCustomView:button];
    if (isLeft) {
        self.navigationItem.leftBarButtonItem=buttonItem;
    }else{
        self.navigationItem.rightBarButtonItem=buttonItem;
    }
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
