//
//  YLNsuserD.h
//  YLPrivateFinancialManagement
//
//  Created by 千锋 on 16/1/12.
//  Copyright (c) 2016年 mobiletrain. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YLNsuserD : NSObject
/**判断输入数字是否合法*/
+(NSString *)judgeNumberIfRight:(NSString*)oringeStting addString:(NSString *)string;
/**
 *字典本地化存储
 */
+(void)saveDictionary:(NSDictionary *)dictionary forKey:(NSString *)string;
/**
 *  字典本地化取出
 *
 
 */
+(NSDictionary *)getDictionaryForKey:(NSString *)key;
/**
 *  取出数组的本地化存储
 */
+(NSArray*)getArrayForKey:(NSString *)string;
/**
 *创建数组的本地化存储
 *
 */
+(void)saveArray:(NSArray *)array forKey:(NSString *)string;
/**
 *  弹窗
 */
+(void)showAlert:(NSString *)message andViewController:(UIViewController *)controller;
/**
 *  数字本地化存储
 */
+(void)saveDouble:(CGFloat)number forKey:(NSString *)key;
/**
 *  数字本地化取出
 */
+(CGFloat)getDoubleForKey:(NSString *)key;











@end
