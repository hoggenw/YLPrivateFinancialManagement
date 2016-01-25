//
//  YLTimeDeal.m
//  YLPrivateFinancialManagement
//
//  Created by 千锋 on 16/1/18.
//  Copyright (c) 2016年 mobiletrain. All rights reserved.
//

#import "YLTimeDeal.h"
#import "YLCostModel.h"
#import "YLGetModel.h"
@implementation YLTimeDeal


/**处理月时间日期*/
+(NSDate*)dealTimeDate:(NSDate *)dateTime{
    
    NSInteger year=dateTime.year;
    NSInteger month=dateTime.month;
    NSString *timeString=[NSString stringWithFormat:@"%ld-%ld-01 00:00:00",(long)year,(long)month];
    NSDateFormatter *formatter=[[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    NSDate *needDate=[formatter dateFromString:timeString];
    return needDate;
}
/**处理日时间日期*/
+(NSDate *)dealDayTimeDate:(NSDate *)dateTime{
    NSInteger year=dateTime.year;
    NSInteger month=dateTime.month;
    NSInteger day=dateTime.day;
    NSString *timeString=[NSString stringWithFormat:@"%ld-%ld-%ld 00:00:00",(long)year,(long)month,(long)day];
    NSDateFormatter *formatter=[[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    NSDate *needDate=[formatter dateFromString:timeString];
    return needDate;
}
/**处理年时间日期*/
+(NSDate *)dealYearTimeDate:(NSDate *)dateTime{
    NSInteger year=dateTime.year;
    NSString *timeString=[NSString stringWithFormat:@"%ld-01-01 00:00:00",(long)year];
    NSDateFormatter *formatter=[[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    NSDate *needDate=[formatter dateFromString:timeString];
    return needDate;
}
//==============================加上时间约束================
//目前花费的总数date formattedDateWithFormat:@"YYYY/MM/dd HH:mm:ss"
+(CGFloat)costThisMonthTotal{
    //字符串时间转换
    CGFloat costNow=0;
    //获取现在时间
    NSDate *date=[NSDate date];
    NSDate *nextMonthDate=[date dateByAddingMonths:1];
    NSDate *thisMonthBegin=[YLTimeDeal dealTimeDate:date];
    NSDate *thisMonthEnd=[YLTimeDeal dealTimeDate:nextMonthDate];
    //拼接本月时间
    YLDataBaseManager *manager=[YLDataBaseManager shareManager];
    NSArray *costArray=[manager selectCostModelFrom:thisMonthBegin to:thisMonthEnd];
    for (YLCostModel *model in costArray) {
        costNow+=[model.costMoney doubleValue];
    }
    return costNow;
}
/**本月总共收入*/
+(CGFloat)getThisMonthTotal{
    //字符串时间转换
    CGFloat costNow=0;
    //获取现在时间
    NSDate *date=[NSDate date];
    NSDate *nextMonthDate=[date dateByAddingMonths:1];
    NSDate *thisMonthBegin=[YLTimeDeal dealTimeDate:date];
    NSDate *thisMonthEnd=[YLTimeDeal dealTimeDate:nextMonthDate];
    //拼接本月时间
    YLDataBaseManager *manager=[YLDataBaseManager shareManager];
    NSArray *getArray=[manager selectGetModelFrom:thisMonthBegin to:thisMonthEnd];
    for (YLGetModel *model in getArray) {
        costNow+=[model.getMoney doubleValue];
    }
    return costNow;
}
/**本周总共支出*/
+(CGFloat)costWeekNowTotal{
    CGFloat costNowTotal=0;
    NSDate * date = [NSDate date];
    NSDate  *weekBigen=[date dateBySubtractingDays:date.weekdayOrdinal];
    NSDate  *weekEnd=[weekBigen dateByAddingDays:7];
    NSDate  *thisWeekB=[YLTimeDeal dealDayTimeDate:weekBigen];
    NSDate  *thisWeekEnd=[YLTimeDeal dealDayTimeDate:weekEnd];
    YLDataBaseManager *manager=[YLDataBaseManager shareManager];
    NSArray *costArray=[manager selectCostModelFrom:thisWeekB to:thisWeekEnd];
    for (YLCostModel *model in costArray) {
        costNowTotal+=[model.costMoney doubleValue];
    }
    return costNowTotal;
  
}
/**本周总共收入*/
+(CGFloat)getWeekNowTotal{
    CGFloat getNow=0;
    NSDate * date = [NSDate date];
    NSDate  *weekBigen=[date dateBySubtractingDays:date.weekdayOrdinal];
    NSDate  *weekEnd=[weekBigen dateByAddingDays:7];
    NSDate  *thisWeekB=[YLTimeDeal dealDayTimeDate:weekBigen];
    NSDate  *thisWeekEnd=[YLTimeDeal dealDayTimeDate:weekEnd];
    YLDataBaseManager *manager=[YLDataBaseManager shareManager];
    NSArray *getArray=[manager selectGetModelFrom:thisWeekB to:thisWeekEnd];
    for (YLGetModel *model in getArray) {
        getNow+=[model.getMoney doubleValue];
    }
    return getNow;
}
//今日支出
+(CGFloat)costTadayNowTotal{
    CGFloat costNowTotal=0;
    NSDate *date=[NSDate date];
    NSDate *nextDate=[date dateByAddingDays:1];
    NSDate *thisDay=[YLTimeDeal dealDayTimeDate:date];
    NSDate *thisDayEnd=[YLTimeDeal dealDayTimeDate:nextDate];
     YLDataBaseManager *manager=[YLDataBaseManager shareManager];
    NSArray *costArray=[manager selectCostModelFrom:thisDay to:thisDayEnd];
    for (YLCostModel *model in costArray) {
        costNowTotal+=[model.costMoney doubleValue];
    }
    return costNowTotal;
}
//今日收入
+(CGFloat)getTadayNowTotal{
    CGFloat costNowTotal=0;
    NSDate *date=[NSDate date];
    NSDate *nextDate=[date dateByAddingDays:1];
    NSDate *thisDay=[YLTimeDeal dealDayTimeDate:date];
    NSDate *thisDayEnd=[YLTimeDeal dealDayTimeDate:nextDate];
    YLDataBaseManager *manager=[YLDataBaseManager shareManager];
    NSArray *getArray=[manager selectGetModelFrom:thisDay to:thisDayEnd];
    for (YLGetModel *model in getArray) {
        costNowTotal+=[model.getMoney doubleValue];
    }
    return costNowTotal;
}
//计算今年的总收入
+(CGFloat)getThisYearTotal{
    //字符串时间转换
    CGFloat getNow=0;
    //获取现在时间
    NSDate *date=[NSDate date];
    NSDate *nextYearDate=[date dateByAddingYears:1];
    NSDate *thisYearBegin=[YLTimeDeal dealTimeDate:date];
    NSDate *thisYearEnd=[YLTimeDeal dealTimeDate:nextYearDate];
    //拼接本年时间
    YLDataBaseManager *manager=[YLDataBaseManager shareManager];
    NSArray *getArray=[manager selectGetModelFrom:thisYearBegin to:thisYearEnd];
    for (YLGetModel *model in getArray) {
        getNow+=[model.getMoney doubleValue];
    }
    return getNow;
}
//计算今年的总支出
+(CGFloat)costThisYearTotal{
    //字符串时间转换
    CGFloat costNow=0;
    //获取现在时间
    NSDate *date=[NSDate date];
    NSDate *nextYearDate=[date dateByAddingYears:1];
    NSDate *thisYearBegin=[YLTimeDeal dealTimeDate:date];
    NSDate *thisYearEnd=[YLTimeDeal dealTimeDate:nextYearDate];
    //拼接本年时间
    YLDataBaseManager *manager=[YLDataBaseManager shareManager];
    NSArray *costArray=[manager selectCostModelFrom:thisYearBegin to:thisYearEnd];
    for (YLCostModel *model in costArray) {
        costNow+=[model.costMoney doubleValue];
    }
    return costNow;
}
/**
 *  字符串处理日期
 */
+(NSString *)dealString:(NSString *)dateString{
    NSArray *array=[dateString componentsSeparatedByString:@" "];
    return [array firstObject];
}
/**处理比较的月时间*/
+(NSString *)dealMonthString:(NSString*)monthString{
    NSArray *array=[monthString componentsSeparatedByString:@"月"];
    return [NSString stringWithFormat:@"%@月",[array firstObject]];
}
@end
