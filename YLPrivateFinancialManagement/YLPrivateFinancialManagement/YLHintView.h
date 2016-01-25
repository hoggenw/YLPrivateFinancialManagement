//
//  YLHintView.h
//  YL老师答题系统
//
//  Created by 千锋 on 15/12/2.
//  Copyright (c) 2015年 mobiletrain. All rights reserved.
//

#import <UIKit/UIKit.h>
/**
 *  提示视图
 */
@interface YLHintView : UIView{
    NSTimer *timer;
    UILabel *hintLabel;
}
/**提示信息*/
@property(nonatomic,copy)NSString *message;
/**
 *  在指定的父视图上显示提示视图并指定时间间隔
 *
 *  @param interval 时间
 */

-(void)showOnView:(UIView*)parentView ForTimeInterval:(NSTimeInterval)interval;
@end
