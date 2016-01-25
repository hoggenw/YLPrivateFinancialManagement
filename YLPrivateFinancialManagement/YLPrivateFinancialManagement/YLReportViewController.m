//
//  YLReportViewController.m
//  YLPrivateFinancialManagement
//
//  Created by 千锋 on 16/1/11.
//  Copyright (c) 2016年 mobiletrain. All rights reserved.
//

#import "YLReportViewController.h"
#import "YLPieReportView.h"
#import "YLDrawPieChart.h"
#import "YLPieModel.h"
@interface YLReportViewController (){
    YLPieReportView *pieView;
    UIImageView *selfBackView;
    YLDrawPieChart  *pieChartView;
}

@end

@implementation YLReportViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   self.title=@"图形报表";
    pieView=[[YLPieReportView alloc]init];
    [self customTabBarButtonTitle:@"返回" image:@"button_barbar" target:self action:@selector(onLeftClicked:)  isLeft:YES];
    [self creaSelfBackView];
    NSArray *nameArray=@[@"收入图表",@"支出图表"];
    [pieView creatTwoButtonForReportView:selfBackView nameArray:nameArray];
    [pieView creatChooseTimeView:selfBackView];
    [self creatButtonCallBack];
    [self creatPieViewFromData];
   
}
-(void)onLeftClicked:(UIButton*)sender{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)creaSelfBackView{
    selfBackView=[[UIImageView alloc]initWithFrame:self.view.frame];
    [self.view addSubview:selfBackView];
    selfBackView.userInteractionEnabled=YES;
    selfBackView.image=[UIImage imageNamed:@"report__bg"];
}
#pragma mark-创建饼形图
-(void)creatPieViewFromData{
     UILabel *label=(id)[selfBackView viewWithTag:912];
    if (_chooseClass==COSTDETAIL||_chooseClass==DEFAULTDETAIL) {
        if (_chooseKind==SHOWPIEKINDDEFAULT||_chooseKind== SHOWPIEKINDBIGCLASS) {
            [self creatPieChartView];
            NSArray *modelArray=[YLDatePieChartNeed monthClassesCost:label.text];
            [pieChartView beginDraw:modelArray];
            [self showLabel:modelArray];
        }else if(_chooseKind==SHOWPIEKINDALLKINDS){
            [self creatPieChartView];
            NSArray *modelArray=[YLDatePieChartNeed monthAllKindsCost:label.text];
            [pieChartView beginDraw:modelArray];
            [self showLabel:modelArray];
        }
    }else if (_chooseClass==GETDETAL){
        [self creatPieChartView];
        NSArray *modelArray=[YLDatePieChartNeed monthClassesGet:label.text];
        [pieChartView beginDraw:modelArray];
        [self showLabel:modelArray];
    }
}
-(void)creatPieChartView{
    pieChartView=[[YLDrawPieChart alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 290)];
    
    pieChartView.center=CGPointMake(self.view.bounds.size.width/2.f, self.view.bounds.size.height/2+50);
    [self.view addSubview:pieChartView];
    pieChartView.backgroundColor=[UIColor clearColor];
  

}
#pragma mark-label
-(void)showLabel:(NSArray*)moldelArray{
    UILabel *label=(id)[selfBackView viewWithTag:922];
    NSMutableString *labelString=[NSMutableString string];
    for (int index=0; index<moldelArray.count; index++) {
        YLPieModel *model=[[YLPieModel alloc]init];
        model=moldelArray[index];
        [labelString appendString:[NSString stringWithFormat:@"%@:%.1lf  ",model.name,model.number]];
    }
    label.text=labelString;
}
#pragma mark-创建回调
-(void)creatButtonCallBack{
    UIButton *getButton=(id)[selfBackView viewWithTag:900];
    UIButton *costButton=(id)[selfBackView viewWithTag:901];
    UIButton *leftButton=(id)[selfBackView viewWithTag:910];
    UIButton *rightButton=(id)[selfBackView viewWithTag:911];
    [getButton addTarget:self action:@selector(getButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [costButton addTarget:self action:@selector(costButtonClieked:) forControlEvents:UIControlEventTouchUpInside];
    [leftButton addTarget:self action:@selector(leftButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [rightButton addTarget:self action:@selector(rightButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
}
-(void)creatChooseKindButtonCallBack{
    UIButton *bigClassButton=(id)[selfBackView viewWithTag:920];
    UIButton *allKindsButton=(id)[selfBackView viewWithTag:921];
    [bigClassButton addTarget:self action:@selector(bigClassChooseButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [allKindsButton addTarget:self action:@selector(allKindsButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
}
-(void)creatChooseKindButtonView{
    [pieView creatChooseKindButtonView:selfBackView nameArray:@[@"只看大类",@"所有分类"]];
}
-(void)deleteChooseKindButtonView{
    UIButton *bigClassButton=(id)[selfBackView viewWithTag:920];
    UIButton *allKindsButton=(id)[selfBackView viewWithTag:921];
    [bigClassButton removeFromSuperview];
    [allKindsButton removeFromSuperview];
}
#pragma mark-回调方法
-(void)getButtonClicked:(UIButton*)sender{
    _chooseClass=GETDETAL;
    [self deleteChooseKindButtonView];
    [pieChartView removeFromSuperview];
    [self creatPieViewFromData];
}
-(void)costButtonClieked:(UIButton*)sender{
    _chooseClass=COSTDETAIL;
    //创建分类选项
    [self creatChooseKindButtonView];
    [self creatChooseKindButtonCallBack];
    [pieChartView removeFromSuperview];
    [self creatPieViewFromData];
}
-(void)bigClassChooseButtonClicked:(UIButton*)sender{
    _chooseKind=SHOWPIEKINDBIGCLASS;
    [pieChartView removeFromSuperview];
    [self creatPieViewFromData];
}
-(void)allKindsButtonClicked:(UIButton*)sender{
    _chooseKind=SHOWPIEKINDALLKINDS;
    [pieChartView removeFromSuperview];
    [self creatPieViewFromData];
}
-(void)leftButtonClicked:(UIButton*)sender{
    UILabel *label=(id)[selfBackView viewWithTag:912];
       NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    NSArray *array=[label.text componentsSeparatedByString:@"月"];
    NSString *yearMonth=[array firstObject];
    NSArray *lastArray=[yearMonth componentsSeparatedByString:@"年"];
    
    NSString *string=[NSString stringWithFormat:@"%@-%@-08",lastArray[0],lastArray[1]];
    [formatter setDateFormat:@"YYYY-MM-dd"];
    NSDate *date = [formatter dateFromString:string];
    NSDate *needDate=[date dateBySubtractingMonths:1];
    NSString *dataStr1=[needDate formattedDateWithFormat:@"YYYY/MM/dd HH:mm:ss"];
    NSArray *array2=[dataStr1 componentsSeparatedByString:@" "];
    NSString *string2=[array2 firstObject];
    NSArray *lastArray2=[string2 componentsSeparatedByString:@"/"];
    NSString *dataStr=[NSString stringWithFormat:@"%@年%@月%@日",lastArray2[0],lastArray2[1],lastArray2[2]];
    label.text=[YLTimeDeal dealMonthString:dataStr];
    [pieChartView removeFromSuperview];
    [self creatPieViewFromData];
}
-(void)rightButtonClicked:(UIButton*)sender{
    UILabel *label=(id)[selfBackView viewWithTag:912];
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    NSArray *array=[label.text componentsSeparatedByString:@"月"];
    NSString *yearMonth=[array firstObject];
    NSArray *lastArray=[yearMonth componentsSeparatedByString:@"年"];
    
    NSString *string=[NSString stringWithFormat:@"%@-%@-08",lastArray[0],lastArray[1]];
    [formatter setDateFormat:@"YYYY-MM-dd"];
    NSDate *date = [formatter dateFromString:string];
    NSDate *needDate=[date dateByAddingMonths:1];
    NSString *dataStr1=[needDate formattedDateWithFormat:@"YYYY/MM/dd HH:mm:ss"];
    NSArray *array2=[dataStr1 componentsSeparatedByString:@" "];
    NSString *string2=[array2 firstObject];
    NSArray *lastArray2=[string2 componentsSeparatedByString:@"/"];
    NSString *dataStr=[NSString stringWithFormat:@"%@年%@月%@日",lastArray2[0],lastArray2[1],lastArray2[2]];
    label.text=[YLTimeDeal dealMonthString:dataStr];
    [pieChartView removeFromSuperview];
    [self creatPieViewFromData];
}


@end




































