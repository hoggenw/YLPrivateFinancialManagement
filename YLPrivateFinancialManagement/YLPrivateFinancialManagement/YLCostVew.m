//
//  YLCostVew.m
//  YLPrivateFinancialManagement
//
//  Created by 千锋 on 16/1/20.
//  Copyright (c) 2016年 mobiletrain. All rights reserved.
//

#import "YLCostVew.h"

@implementation YLCostVew
{
    
    UIView *totalView;//放年视图的符视图
    UIView *dayView;//放日视图的父视图
    UIView *weekView;//放周视图的父视图
    UIView *monthView;//放月视图
    
}
/**创建4个按钮*/
-(void)creatFiveButtonForCostOrGetView:(UIView *)superView nameArray:(NSArray *)nameArray{
    for (int index=0; index<nameArray.count; index++) {
        UIButton *button=[UIButton buttonWithType:UIButtonTypeCustom];
        button.tag=700+index;
        button.titleLabel.textAlignment=NSTextAlignmentCenter;
        [button setTitle:nameArray[index] forState:UIControlStateNormal];
        [superView addSubview:button];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
         button.titleLabel.font=[UIFont boldSystemFontOfSize:24];
        button.layer.cornerRadius=8;
        [button setBackgroundImage:[UIImage imageNamed:@"button_bg"] forState:UIControlStateNormal];
        button.clipsToBounds=YES;
      
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(superView.mas_centerX);
            make.left.equalTo(superView.mas_left).offset(60);
            make.right.equalTo(superView.mas_right).offset(-60);
            make.top.equalTo(monthView.mas_bottom).offset(10+index*40+index*5);
            make.height.equalTo(@(40));
        }];
        
    }
}

/**建造月支出的视图*/
-(void)creatMonthCostOrGetView:(UIView *)superView name:(NSString *)name total:(CGFloat)total{
    monthView=[[UIView alloc]init];
    monthView.backgroundColor=[UIColor whiteColor];
    [superView addSubview:monthView];
    [monthView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(superView.mas_left).offset(5);
        make.top.equalTo(weekView.mas_bottom).offset(2);
        make.right.equalTo(superView.mas_right).offset(-5);
        make.height.equalTo(@(60));
    }];
    UILabel  *nameLabel=[[UILabel alloc]init];
    nameLabel.font=[UIFont systemFontOfSize:16];
    nameLabel.textAlignment=NSTextAlignmentLeft;
    nameLabel.textColor=[UIColor lightGrayColor];
    nameLabel.text=name;
    CGFloat width=(superView.bounds.size.width-10)/2.f;
    [monthView addSubview:nameLabel];
    [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(monthView.mas_left).offset(3);
        make.top.equalTo(monthView.mas_top);
        make.height.equalTo(@(30));
        make.width.equalTo(@(width));
    }];
    UILabel  *dateLabel=[[UILabel alloc]init];
    dateLabel.font=[UIFont systemFontOfSize:16];
    dateLabel.textAlignment=NSTextAlignmentLeft;
    dateLabel.textColor=[UIColor lightGrayColor];
    NSDate * date = [NSDate date];
    NSDate *monthBigen=[YLTimeDeal dealTimeDate:date];
    NSDate *nextMonthBigene=[monthBigen dateByAddingMonths:1];
    NSDate *monthEnd=[nextMonthBigene dateBySubtractingDays:1];
    NSString *firstString=[self chinaTimeShow:monthBigen];
    NSString *endString=[self chinaTimeShow:monthEnd];
    dateLabel.text = [NSString stringWithFormat:@"%@~%@",firstString,endString];
    [monthView addSubview:dateLabel];
    [dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(monthView.mas_left).offset(3);
        make.bottom.equalTo(monthView.mas_bottom);
        make.height.equalTo(@(30));
        make.width.equalTo(@(width));
    }];
    UILabel *totalLabel=[[UILabel alloc]init];
    totalLabel.font=[UIFont boldSystemFontOfSize:20];
    totalLabel.textAlignment=NSTextAlignmentCenter;
    totalLabel.textColor=[UIColor blueColor];
    totalLabel.text=[NSString stringWithFormat:@"%.1lf",total];
    [monthView addSubview:totalLabel];
    [totalLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(dateLabel.mas_right);
        make.top.equalTo(monthView.mas_top);
        make.width.equalTo(@(width));
        make.bottom.equalTo(monthView.mas_bottom);
    }];
}
/**建造周支出的视图*/
-(void)creatWeekCostOrGetView:(UIView *)superView name:(NSString *)name total:(CGFloat)total{
    weekView=[[UIView alloc]init];
    weekView.backgroundColor=[UIColor whiteColor];
    [superView addSubview:weekView];
    [weekView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(superView.mas_left).offset(5);
        make.top.equalTo(dayView.mas_bottom).offset(2);
        make.right.equalTo(superView.mas_right).offset(-5);
        make.height.equalTo(@(60));
    }];
    UILabel  *nameLabel=[[UILabel alloc]init];
    nameLabel.font=[UIFont systemFontOfSize:16];
    nameLabel.textAlignment=NSTextAlignmentLeft;
    nameLabel.textColor=[UIColor lightGrayColor];
    nameLabel.text=name;
    CGFloat width=(superView.bounds.size.width-10)/2.f;
    [weekView addSubview:nameLabel];
    [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weekView.mas_left).offset(3);
        make.top.equalTo(weekView.mas_top);
        make.height.equalTo(@(30));
        make.width.equalTo(@(width));
    }];
    UILabel  *dateLabel=[[UILabel alloc]init];
    dateLabel.font=[UIFont systemFontOfSize:16];
    dateLabel.textAlignment=NSTextAlignmentLeft;
    dateLabel.textColor=[UIColor lightGrayColor];
    NSDate * date = [NSDate date];
    NSDate  *weekBigen=[date dateBySubtractingDays:date.weekdayOrdinal-1];
    NSDate  *weekEnd=[weekBigen dateByAddingDays:7];
    NSString *firstString=[self chinaTimeShow:weekBigen];
    NSString *endString=[self chinaTimeShow:weekEnd];
    dateLabel.text = [NSString stringWithFormat:@"%@~%@",firstString,endString];
    [weekView addSubview:dateLabel];
    [dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weekView.mas_left).offset(3);
        make.bottom.equalTo(weekView.mas_bottom);
        make.height.equalTo(@(30));
        make.width.equalTo(@(width));
    }];
    UILabel *totalLabel=[[UILabel alloc]init];
    totalLabel.font=[UIFont boldSystemFontOfSize:20];
    totalLabel.textAlignment=NSTextAlignmentCenter;
    totalLabel.textColor=[UIColor blueColor];
    totalLabel.text=[NSString stringWithFormat:@"%.1lf",total];
    [weekView addSubview:totalLabel];
    [totalLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(dateLabel.mas_right);
        make.top.equalTo(weekView.mas_top);
        make.width.equalTo(@(width));
        make.bottom.equalTo(weekView.mas_bottom);
    }];
}
/**建造日支出的视图*/
-(void)creatDayCostOrGetView:(UIView *)superView name:(NSString *)name total:(CGFloat)total{
    dayView=[[UIView alloc]init];
    dayView.backgroundColor=[UIColor whiteColor];
    [superView addSubview:dayView];
    [dayView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(superView.mas_left).offset(5);
        make.top.equalTo(totalView.mas_bottom).offset(2);
        make.right.equalTo(superView.mas_right).offset(-5);
        make.height.equalTo(@(60));
    }];
    UILabel  *nameLabel=[[UILabel alloc]init];
    nameLabel.font=[UIFont systemFontOfSize:16];
    nameLabel.textAlignment=NSTextAlignmentLeft;
    nameLabel.textColor=[UIColor lightGrayColor];
    nameLabel.text=name;
    CGFloat width=(superView.bounds.size.width-10)/2.f;
    [dayView addSubview:nameLabel];
    [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(dayView.mas_left).offset(3);
        make.top.equalTo(dayView.mas_top);
        make.height.equalTo(@(30));
        make.width.equalTo(@(width));
    }];
    UILabel  *dateLabel=[[UILabel alloc]init];
    dateLabel.font=[UIFont systemFontOfSize:16];
    dateLabel.textAlignment=NSTextAlignmentLeft;
    dateLabel.textColor=[UIColor lightGrayColor];
    NSDate * date = [NSDate date];
    NSString *dataStr1=[date formattedDateWithFormat:@"YYYY/MM/dd HH:mm:ss"];
    NSArray *array=[dataStr1 componentsSeparatedByString:@" "];
    NSString *string=[array firstObject];
    NSArray *lastArray=[string componentsSeparatedByString:@"/"];
    NSString *dataStr=[NSString stringWithFormat:@"%@年%@月%@日",lastArray[0],lastArray[1],lastArray[2]];
    dateLabel.text = dataStr;
    [dayView addSubview:dateLabel];
    [dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(dayView.mas_left).offset(3);
        make.bottom.equalTo(dayView.mas_bottom);
        make.height.equalTo(@(30));
        make.width.equalTo(@(width));
    }];
    UILabel *totalLabel=[[UILabel alloc]init];
    totalLabel.font=[UIFont boldSystemFontOfSize:20];
    totalLabel.textAlignment=NSTextAlignmentCenter;
    totalLabel.textColor=[UIColor blueColor];
    totalLabel.text=[NSString stringWithFormat:@"%.1lf",total];
    [dayView addSubview:totalLabel];
    [totalLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(dateLabel.mas_right);
        make.top.equalTo(dayView.mas_top);
        make.width.equalTo(@(width));
        make.bottom.equalTo(dayView.mas_bottom);
    }];
    
}
/**建造总支出或者收入的label*/
-(void)totalCostOrGetLabel:(UIView *)superView name:(NSString *)name total:(CGFloat)total{
    totalView=[[UIView alloc]init];
    totalView.backgroundColor=[UIColor whiteColor];
    [superView addSubview:totalView];
    [totalView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(superView.mas_left).offset(5);
        make.top.equalTo(superView.mas_top).offset(65);
        make.right.equalTo(superView.mas_right).offset(-5);
        make.height.equalTo(@(50));
    }];
    UILabel *totalLabel=[[UILabel alloc]init];
    totalLabel.font=[UIFont boldSystemFontOfSize:20];
    totalLabel.textAlignment=NSTextAlignmentCenter;
    totalLabel.textColor=[UIColor blackColor];
    totalLabel.text=name;
    //totalLabel.layer.borderWidth=0.5;
    CGFloat width=(superView.bounds.size.width-30)/3.f;
    [totalView addSubview:totalLabel];
    [totalLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(totalView.mas_left).offset(5);
        make.top.equalTo(totalView.mas_top).offset(5);
        make.width.equalTo(@(width));
        make.height.equalTo(@(40));
    }];
    UILabel *showLabel=[[UILabel alloc]init];
    showLabel.font=[UIFont boldSystemFontOfSize:20];
    showLabel.textAlignment=NSTextAlignmentCenter;
    showLabel.textColor=[UIColor blueColor];
    showLabel.text=[NSString stringWithFormat:@"%.1lf",total];
    [totalView addSubview:showLabel];
    [showLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(totalLabel.mas_right).offset(10);
        make.top.equalTo(totalView.mas_top).offset(5);
        make.width.equalTo(@(width));
        make.height.equalTo(@(40));

    }];
    UILabel *dateLabel=[[UILabel alloc]init];
    dateLabel.font=[UIFont boldSystemFontOfSize:20];
    dateLabel.textAlignment=NSTextAlignmentCenter;
    dateLabel.textColor=[UIColor blackColor];
    NSDate *date=[NSDate date];
    NSUInteger year=date.year;
    dateLabel.text=[NSString stringWithFormat:@"%ld年",(unsigned long)year];
    [totalView addSubview:dateLabel];
    [dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(showLabel.mas_right).offset(10);
        make.top.equalTo(totalView.mas_top).offset(5);
        make.width.equalTo(@(width));
        make.height.equalTo(@(40));
    }];
}
-(NSString *)dateShowDeal:(NSString*)dateString{
    NSArray *array=[dateString componentsSeparatedByString:@" "];
    NSString *firstString=[array firstObject];
    NSArray *nextArray=[firstString componentsSeparatedByString:@"年"];
    return [nextArray lastObject];
}
-(NSString *)chinaTimeShow:(NSDate*)date{
    NSString *dataStr1=[date formattedDateWithFormat:@"YYYY/MM/dd HH:mm:ss"];
    NSArray *array=[dataStr1 componentsSeparatedByString:@" "];
    NSString *string=[array firstObject];
    NSArray *lastArray=[string componentsSeparatedByString:@"/"];
    NSString *dataStr=[NSString stringWithFormat:@"%@月%@日",lastArray[1],lastArray[2]];
    return dataStr;
}
@end
