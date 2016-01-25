//
//  YLDataDeal.h
//  YLPrivateFinancialManagement
//
//  Created by 千锋 on 16/1/21.
//  Copyright (c) 2016年 mobiletrain. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YLDataDeal : NSObject
/**单例*/
+(instancetype)shareDataDeal;
/**
 *  支出按日排序
 */
+(NSArray *)costTotalByDay;
/**
 *  按月支出排序数组
 */
+(NSArray *)costTotalByMonth;
/**
 *  按种类支出排序
 */
+(NSArray *)costTotalByKinds;
/**
 *  收入按日排序
 */
+(NSArray *)getTotalByDay;
/**
 *  收入按月排序
 */
+(NSArray *)getTotalByMonth;
/**
 *  按种类收入
 */
+(NSArray *)getTotalByKinds;
@end
