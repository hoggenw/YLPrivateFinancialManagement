//
//  YLDataDeal.m
//  YLPrivateFinancialManagement
//
//  Created by 千锋 on 16/1/21.
//  Copyright (c) 2016年 mobiletrain. All rights reserved.
//

#import "YLDataDeal.h"
#import "YLCostButton.h"
#import "YLBudgeModel.h"
#import "YLCostModel.h"
#import "YLGetModel.h"
@implementation YLDataDeal
-(instancetype)init{
    //1.抛出异常方式
    @throw [NSException exceptionWithName:@"" reason:@"不能用此方法构造" userInfo:nil];
    
}
-(instancetype)initPrivate{
    if (self=[super init]) {
    }
    
    return self;
}
+(instancetype)shareDataDeal{
    static YLDataDeal *myManager=nil;
    static dispatch_once_t taken;
    dispatch_once(&taken,^{
        if (!myManager) {
            myManager=[[self alloc]initPrivate];
        }
    });
    
    return myManager;
}
+(NSArray *)getTotalByDay{
    NSArray *dataFromSQLArray=[[YLDataBaseManager shareManager]selectGetModelByDESC];
    NSMutableArray *needArray=[NSMutableArray array];
    CGFloat dayCost=0;
    NSString *name=[NSString string];
    YLGetModel *getModel1=[[YLGetModel alloc]init];
    if (dataFromSQLArray.count!=0) {
        getModel1=dataFromSQLArray[0];
    }
    
    if (getModel1.dateNow==nil) {
        return needArray;
    }else{
        name=[YLTimeDeal dealString:getModel1.dateNow];
        for (int index=0; index<dataFromSQLArray.count; index++) {
            YLGetModel *getModel=[[YLGetModel alloc]init];
            getModel=dataFromSQLArray[index];
            if ([[YLTimeDeal dealString:getModel.dateNow]isEqualToString:name]) {
                dayCost+=[getModel.getMoney doubleValue];
                if (dataFromSQLArray.count==index+1) {
                    YLBudgeModel *model=[[YLBudgeModel alloc]init];
                    model.name=name;
                    model.budget=[NSString stringWithFormat:@"%.1lf",dayCost];
                    model.surplus=@"收入";
                    [needArray addObject:model];
                }
            }else{
                YLBudgeModel *model=[[YLBudgeModel alloc]init];
                model.name=name;
                model.budget=[NSString stringWithFormat:@"%.1lf",dayCost];
                model.surplus=@"收入";
                [needArray addObject:model];
                name=nil;
                name=[YLTimeDeal dealString:getModel.dateNow];
                dayCost=0;
                dayCost+=[getModel.getMoney doubleValue];
                if (dataFromSQLArray.count==index+1) {
                    YLBudgeModel *model=[[YLBudgeModel alloc]init];
                    model.name=name;
                    model.budget=[NSString stringWithFormat:@"%.1lf",dayCost];
                    model.surplus=@"收入";
                    [needArray addObject:model];
                }
            }
        }
    }
    return [needArray copy];
}
/**
 *  收入按月排序
 */
+(NSArray *)getTotalByMonth{
    NSArray *dataFromSQLArray=[[YLDataBaseManager shareManager]selectGetModelByDESC];
    NSMutableArray *needArray=[NSMutableArray array];
    CGFloat dayCost=0;
    NSString *name=[NSString string];
    YLGetModel *getModel1=[[YLGetModel alloc]init];
    if (dataFromSQLArray.count!=0) {
         getModel1=dataFromSQLArray[0];
    }
   
    if (getModel1.dateNow==nil) {
        return needArray;
    }else{
        name=[YLTimeDeal dealMonthString:getModel1.dateNow];
        for (int index=0; index<dataFromSQLArray.count; index++) {
            YLGetModel *getModel=[[YLGetModel alloc]init];
            getModel=dataFromSQLArray[index];
            if ([[YLTimeDeal dealMonthString:getModel.dateNow]isEqualToString:name]) {
                dayCost+=[getModel.getMoney doubleValue];
                if (dataFromSQLArray.count==index+1) {
                    YLBudgeModel *model=[[YLBudgeModel alloc]init];
                    model.name=name;
                    model.budget=[NSString stringWithFormat:@"%.1lf",dayCost];
                    model.surplus=@"收入";
                    [needArray addObject:model];
                }
            }else{
                YLBudgeModel *model=[[YLBudgeModel alloc]init];
                model.name=name;
                model.budget=[NSString stringWithFormat:@"%.1lf",dayCost];
                model.surplus=@"收入";
                [needArray addObject:model];
                name=nil;
                name=[YLTimeDeal dealMonthString:getModel.dateNow];
                dayCost=0;
                dayCost+=[getModel.getMoney doubleValue];
                if (dataFromSQLArray.count==index+1) {
                    YLBudgeModel *model=[[YLBudgeModel alloc]init];
                    model.name=name;
                    model.budget=[NSString stringWithFormat:@"%.1lf",dayCost];
                    model.surplus=@"收入";
                    [needArray addObject:model];
                }
            }
        }
    }
    return [needArray copy];
}
/**
 *  按种类收入
 */
+(NSArray *)getTotalByKinds{
    NSMutableArray *needArray=[NSMutableArray array];
    NSArray *CostArray=[YLNsuserD getArrayForKey:@"getArray"];
    NSMutableArray *nameArray=[NSMutableArray array];
    for (int index=0; index<CostArray.count; index++) {
        if (index!=CostArray.count-1) {
            [nameArray addObject:CostArray[index]];
        }
        
    }
    for (int index=0; index<nameArray.count; index++) {
        YLBudgeModel *model=[[YLBudgeModel alloc]init];
        model.name=nameArray[index];
        CGFloat kindGet=0;
        NSArray *kindArray=[[YLDataBaseManager shareManager]selectGetModelByName:model.name];
        for (int i=0; i<kindArray.count; i++) {
            YLGetModel *costModel=[[YLGetModel alloc]init];
            costModel=kindArray[i];
            kindGet+=[costModel.getMoney doubleValue];
        }
        model.budget=[NSString stringWithFormat:@"%.1lf",kindGet];
        model.surplus=@"收入";
        [needArray addObject:model];
    }
    return needArray;
}
/**
 *  支出按日排序
 */
+(NSArray *)costTotalByDay{
    NSArray *dataFromSQLArray=[[YLDataBaseManager shareManager]selectCostModelByDESC];
    NSMutableArray *needArray=[NSMutableArray array];
    CGFloat dayCost=0;
    NSString *name=[NSString string];
    YLCostModel *costModel1=[[YLCostModel alloc]init];
    if (dataFromSQLArray.count!=0) {
        costModel1=dataFromSQLArray[0];
    }
    if (costModel1.dateNow==nil) {
        return needArray;
    }else{
        name=[YLTimeDeal dealString:costModel1.dateNow];
    for (int index=0; index<dataFromSQLArray.count; index++) {
        YLCostModel *costModel=[[YLCostModel alloc]init];
        costModel=dataFromSQLArray[index];
        if ([[YLTimeDeal dealString:costModel.dateNow]isEqualToString:name]) {
            dayCost+=[costModel.costMoney doubleValue];
            if (dataFromSQLArray.count==index+1) {
                YLBudgeModel *model=[[YLBudgeModel alloc]init];
                model.name=name;
                model.budget=[NSString stringWithFormat:@"%.1lf",dayCost];
                model.surplus=@"支出";
                [needArray addObject:model];
            }
        }else{
            YLBudgeModel *model=[[YLBudgeModel alloc]init];
            model.name=name;
            model.budget=[NSString stringWithFormat:@"%.1lf",dayCost];
            model.surplus=@"支出";
            [needArray addObject:model];
            
            name=nil;
            name=[YLTimeDeal dealString:costModel.dateNow];
            dayCost=0;
            dayCost+=[costModel.costMoney doubleValue];
            if (dataFromSQLArray.count==index+1) {
                YLBudgeModel *model=[[YLBudgeModel alloc]init];
                model.name=name;
                model.budget=[NSString stringWithFormat:@"%.1lf",dayCost];
                model.surplus=@"支出";
                [needArray addObject:model];
            }
        }
    }
    }
    return [needArray copy];
}
/**
 *  按月支出排序数组
 */
+(NSArray *)costTotalByMonth{
    NSArray *dataFromSQLArray=[[YLDataBaseManager shareManager]selectCostModelByDESC];
    NSMutableArray *needArray=[NSMutableArray array];
    CGFloat dayCost=0;
    NSString *name=[NSString string];
    YLCostModel *costModel1=[[YLCostModel alloc]init];
    if (dataFromSQLArray.count!=0) {
        costModel1=dataFromSQLArray[0];
    }
    
    if (costModel1.dateNow==nil) {
        return needArray;
    }else{
        name=[YLTimeDeal dealMonthString:costModel1.dateNow];
        for (int index=0; index<dataFromSQLArray.count; index++) {
            YLCostModel *costModel=[[YLCostModel alloc]init];
            costModel=dataFromSQLArray[index];
            if ([[YLTimeDeal dealMonthString:costModel.dateNow]isEqualToString:name]) {
                dayCost+=[costModel.costMoney doubleValue];
                if (dataFromSQLArray.count==index+1) {
                    YLBudgeModel *model=[[YLBudgeModel alloc]init];
                    model.name=name;
                    model.budget=[NSString stringWithFormat:@"%.1lf",dayCost];
                    model.surplus=@"支出";
                    [needArray addObject:model];
                }
            }else{
                YLBudgeModel *model=[[YLBudgeModel alloc]init];
                model.name=name;
                model.budget=[NSString stringWithFormat:@"%.1lf",dayCost];
                model.surplus=@"支出";
                [needArray addObject:model];
                
                name=nil;
                name=[YLTimeDeal dealMonthString:costModel.dateNow];
                dayCost=0;
                dayCost+=[costModel.costMoney doubleValue];
                if (dataFromSQLArray.count==index+1) {
                    YLBudgeModel *model=[[YLBudgeModel alloc]init];
                    model.name=name;
                    model.budget=[NSString stringWithFormat:@"%.1lf",dayCost];
                    model.surplus=@"支出";
                    [needArray addObject:model];
                }
            }
        }
    }
    return needArray;
}
/**
 *  按种类支出排序
 */
+(NSArray *)costTotalByKinds{
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
        YLBudgeModel *model=[[YLBudgeModel alloc]init];
        model.name=nameArray[index];
        CGFloat kindCost=0;
        NSArray *kindArray=[[YLDataBaseManager shareManager]selectCostModelByName:model.name];
        for (int i=0; i<kindArray.count; i++) {
            YLCostModel *costModel=[[YLCostModel alloc]init];
            costModel=kindArray[i];
            kindCost+=[costModel.costMoney doubleValue];
        }
        model.budget=[NSString stringWithFormat:@"%.1lf",kindCost];
        model.surplus=@"支出";
        [needArray addObject:model];
    }
    return needArray;
}
@end














































