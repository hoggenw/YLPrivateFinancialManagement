//
//  YLCostVew.h
//  YLPrivateFinancialManagement
//
//  Created by 千锋 on 16/1/20.
//  Copyright (c) 2016年 mobiletrain. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YLCostVew : UIView
/**建造总支出或者收入的label*/
-(void)totalCostOrGetLabel:(UIView *)superView name:(NSString *)name total:(CGFloat)total;
/**建造日支出的视图*/
-(void)creatDayCostOrGetView:(UIView *)superView name:(NSString *)name total:(CGFloat)total;
/**建造周支出的视图*/
-(void)creatWeekCostOrGetView:(UIView *)superView name:(NSString *)name total:(CGFloat)total;
/**建造月支出的视图*/
-(void)creatMonthCostOrGetView:(UIView *)superView name:(NSString *)name total:(CGFloat)total;
/**创建5个按钮*/
-(void)creatFiveButtonForCostOrGetView:(UIView *)superView nameArray:(NSArray *)nameArray;
@end
