//
//  AppDelegate.m
//  YLPrivateFinancialManagement
//
//  Created by 千锋 on 16/1/5.
//  Copyright (c) 2016年 mobiletrain. All rights reserved.
//

#import "AppDelegate.h"
#import "YLMainViewController.h"
#import "YLLetfViewController.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
     UINavigationController *navi=[[UINavigationController alloc]initWithRootViewController:[[YLMainViewController alloc]init]];
    YLLetfViewController *leftVc=[[YLLetfViewController alloc]init];
    RESideMenu *sideMenuViewController=[[RESideMenu alloc]initWithContentViewController:navi leftMenuViewController:leftVc rightMenuViewController:nil];
    sideMenuViewController.parallaxEnabled = NO;
    sideMenuViewController.scaleContentView = YES;
    sideMenuViewController.contentViewScaleValue = 0.98;
    sideMenuViewController.scaleMenuView = NO;
    sideMenuViewController.contentViewShadowEnabled = YES;
    sideMenuViewController.contentViewShadowRadius = 4.5;
    NSUserDefaults *useDef=[NSUserDefaults standardUserDefaults];
    BOOL isFirstIn=[useDef boolForKey:@"isFirstIn"];
    if (!isFirstIn) {
        isFirstIn=YES;
        NSUserDefaults *userDef=[NSUserDefaults standardUserDefaults];
        [userDef setBool:isFirstIn forKey:@"isFirstIn"];
        [userDef synchronize];
        NSDictionary *Dict1=@{@"餐饮支出":@[@"餐费",@"水果饮料",@"零食",@"购买食材",@"油盐酱醋",@"点击新增项目+"],};
        NSDictionary *Dict2=@{@"交通支出":@[@"加油",@"停车费",@"火车飞机",@"公共交通",@"过路费",@"车贷",@"罚款",@"点击新增项目+"]};
        NSDictionary *Dict3=@{@"购物支出":@[@"衣服帽子包包",@"电子数码",@"首饰珠宝",@"书籍",@"电器家居",@"点击新增项目+"]};
        NSDictionary *Dict4=@{@"娱乐支出":@[@"棋牌麻将",@"茶酒咖啡",@"聚会聚餐",@"运动健身",@"卡拉OK",@"点击新增项目+"]};
        NSDictionary *Dict5=@{@"医教支出":@[@"医药花费",@"培训考试",@"保险支出",@"点击新增项目+"]};
        NSDictionary *Dict6=@{@"人情支出":@[@"礼金红包",@"请客",@"孝敬父母",@"捐款",@"赠与",@"点击新增项目+"]};
        NSDictionary *Dict7=@{@"居家支出":@[@"电话费",@"房贷房租",@"水电燃气",@"化妆美容",@"物业",@"其他杂费",@"点击新增项目+"]};
        NSDictionary *dict8=@{@"点击新增内容+":@[@"点击新增项目+"]};
        NSArray *costArray=@[Dict1,Dict2,Dict3,Dict4,Dict5,Dict6,Dict7,dict8];
        [YLNsuserD saveArray:costArray forKey:@"costArray"];
        NSArray  *getArray=@[@"工资薪水",@"奖金",@"兼职外快",@"福利补贴",@"礼金红包",@"利息",@"基金股票",@"盈利",@"其他",@"点击新增项目+"];
        [YLNsuserD saveArray:getArray forKey:@"getArray"];
        
    }else{
        
    }
    _window.rootViewController=sideMenuViewController;;
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
