//
//  YLCostViewController.m
//  YLPrivateFinancialManagement
//
//  Created by 千锋 on 16/1/11.
//  Copyright (c) 2016年 mobiletrain. All rights reserved.
//

#import "YLCostViewController.h"
#import "YLBudgetViewController.h"
#import "YLCostOneTimeViewController.h"
#import "YLCostVew.h"
#import "YLCostModel.h"
#import "YLDetailViewController.h"
#import "YLCostModelSetViewController.h"
@interface YLCostViewController (){
    YLCostVew *costCreatView;
    UIImageView *imageDown;
}

@end

@implementation YLCostViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    costCreatView =[[YLCostVew alloc]init];
    self.title=@"支出统计";
    [self customTabBarButtonTitle:@"返回" image:@"button_barbar" target:self action:@selector(onLeftClicked:)  isLeft:YES];
    UIImageView *bgImageView=[self creatViewNaviBackgroundImage];
    CGFloat costTotal=[YLTimeDeal costThisYearTotal];
    [costCreatView totalCostOrGetLabel:bgImageView name:@"总支出：" total:costTotal];
    CGFloat dayCost=[YLTimeDeal costTadayNowTotal];
    [costCreatView creatDayCostOrGetView:bgImageView name:@"本日支出" total:dayCost];
    //周
    CGFloat weekCost=[YLTimeDeal costWeekNowTotal];
    [costCreatView creatWeekCostOrGetView:bgImageView name:@"本周支出" total:weekCost];
    //月
    CGFloat monthCost=[YLTimeDeal costThisMonthTotal];
    [costCreatView creatMonthCostOrGetView:bgImageView name:@"本月支出" total:monthCost];
    NSArray *nameArray=@[@"逐日支出",@"逐月支出",@"支出一笔",@"设置模板"];
    [costCreatView creatFiveButtonForCostOrGetView:bgImageView nameArray:nameArray];
    //按键回调
    [self buttonClicked];
    
}
-(void)onLeftClicked:(UIButton*)sender{
    [self.navigationController popViewControllerAnimated:YES];
}

-(UIImageView*)creatViewNaviBackgroundImage{
    imageDown=[[UIImageView alloc]initWithFrame:CGRectMake(0,0, self.view.bounds.size.width,  self.view.bounds.size.height)];
    imageDown.userInteractionEnabled=YES;
    imageDown.image=[UIImage imageNamed:@"COST_bg"];
    [self.view addSubview:imageDown];
    return imageDown;
}
#pragma mark-方法回调
-(void)buttonClicked{
   // UIButton *button=(id)[imageDown viewWithTag:703];
   // [button addTarget:self action:@selector(buttonClickedToBudget:) forControlEvents:UIControlEventTouchUpInside];
    UIButton *costButton=(id)[imageDown viewWithTag:702];
    [costButton addTarget:self action:@selector(buttonClickedToCostOne:) forControlEvents:UIControlEventTouchUpInside];
    UIButton *costButtonDay=(id)[imageDown viewWithTag:700];
    [costButtonDay addTarget:self action:@selector(buttonClickedToCostDay:) forControlEvents:UIControlEventTouchUpInside];
    UIButton *costButtonMonth=(id)[imageDown viewWithTag:701];
    [costButtonMonth addTarget:self action:@selector(buttonClickedToCostMonth:) forControlEvents:UIControlEventTouchUpInside];
    UIButton *modelButton=(id)[imageDown viewWithTag:703];
    [modelButton addTarget:self action:@selector(modelButtonActon:) forControlEvents:UIControlEventTouchUpInside];
    
}
//设置模板的按钮回调
-(void)modelButtonActon:(UIButton*)sender{
    YLCostModelSetViewController *costModelSetVC=[[YLCostModelSetViewController alloc ]init];
    [self.navigationController pushViewController:costModelSetVC animated:YES];
}
//进入详情页面
-(void)buttonClickedToCostDay:(UIButton *)sender{
    YLDetailViewController *detailVC=[[YLDetailViewController alloc]init];
    detailVC.chooseClass=COSTDETAIL;
    detailVC.chooseShowKind=DAYKINDDETAIL;
    [self.navigationController pushViewController:detailVC animated:YES];
}
-(void)buttonClickedToCostMonth:(UIButton *)sender{
    YLDetailViewController *detailVC=[[YLDetailViewController alloc]init];
    detailVC.chooseClass=COSTDETAIL;
    detailVC.chooseShowKind=MONTHKINDDATAIL;
    [self.navigationController pushViewController:detailVC animated:YES];
}

//预算页面回调方法
-(void)buttonClickedToBudget:(UIButton *)sender{
    YLBudgetViewController *budgetVC=[[YLBudgetViewController alloc]init];
    [self.navigationController pushViewController:budgetVC animated:YES];
}
//支出一笔页面回调
-(void)buttonClickedToCostOne:(UIButton *)sender{
    YLCostOneTimeViewController *costOneTimeVC=[[YLCostOneTimeViewController alloc]init];
    [self.navigationController pushViewController:costOneTimeVC animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end






















