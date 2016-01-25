//
//  YLDetailView.h
//  YLPrivateFinancialManagement
//
//  Created by 千锋 on 16/1/20.
//  Copyright (c) 2016年 mobiletrain. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YLDetailView : UIView
/**
 *  创建两个按钮，分别是支出和收入
 */
-(void)creatTwoButtonForDetailView:(UIView *)superView nameArray:(NSArray *)nameArray;
/**
 *  创建四个按钮，分别是按日分类，按月分类，和按年分类，按类别分类
 */
-(void)creatFourKindsButtonForDetailView:(UIView *)superView nameArray:(NSArray *)nameArray;
@end
