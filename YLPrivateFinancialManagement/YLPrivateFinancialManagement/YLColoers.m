//
//  YLColoers.m
//  YLPrivateFinancialManagement
//
//  Created by 千锋 on 16/1/21.
//  Copyright (c) 2016年 mobiletrain. All rights reserved.
//

#import "YLColoers.h"

@implementation YLColoers
/**
 *  创建一个颜色数组
 */
+(NSArray *)returnColorsForPicture{
    UIColor *color1=[UIColor colorWithRed:173/255.0 green:176/255.0 blue:95/255.0 alpha:1];
    UIColor *color2=[UIColor  brownColor];
    UIColor *color3=[UIColor colorWithRed:255/255.0 green:252/255.0 blue:26/255.0 alpha:1];
    UIColor *color4=[UIColor orangeColor];
    UIColor *color5=[UIColor colorWithRed:197/255.0 green:197/255.0 blue:197/255.0 alpha:1];
    UIColor *color6=[UIColor colorWithRed:26/255.0 green:199/255.0 blue:28/255.0 alpha:1];
    UIColor *color7=[UIColor colorWithRed:24/255.0 green:192/255.0 blue:255/255.0 alpha:1];
    UIColor *color8=[UIColor colorWithRed:35/255.0 green:250/255.0 blue:38/255.0 alpha:1];
    UIColor *color9=[UIColor colorWithRed:33/255.0 green:254/255.0 blue:255/255.0 alpha:1];
    UIColor *color10=[UIColor colorWithRed:252/255.0 green:38/255.0 blue:251/255.0 alpha:1];
    return @[color1,color2,color3,[UIColor magentaColor],color4,color5,color6,color7,color8,color9,color10,[UIColor yellowColor],[UIColor greenColor],[UIColor cyanColor]];
}
@end
