//
//  YLPieReportView.h
//  YLPrivateFinancialManagement
//
//  Created by 千锋 on 16/1/21.
//  Copyright (c) 2016年 mobiletrain. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YLPieReportView : UIView
/**
 *  创建两个按钮，分别是支出和收入
 */
-(void)creatTwoButtonForReportView:(UIView *)superView nameArray:(NSArray *)nameArray;
/**
 *  创建选着显示图标
 */
-(void)creatChooseTimeView:(UIView *)superView ;
/**
 *  创建支出图形显示的分类按钮
 */
-(void)creatChooseKindButtonView:(UIView *)superView nameArray:(NSArray *)nameArray;
@end
