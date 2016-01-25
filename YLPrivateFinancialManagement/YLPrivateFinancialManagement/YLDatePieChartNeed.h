//
//  YLDatePieChartNeed.h
//  YLPrivateFinancialManagement
//
//  Created by 千锋 on 16/1/22.
//  Copyright (c) 2016年 mobiletrain. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YLDatePieChartNeed : NSObject
/**
 *  本月分类收入类别
 */
+(NSArray*)monthClassesGet:(NSString*)month;
/**
 *  本月分类支出类别
 */
+(NSArray*)monthClassesCost:(NSString*)month;
/**
 *  所有本月分类类别
 */
+(NSArray*)monthAllKindsCost:(NSString*)month;
@end
