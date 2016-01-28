//
//  YLMainViewController.m
//  YLPrivateFinancialManagement
//
//  Created by 千锋 on 16/1/11.
//  Copyright (c) 2016年 mobiletrain. All rights reserved.
//

#import "YLMainViewController.h"
#import "YLfirstView.h"
#import "YLProgressView.h"
#import "YLCenterView.h"
#import "YLReportViewController.h"
#import "YLDetailViewController.h"
#import "YLGetViewController.h"
#import "YLCostViewController.h"
#import "YLGetOneViewController.h"
#import "YLCostOneTimeViewController.h"
#import "YLBudgetViewController.h"

@interface YLMainViewController (){
    UIImageView *backImageView;
    YLDataBaseManager *manager;
}

@end

@implementation YLMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    sleep(1);
    //设置控制视图
    YLfirstView *master=[[YLfirstView alloc]init];
    YLProgressView *progressView=[[YLProgressView alloc]init];
    [master creatControlButton:self.view target:self action:@selector(onButtonClicked:)];
    //设置背景图片和进度条
     backImageView=[self setBcakImageView];
    [progressView creatProgresssView:YES superView:backImageView];
    [progressView creatProgresssView:NO superView:backImageView];
    //设置中心区域UI
    YLCenterView *centerView=[[YLCenterView alloc]init];
    [centerView creatCenterView:backImageView target:self action:@selector(onButtonCostOrGet:) ];
    //创建数据库
    manager=[YLDataBaseManager shareManager];
    
}
-(void)onLeftClicked:(UIButton*)sender{
     [self.sideMenuViewController presentLeftMenuViewController];
}
//支出和收入的回调方法
-(void)onButtonCostOrGet:(UIButton*)sender{
    if (sender.tag==400) {
        YLCostOneTimeViewController *costOne=[[YLCostOneTimeViewController alloc]init];
        [self.navigationController pushViewController:costOne animated:YES];
    }else{
        YLGetOneViewController *getOneVc=[[YLGetOneViewController alloc]init];
        [self.navigationController pushViewController:getOneVc animated:YES];
    }
}




//视图button点击的回调方法
-(void)onButtonClicked:(UIButton *)sender{
    switch (sender.tag-200) {
        case 1:{
            YLGetViewController *getVC=[[YLGetViewController alloc]init];
            [self.navigationController pushViewController:getVC animated:YES];
            break;
        }
        case 2:{
            YLCostViewController *costVC=[[YLCostViewController alloc]init];
            [self.navigationController pushViewController:costVC animated:YES];
            break;
        }
        case 3:{
            YLBudgetViewController *bugetVc=[[YLBudgetViewController alloc]init];
            [self.navigationController pushViewController:bugetVc animated:YES];
            break;
        }
        case 4:{
            YLDetailViewController *detailVC=[[YLDetailViewController alloc]init];
            [self.navigationController pushViewController:detailVC animated:YES];
            break;
        }
        case 5:{
            YLReportViewController *reportVC=[[YLReportViewController alloc]init];
            [self.navigationController pushViewController:reportVC animated:YES];
            break;
        }
        default:
            break;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(UIImageView*)setBcakImageView{
    UIImageView *backGroundImageView=[[UIImageView alloc]init];
    [self.view addSubview:backGroundImageView];
    __weak typeof(self) weakSelf=self;
    backGroundImageView.image=[UIImage imageNamed:@"bg2"];
    [backGroundImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.view.mas_top);
        make.left.equalTo(weakSelf.view.mas_left);
        make.width.equalTo(weakSelf.view.mas_width);
        UIView *view=[weakSelf.view viewWithTag:200];
        make.bottom.equalTo(view.mas_top).offset(2);
    }];
    backGroundImageView.tag=220;
    backGroundImageView.userInteractionEnabled=YES;
    return backGroundImageView;
}
//点击其他放弃第一响应者
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    UIImageView *imageView=(id)[self.view viewWithTag:220];
    UITextField *topTextL=(id)[imageView viewWithTag:300];
    UITextField  *topTextR=(id)[imageView viewWithTag:301];
    [topTextL resignFirstResponder];
    [topTextR resignFirstResponder];
}
-(void)viewDidAppear:(BOOL)animated{
    //uiview 290，left 210 ,uiview 291 right 211 left label 300；right 301；
    UIView *leftProgressView=[backImageView viewWithTag:290];
    UIView *rightProgressView=[backImageView viewWithTag:291];
    UILabel *leftLabel=(id)[backImageView viewWithTag:300];
    UILabel *rightLabel=(id)[backImageView viewWithTag:301];
    UIImageView *leftImage=(id)[leftProgressView viewWithTag:210];
    UIImageView *rightImage=(id)[rightProgressView viewWithTag:211];
    UIView *centerView=[backImageView viewWithTag:282];
    UILabel *upLabel=(id)[centerView viewWithTag:280];
    UILabel *downLabel=(id)[centerView viewWithTag:281];
    CGFloat heightProView=leftProgressView.frame.size.height;
    //首先取出预算数据
    CGFloat budget=[YLNsuserD getDoubleForKey:@"budget"];
    //设置支出部分的总值
    CGFloat costStandardTotal=budget==0?5000:budget;
    CGFloat costNow=[YLTimeDeal costThisMonthTotal];
    CGFloat costPercentage=costNow/costStandardTotal;
    if (costPercentage>1) {
        costPercentage=1.f;
    }else if(costPercentage<0){
        costPercentage=0.f;
    }
    CGFloat justB=budget-costNow;
    justB=justB<0?0:justB;
    CGFloat budgetSurplus=budget==0?0:justB;
    CGFloat leftImageHeight=0;
    if (budget<=0) {
        leftImageHeight=heightProView;
    }else{
        if (budgetSurplus==0) {
            leftImageHeight=heightProView;
        }else{
            leftImageHeight=heightProView*(1.f-budgetSurplus/budget);
        }
    }
    CGFloat rightImageHeight=heightProView *costPercentage;
    dispatch_async(dispatch_get_main_queue(), ^{
        rightLabel.text=[NSString stringWithFormat:@"%.1lf",costNow];
        leftLabel.text=[NSString stringWithFormat:@"%.1lf",budgetSurplus];
        upLabel.text=[NSString stringWithFormat:@"今日支出:%.1lf",[YLTimeDeal costTadayNowTotal]];
        downLabel.text=[NSString stringWithFormat:@"今日收入:%.1lf",[YLTimeDeal getTadayNowTotal]];
    [rightImage mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(rightProgressView.mas_bottom).offset(-rightImageHeight);
    }];
    [leftImage mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(leftProgressView.mas_top).offset(leftImageHeight);
    }];
    });
    
}


@end



















