//
//  YLTimeDeal.h
//  YLPrivateFinancialManagement
//
//  Created by 千锋 on 16/1/18.
//  Copyright (c) 2016年 mobiletrain. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YLTimeDeal : NSObject
/**处理月时间日期*/
+(NSDate *)dealTimeDate:(NSDate *)dateTime;

/**处理日时间日期*/
+(NSDate *)dealDayTimeDate:(NSDate *)dateTime;
/**处理年时间日期*/
+(NSDate *)dealYearTimeDate:(NSDate *)dateTime;
/**本月总共花费*/
+(CGFloat)costThisMonthTotal;
/**本月总共收入*/
+(CGFloat)getThisMonthTotal;
/**本日总共花费*/
+(CGFloat)costTadayNowTotal;
/**本日总共收入*/
+(CGFloat)getTadayNowTotal;
/**本周总共支出*/
+(CGFloat)costWeekNowTotal;
/**本周总共收入*/
+(CGFloat)getWeekNowTotal;
/**本年总共收入*/
+(CGFloat)getThisYearTotal;
/**计算今年的总支出*/
+(CGFloat)costThisYearTotal;
+(NSString *)dealString:(NSString *)dateString;
/**处理比较的月时间*/
+(NSString *)dealMonthString:(NSString*)monthString;
@end
