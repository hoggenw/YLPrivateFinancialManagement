//
//  YLPieReportView.m
//  YLPrivateFinancialManagement
//
//  Created by 千锋 on 16/1/21.
//  Copyright (c) 2016年 mobiletrain. All rights reserved.
//

#import "YLPieReportView.h"

@implementation YLPieReportView
/**
 *  创建支出图形显示的分类按钮
 */
-(void)creatChooseKindButtonView:(UIView *)superView nameArray:(NSArray *)nameArray{
    for (int index=0; index<nameArray.count; index++) {
        UIButton *button=[UIButton buttonWithType:UIButtonTypeCustom];
        button.tag=920+index;
        CGFloat width=(superView.bounds.size.width-140)/nameArray.count;
        button.titleLabel.textAlignment=NSTextAlignmentCenter;
        [button setTitle:nameArray[index] forState:UIControlStateNormal];
        [superView addSubview:button];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        button.titleLabel.font=[UIFont boldSystemFontOfSize:20];
        [button setBackgroundImage:[UIImage imageNamed:@"buttonbar"] forState:UIControlStateNormal];
        button.clipsToBounds=YES;
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(superView.mas_left).offset(70+(width)*index);
            make.width.equalTo(@(width));
            make.bottom.equalTo(superView.mas_bottom);
            make.height.equalTo(@(40));
        }];
    }
   
}

/**
 *  创建两个按钮，分别是支出和收入
 */
-(void)creatTwoButtonForReportView:(UIView *)superView nameArray:(NSArray *)nameArray{
    for (int index=0; index<nameArray.count; index++) {
        UIButton *button=[UIButton buttonWithType:UIButtonTypeCustom];
        button.tag=900+index;
        CGFloat width=(superView.bounds.size.width-80)/nameArray.count;
        button.titleLabel.textAlignment=NSTextAlignmentCenter;
        [button setTitle:nameArray[index] forState:UIControlStateNormal];
        [superView addSubview:button];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        button.titleLabel.font=[UIFont boldSystemFontOfSize:24];
        [button setBackgroundImage:[UIImage imageNamed:@"buttonbar"] forState:UIControlStateNormal];
        button.clipsToBounds=YES;
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(superView.mas_left).offset(40+(width)*index);
            make.width.equalTo(@(width));
            make.top.equalTo(superView.mas_top).offset(70);
            make.height.equalTo(@(40));
        }];
        
    }
    UILabel *label=[[UILabel alloc]init];
    [superView addSubview:label];
    label.tag=922;
    label.numberOfLines=0;
    label.font=[UIFont systemFontOfSize:12];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(superView.mas_left).offset(30);
        make.right.equalTo(superView.mas_right).offset(-30);
        make.bottom.equalTo(superView.mas_bottom).offset(-40);
    }];
}
/**
 *  创建选着显示图标
 */
-(void)creatChooseTimeView:(UIView *)superView{
    UIButton *leftButton=[UIButton buttonWithType:UIButtonTypeCustom];
    leftButton.tag=910;
    [superView addSubview:leftButton];
    [leftButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(superView.mas_left).offset(45);
        make.top.equalTo(superView.mas_top).offset(110);
        make.width.equalTo(@(30));
        make.height.equalTo(@(30));
    }];
    [leftButton setBackgroundImage:[UIImage imageNamed:@"left_bg"] forState:UIControlStateNormal];
    UIButton *rightButton=[UIButton buttonWithType:UIButtonTypeCustom];
    rightButton.tag=911;
    [superView addSubview:rightButton];
    [rightButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(superView.mas_right).offset(-45);
        make.top.equalTo(superView.mas_top).offset(110);
        make.width.equalTo(@(30));
        make.height.equalTo(@(30));
    }];
    [rightButton setBackgroundImage:[UIImage imageNamed:@"right_bg"] forState:UIControlStateNormal];
    
    UILabel *label=[[UILabel alloc]init];
    NSDate *date=[NSDate date];
    label.tag=912;
    NSString *dataStr1=[date formattedDateWithFormat:@"YYYY/MM/dd HH:mm:ss"];
    NSArray *array=[dataStr1 componentsSeparatedByString:@" "];
    NSString *string=[array firstObject];
    NSArray *lastArray=[string componentsSeparatedByString:@"/"];
    NSString *dataStr=[NSString stringWithFormat:@"%@年%@月%@日",lastArray[0],lastArray[1],lastArray[2]];
    label.text=[YLTimeDeal dealMonthString:dataStr];
    [superView addSubview:label];
    label.textAlignment=NSTextAlignmentCenter;
    label.textColor=[UIColor blackColor];
    label.font=[UIFont boldSystemFontOfSize:18];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(leftButton.mas_right).offset(2);
        make.right.equalTo(rightButton.mas_left).offset(-2);
        make.top.equalTo(superView.mas_top).offset(110);
        make.height.equalTo(@(30));
    }];
    
}
@end
















