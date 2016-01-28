//
//  YLDataBaseManager.m
//  YLLimiteFree
//
//  Created by 千锋 on 16/1/8.
//  Copyright (c) 2016年 mobiletrain. All rights reserved.
//

#import "YLDataBaseManager.h"
#import "YLGetModel.h"
#import "YLCostModel.h"
@implementation YLDataBaseManager{
    FMDatabase *_fmdb;
}

-(instancetype)init{
    //1.抛出异常方式
    @throw [NSException exceptionWithName:@"" reason:@"不能用此方法构造" userInfo:nil];
    //2.断言，判定言论,程序崩溃
    //NSAssert(false, @"DataBaseManage无法调用改方法");
    
}
//重新实现初始化方法
-(instancetype)initPrivate{
    if (self=[super init]) {
        [self creatCostDataBase];
    }
    
    return self;
}
+(instancetype)shareManager{
    static YLDataBaseManager *myManager=nil;
    static dispatch_once_t taken;
    dispatch_once(&taken,^{
    if (!myManager) {
        myManager=[[self alloc]initPrivate];
    }
    });

    return myManager;
}
//初始化数据库
-(void)creatCostDataBase{
    //获取沙河路径下的documents路径
    NSArray *documentsPath=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *dbPath=[[documentsPath firstObject]stringByAppendingPathComponent:@"CostDataBase.db"];
  // NSLog(@"DBPATH=%@",dbPath);
    if (!_fmdb) {
        //创建数据库管理对象
        _fmdb=[[FMDatabase alloc]initWithPath:dbPath];
    }
    //打开数据库
    if([_fmdb open]){
        //创建数据库表
        [_fmdb executeUpdate:@"create table if not exists COSTTabel(mainKey date primary key,costMoney not null,bigClass,kind,dateNow,remark);"];
        [_fmdb executeUpdate:@"create table if not exists GETTabel(mainKey date primary key,getMoney not null,kind,dateNow,remark);"];
    }
    
    
}

#pragma mark_增删查
//判断支出对应的数据是否存在
-(BOOL)isExist:(YLCostModel *)model{
    FMResultSet *rs=[_fmdb executeQuery:@"SELECT *FROM COSTTabel WHERE mainKey=?",model.mainKey];
    if ([rs next]) {
        return YES;
    }
    return NO;
}
/**添加支出数据*/
-(BOOL)insertYLCostModel:(YLCostModel *)model{
    if (![self isExist:model]) {
        BOOL success=[_fmdb executeUpdate:@"INSERT into COSTTabel values(?,?,?,?,?,?)",model.mainKey,model.costMoney,model.bigClass,model.kind,model.dateNow,model.remarks];
        return success;
    }
    return YES;
}

/**从数据空中获取所有的数据*/
-(NSArray *)selectCostModelFrom:(NSDate *)firstTimeDate to:(NSDate *)secondTimeDate{
    //从表中获取所有的数据
  FMResultSet *rs=[_fmdb executeQuery:[NSString stringWithFormat:@"select * from COSTTabel where mainKey between '%f' and '%f'",[firstTimeDate timeIntervalSince1970],[secondTimeDate timeIntervalSince1970]]];
    //遍历结果集
    NSMutableArray *models=[NSMutableArray array];
    while ([rs next]) {
        YLCostModel * model = [[YLCostModel alloc] init];
        model.mainKey =[rs dateForColumn: @"mainKey"];
        model.costMoney=[rs stringForColumn:@"costMoney"];
        model.bigClass=[rs stringForColumn:@"bigClass"];
        model.kind=[rs stringForColumn:@"kind"];
        model.dateNow=[rs stringForColumn:@"dateNow"];
        model.remarks=[rs stringForColumn:@"remark"];
        [models addObject:model];
    }
    return [models copy];
}
/**删除数据库中指定支出数据*/
-(BOOL)deletYLCostModel:(YLCostModel *)model{
  BOOL success =[ _fmdb executeUpdate:@"DELETE from COSTTabel where mainKey=?",model.mainKey ];
    return success;
}

/**判断收入数据是否已经存在*/
-(BOOL)isGetExist:(YLGetModel *)model{
    FMResultSet *rs=[_fmdb executeQuery:@"select *from GETTabel WHERE mainKey=?",model.mainKey];
    if ([rs next]) {
        return YES;
    }
    return NO;
    
}
/**添加收入数据*/
-(BOOL)insertYLGetModel:(YLGetModel *)model{
    if (![self isGetExist:model]) {
      BOOL  success=[_fmdb executeUpdate:@"insert into GETTabel values(?,?,?,?,?)",model.mainKey,model.getMoney,model.kind,model.dateNow,model.remarks];
        return success;
    }
    return YES;
}
/**从数据空中获取所有的收入数据*/
-(NSArray *)selectGetModelFrom:(NSDate *)firstTimeDate to:(NSDate *)secondTimeDate{
    //从表中获取所要的数据
    FMResultSet *rs=[_fmdb executeQuery:[NSString stringWithFormat:@"select * from GETTabel where mainKey between '%f' and '%f'",[firstTimeDate timeIntervalSince1970],[secondTimeDate timeIntervalSince1970]]];
    NSMutableArray *models=[NSMutableArray array];
    while ([rs next]) {
        YLGetModel *model=[[YLGetModel alloc]init];
        model.mainKey=[rs dateForColumn:@"mainKey"];
        model.getMoney=[rs stringForColumn:@"getMoney"];
        model.kind=[rs stringForColumn:@"kind"];
        model.dateNow=[rs  stringForColumn:@"dateNow"];
        model.remarks=[rs stringForColumn:@"remark"];
        [models addObject:model];
    }
    return [models copy];
}
/**删除数据库中指定收入数据*/
-(BOOL)deletYLGetModel:(YLGetModel *)model{
    BOOL success=[_fmdb executeUpdate:@"delete from GETTabel where mainKey=?",model.mainKey];
    return success;
}
/**数据库花费数据按时间降序排列*/
-(NSArray *)selectCostModelByDESC{
    //从表中获取所有的数据
    FMResultSet *rs=[_fmdb executeQuery:@"select * from COSTTabel ORDER BY mainKey DESC"];
    //遍历结果集
    NSMutableArray *models=[NSMutableArray array];
    while ([rs next]) {
        YLCostModel * model = [[YLCostModel alloc] init];
        model.mainKey =[rs dateForColumn: @"mainKey"];
        model.costMoney=[rs stringForColumn:@"costMoney"];
        model.bigClass=[rs stringForColumn:@"bigClass"];
        model.kind=[rs stringForColumn:@"kind"];
        model.dateNow=[rs stringForColumn:@"dateNow"];
        model.remarks=[rs stringForColumn:@"remark"];
        [models addObject:model];
    }
    return [models copy];
}
/**数据库收入数据按时间降序排列*/
-(NSArray *)selectGetModelByDESC{
    //从表中获取所要的数据
      FMResultSet *rs=[_fmdb executeQuery:@"select * from GETTabel ORDER BY mainKey DESC"];
    NSMutableArray *models=[NSMutableArray array];
    while ([rs next]) {
        YLGetModel *model=[[YLGetModel alloc]init];
        model.mainKey=[rs dateForColumn:@"mainKey"];
        model.getMoney=[rs stringForColumn:@"getMoney"];
        model.kind=[rs stringForColumn:@"kind"];
        model.dateNow=[rs  stringForColumn:@"dateNow"];
        model.remarks=[rs stringForColumn:@"remark"];
        [models addObject:model];
    }
    return [models copy];
}
/**根据种类名称获得支出数据*/
-(NSArray *)selectCostModelByName:(NSString *)name{
    //从表中获取所有的数据
    FMResultSet *rs=[_fmdb executeQuery:[NSString stringWithFormat:@"select * from COSTTabel where bigClass='%@'",name]];
    //遍历结果集
    NSMutableArray *models=[NSMutableArray array];
    while ([rs next]) {
        YLCostModel * model = [[YLCostModel alloc] init];
        model.mainKey =[rs dateForColumn: @"mainKey"];
        model.costMoney=[rs stringForColumn:@"costMoney"];
        model.bigClass=[rs stringForColumn:@"bigClass"];
        model.kind=[rs stringForColumn:@"kind"];
        model.dateNow=[rs stringForColumn:@"dateNow"];
        model.remarks=[rs stringForColumn:@"remark"];
        [models addObject:model];
    }
    return [models copy];
}
/**根据种类名称获得收入数据*/
-(NSArray *)selectGetModelByName:(NSString *)name{
    //从表中获取所有的数据
    FMResultSet *rs=[_fmdb executeQuery:[NSString stringWithFormat:@"select * from GETTabel where kind='%@'",name]];
    //遍历结果集
    NSMutableArray *models=[NSMutableArray array];
    while ([rs next]) {
        YLGetModel *model=[[YLGetModel alloc]init];
        model.mainKey=[rs dateForColumn:@"mainKey"];
        model.getMoney=[rs stringForColumn:@"getMoney"];
        model.kind=[rs stringForColumn:@"kind"];
        model.dateNow=[rs  stringForColumn:@"dateNow"];
        model.remarks=[rs stringForColumn:@"remark"];
        [models addObject:model];
    }
    return [models copy];
}
/**按照种类名称删除收入数据*/
-(BOOL)deletYLGetDataByKind:(NSString *)name{
    BOOL success=[_fmdb executeUpdate:@"delete from GETTabel where kind=?",name];
    return success;
}
/**按照大类名称删除支出数据*/
-(BOOL)deletYLCostDataByClass:(NSString *)name{
    BOOL success =[ _fmdb executeUpdate:@"DELETE from COSTTabel where bigClass=?",name ];
    return success;
}
/**按照种类名称删除支出数据*/
-(BOOL)deletYLCostDataByKind:(NSString *)name{
    BOOL success =[ _fmdb executeUpdate:@"DELETE from COSTTabel where kind=?",name];
    return success;
}
@end





























