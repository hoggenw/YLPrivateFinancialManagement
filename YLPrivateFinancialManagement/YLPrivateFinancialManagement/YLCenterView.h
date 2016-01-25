//
//  YLCenterView.h
//  YLPrivateFinancialManagement
//
//  Created by 千锋 on 16/1/7.
//  Copyright (c) 2016年 mobiletrain. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YLCenterView : UIView
@property(nonatomic,assign)CGFloat todayCost;
@property(nonatomic,assign)CGFloat todayGet;

-(void)creatCenterView:(UIView *)superView target:(id)taget action:(SEL)selector;
@end
