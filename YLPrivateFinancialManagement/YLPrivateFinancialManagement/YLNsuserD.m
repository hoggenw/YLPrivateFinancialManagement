//
//  YLNsuserD.m
//  YLPrivateFinancialManagement
//
//  Created by 千锋 on 16/1/12.
//  Copyright (c) 2016年 mobiletrain. All rights reserved.
//

#import "YLNsuserD.h"

@implementation YLNsuserD
/**判断输入数字是否合法*/
+(NSString *)judgeNumberIfRight:(NSString *)oringeStting addString:(NSString *)string{
    if (oringeStting.length==0) {
        return string;
        //首个输入是0的处理办法
    }else if ([oringeStting isEqualToString:@"0"]&&[string isEqualToString:@"0"]){
        return oringeStting;
    }else if ([oringeStting isEqualToString:@"0"]&&(![string isEqualToString:@"0"])){
        if ([string isEqualToString:@"."]) {
            return [oringeStting stringByAppendingString:string];
        }else{
        return string;
        }
        //最大整数位不超过8为
    }else if([oringeStting rangeOfString:@"."].length==0){
        if ((oringeStting.length<7)) {
            return [oringeStting stringByAppendingString:string];
        }else{
            if ([string isEqualToString:@"."]) {
                return [oringeStting stringByAppendingString:string];
            }else{
                return oringeStting;
            }
        }
     //小数点只能出现一次
    }else if(([oringeStting rangeOfString:@"."].length==1)&&[string isEqualToString:@"."]){
        return oringeStting;
        //小数点后只能有两位
    }else if((oringeStting.length-[oringeStting rangeOfString:@"."].location)<2){
        return [oringeStting stringByAppendingString:string];
    }
    else{
        return oringeStting;
    }
    
    return oringeStting;
}
+(void)saveDictionary:(NSDictionary *)dictionary forKey:(NSString *)string{
    NSUserDefaults *userDef=[NSUserDefaults standardUserDefaults];
    //将用户默认设置保存以键值对方式保存
    [userDef setObject:dictionary forKey:string];
    //同步（立即保存键值对）防止程序应意外崩溃，导致数据没有来得及保存
    [userDef synchronize];
}
+(void)saveArray:(NSArray *)array forKey:(NSString *)string{
    NSUserDefaults *userDef=[NSUserDefaults standardUserDefaults];
    //将用户默认设置保存以键值对方式保存
    [userDef setObject:array forKey:string];
    //同步（立即保存键值对）防止程序应意外崩溃，导致数据没有来得及保存
    [userDef synchronize];
}
+(NSArray*)getArrayForKey:(NSString *)string{
    NSUserDefaults *userDef=[NSUserDefaults standardUserDefaults];
    NSArray *returnArray=[userDef arrayForKey:string];
    return returnArray;
}
+(NSDictionary *)getDictionaryForKey:(NSString *)key{
    NSUserDefaults *userDef=[NSUserDefaults standardUserDefaults];
    NSDictionary *returnDictionary=[userDef dictionaryForKey:key];
    return returnDictionary;
}
/**
 *  弹窗
 */
+(void)showAlert:(NSString *)message andViewController:(UIViewController *)controller{
    UIAlertController *ac=[UIAlertController alertControllerWithTitle:@"温馨提示" message:message preferredStyle:UIAlertControllerStyleAlert];//最后一个参数是样式
    UIAlertAction *ok=[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
    [ac addAction:ok];
    [controller presentViewController:ac animated:YES completion:nil];
}
/**
 *  数字本地化存储
 */
+(void)saveDouble:(CGFloat)number forKey:(NSString *)key{
    NSUserDefaults *userDef=[NSUserDefaults standardUserDefaults];
    [userDef setDouble:number forKey:key];
    [userDef synchronize];
}
/**
 *  数字本地化取出
 */
+(CGFloat)getDoubleForKey:(NSString *)key{
    NSUserDefaults *userDef=[NSUserDefaults standardUserDefaults];
    CGFloat number=[userDef doubleForKey:key];
    return number;
}
@end
