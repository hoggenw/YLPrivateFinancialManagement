//
//  YLDataBaseManager.h
//  YLLimiteFree
//
//  Created by 千锋 on 16/1/8.
//  Copyright (c) 2016年 mobiletrain. All rights reserved.
//

#import <Foundation/Foundation.h>
@class YLCostModel;
@class YLGetModel;
@interface YLDataBaseManager : NSObject
/**单例*/
+(instancetype)shareManager;

/**判断支出数据是否已经存在*/
-(BOOL)isExist:(YLCostModel *)model;
/**添加支出数据*/
-(BOOL)insertYLCostModel:(YLCostModel *)model;
/**从数据空中获取所要的支出数据*/
-(NSArray *)selectCostModelFrom:(NSDate *)firstTimeDate to:(NSDate*)secondTimeDate;
/**删除数据库中指定支出数据*/
-(BOOL)deletYLCostModel:(YLCostModel *)model;


/**判断收入数据是否已经存在*/
-(BOOL)isGetExist:(YLGetModel *)model;
/**添加收入数据*/
-(BOOL)insertYLGetModel:(YLGetModel *)model;
/**从数据空中获取所要的收入数据*/
-(NSArray *)selectGetModelFrom:(NSDate *)firstTimeDate to:(NSDate *)secondTimeDate;
/**删除数据库中指定收入数据*/
-(BOOL)deletYLGetModel:(YLGetModel *)model;
/**数据库花费数据按时间降序排列*/
-(NSArray *)selectCostModelByDESC;
/**数据库收入数据按时间降序排列*/
-(NSArray *)selectGetModelByDESC;
/**根据种类名称获得支出数据*/
-(NSArray *)selectCostModelByName:(NSString *)name;
/**根据种类名称获得收入数据*/
-(NSArray *)selectGetModelByName:(NSString *)name;
/**按照种类名称删除收入数据*/
-(BOOL)deletYLGetDataByKind:(NSString *)name;
/**按照大类名称删除支出数据*/
-(BOOL)deletYLCostDataByClass:(NSString *)name;
/**按照种类名称删除支出数据*/
-(BOOL)deletYLCostDataByKind:(NSString *)name;
@end
