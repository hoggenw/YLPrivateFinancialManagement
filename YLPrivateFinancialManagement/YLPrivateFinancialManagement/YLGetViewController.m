//
//  YLGetViewController.m
//  YLPrivateFinancialManagement
//
//  Created by 千锋 on 16/1/20.
//  Copyright (c) 2016年 mobiletrain. All rights reserved.
//

#import "YLGetViewController.h"
#import "YLBudgetViewController.h"
#import "YLGetOneViewController.h"
#import "YLCostVew.h"
#import "YLGetModel.h"
#import "YLDetailViewController.h"
#import "YLGetModelViewController.h"
@interface YLGetViewController (){
     YLCostVew *costCreatView;
     UIImageView *imageDown;
}

@end

@implementation YLGetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"收入统计";
    costCreatView =[[YLCostVew alloc]init];
    [self customTabBarButtonTitle:@"返回" image:@"button_barbar" target:self action:@selector(onLeftClicked:)  isLeft:YES];
    UIImageView *bgImageView=[self creatViewNaviBackgroundImage];
    //年
    CGFloat getTotal=[YLTimeDeal getThisYearTotal];
    [costCreatView totalCostOrGetLabel:bgImageView name:@"总收入：" total:getTotal];
    //日
    CGFloat getDay=[YLTimeDeal getTadayNowTotal];
    [costCreatView creatDayCostOrGetView:bgImageView name:@"本日收入" total:getDay];
    //周
    CGFloat getWeek=[YLTimeDeal getWeekNowTotal];
    [costCreatView creatWeekCostOrGetView:bgImageView name:@"本周收入" total:getWeek];
    //月
    CGFloat getMonth=[YLTimeDeal getThisMonthTotal];
    [costCreatView creatMonthCostOrGetView:bgImageView name:@"本月收入" total:getMonth];
    NSArray *nameArray=@[@"逐日收入",@"逐月收入",@"收入一笔",@"设置预算",@"设置模板"];
    [costCreatView creatFiveButtonForCostOrGetView:bgImageView nameArray:nameArray];
    [self buttonClicked];
}
-(void)onLeftClicked:(UIButton*)sender{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)buttonClicked{
    UIButton *button=(id)[imageDown viewWithTag:703];
    [button addTarget:self action:@selector(buttonClickedToBudget:) forControlEvents:UIControlEventTouchUpInside];
    UIButton *getButton=(id)[imageDown viewWithTag:702];
    [getButton addTarget:self action:@selector(buttonClickedToGetOne:) forControlEvents:UIControlEventTouchUpInside];
    UIButton *getButtonDay=(id)[imageDown viewWithTag:700];
    [getButtonDay addTarget:self action:@selector(buttonClickedToGetDay:) forControlEvents:UIControlEventTouchUpInside];
    UIButton *getButtonMonth=(id)[imageDown viewWithTag:701];
    [getButtonMonth addTarget:self action:@selector(buttonClickedToGetMonth:) forControlEvents:UIControlEventTouchUpInside];
    UIButton *modelButton=(id)[imageDown viewWithTag:704];
    [modelButton addTarget:self action:@selector(modelButtonActon:) forControlEvents:UIControlEventTouchUpInside];
}
//设置模板的按钮回调
-(void)modelButtonActon:(UIButton*)sender{
    YLGetModelViewController *getModelSetVC=[[YLGetModelViewController alloc]init];
    [self.navigationController pushViewController:getModelSetVC animated:YES];
}

//进入详情页面
-(void)buttonClickedToGetDay:(UIButton *)sender{
    YLDetailViewController *detailVC=[[YLDetailViewController alloc]init];
    detailVC.chooseClass=GETDETAL;
    detailVC.chooseShowKind=DAYKINDDETAIL;
    [self.navigationController pushViewController:detailVC animated:YES];
}
-(void)buttonClickedToGetMonth:(UIButton *)sender{
    YLDetailViewController *detailVC=[[YLDetailViewController alloc]init];
    detailVC.chooseClass=GETDETAL;
    detailVC.chooseShowKind=MONTHKINDDATAIL;
    [self.navigationController pushViewController:detailVC animated:YES];
}
//预算页面回调方法
-(void)buttonClickedToBudget:(UIButton *)sender{
    YLBudgetViewController *budgetVC=[[YLBudgetViewController alloc]init];
    [self.navigationController pushViewController:budgetVC animated:YES];
}
//收入一笔页面回调方法
-(void)buttonClickedToGetOne:(UIButton *)sender{
    YLGetOneViewController *getOneTimeVC=[[YLGetOneViewController alloc]init];
    [self.navigationController pushViewController:getOneTimeVC animated:YES];
}
-(UIImageView*)creatViewNaviBackgroundImage{
    imageDown=[[UIImageView alloc]initWithFrame:CGRectMake(0,0, self.view.bounds.size.width,  self.view.bounds.size.height)];
    imageDown.userInteractionEnabled=YES;
    imageDown.image=[UIImage imageNamed:@"COST_bg"];
    [self.view addSubview:imageDown];
    return imageDown;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
