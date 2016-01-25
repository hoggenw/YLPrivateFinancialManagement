//
//  YLDatePieChartNeed.m
//  YLPrivateFinancialManagement
//
//  Created by 千锋 on 16/1/22.
//  Copyright (c) 2016年 mobiletrain. All rights reserved.
//

#import "YLDatePieChartNeed.h"
#import "YLPieModel.h"
#import "YLGetModel.h"
#import "YLCostModel.h"
@implementation YLDatePieChartNeed
/**
 *  本月分类收入类别
 */
+(NSArray*)monthClassesGet:(NSString*)month{
    NSDate *monthBegin=[self dealTimeMonth:month];
    NSDate *monthEnd=[monthBegin dateByAddingMonths:1];
    NSArray *dataArray=[[YLDataBaseManager shareManager]selectGetModelFrom:monthBegin to:monthEnd];
    NSMutableArray *needArray=[NSMutableArray array];
    NSArray *CostArray=[YLNsuserD getArrayForKey:@"getArray"];
    NSMutableArray *nameArray=[NSMutableArray array];
    for (int index=0; index<CostArray.count; index++) {
        if (index!=CostArray.count-1) {
            [nameArray addObject:CostArray[index]];
        }
        
    }
    for (int index=0; index<nameArray.count; index++) {
        YLPieModel *model=[[YLPieModel alloc]init];
        model.name=nameArray[index];
        CGFloat kindGet=0;
        for (int i=0; i<dataArray.count; i++) {
            YLGetModel *getModel=[[YLGetModel alloc]init];
            getModel=dataArray[i];
            if ([model.name isEqualToString:getModel.kind]) {
                  kindGet+=[getModel.getMoney doubleValue];
            }
        }
        if (kindGet!=0) {
            model.number=kindGet;
            [needArray addObject:model];
        }
    }
    return [self DESSort: needArray];
}
/**
 *  本月分类支出类别
 */
+(NSArray*)monthClassesCost:(NSString*)month{
    NSDate *monthBegin=[self dealTimeMonth:month];
    NSDate *monthEnd=[monthBegin dateByAddingMonths:1];
    NSArray *dataArray=[[YLDataBaseManager shareManager]selectCostModelFrom:monthBegin to:monthEnd];
    NSMutableArray *needArray=[NSMutableArray array];
    NSArray *CostArray=[YLNsuserD getArrayForKey:@"costArray"];
    NSMutableArray *nameArray=[NSMutableArray array];
    for (int index=0; index<CostArray.count; index++) {
        if (index!=CostArray.count-1) {
            NSDictionary *temp=CostArray[index];
            NSString *string=[[temp allKeys]firstObject];
            [nameArray addObject:string];
        }
    }
    for (int index=0; index<nameArray.count; index++) {
        YLPieModel *model=[[YLPieModel alloc]init];
        model.name=nameArray[index];
        CGFloat kindCost=0;
        for (int i=0; i<dataArray.count; i++) {
            YLCostModel *costModel=[[YLCostModel alloc]init];
            costModel=dataArray[i];
            if ([model.name isEqualToString:costModel.bigClass]) {
                  kindCost+=[costModel.costMoney doubleValue];
            }
        }
        if (kindCost!=0) {
            model.number=kindCost;
            [needArray addObject:model];
        }
    }
    return [self DESSort: needArray];
}
/**
 *  所有本月分类类别
 */
+(NSArray*)monthAllKindsCost:(NSString*)month{
    NSDate *monthBegin=[self dealTimeMonth:month];
    NSDate *monthEnd=[monthBegin dateByAddingMonths:1];
    NSArray *dataArray=[[YLDataBaseManager shareManager]selectCostModelFrom:monthBegin to:monthEnd];
    NSMutableArray *needArray=[NSMutableArray array];
    NSArray *CostArray=[YLNsuserD getArrayForKey:@"costArray"];
    NSMutableArray *nameArray=[NSMutableArray array];
    for (int index=0; index<CostArray.count; index++) {
        if (index!=CostArray.count-1) {
            NSDictionary *temp=CostArray[index];
            NSString *string=[[temp allKeys]firstObject];
            NSArray *names=temp[string];
            for (int i=0; i<names.count-1; i++) {
                [nameArray addObject:names[i]];
            }
        }
    }
    for (int index=0; index<nameArray.count; index++) {
        YLPieModel *model=[[YLPieModel alloc]init];
        model.name=nameArray[index];
        CGFloat kindCost=0;
        for (int i=0; i<dataArray.count; i++) {
            YLCostModel *costModel=[[YLCostModel alloc]init];
            costModel=dataArray[i];
            if ([model.name isEqualToString:costModel.kind]) {
                kindCost+=[costModel.costMoney doubleValue];
            }
        }
        
        if (kindCost!=0) {
            model.number=kindCost;
            [needArray addObject:model];
        }
       
    }
    return [self DESSort: needArray];
}
+(NSDate *)dealTimeMonth:(NSString*)timeString{
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    NSArray *array=[timeString componentsSeparatedByString:@"月"];
    NSString *yearMonth=[array firstObject];
    NSArray *lastArray=[yearMonth componentsSeparatedByString:@"年"];
    
    NSString *string=[NSString stringWithFormat:@"%@-%@-01",lastArray[0],lastArray[1]];
    [formatter setDateFormat:@"YYYY-MM-dd"];
    NSDate *date = [formatter dateFromString:string];
    return date;
}
+(NSArray*)DESSort:(NSArray *)array{
    NSSortDescriptor *peiModelDesc=[NSSortDescriptor sortDescriptorWithKey:@"number" ascending:NO];
    NSArray *descriptorArray = [NSArray arrayWithObjects:peiModelDesc,nil];
    return [array sortedArrayUsingDescriptors:descriptorArray];
    
}
@end
