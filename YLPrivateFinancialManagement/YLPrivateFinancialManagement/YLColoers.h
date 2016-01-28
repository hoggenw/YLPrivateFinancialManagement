//
//  YLColoers.h
//  YLPrivateFinancialManagement
//
//  Created by 千锋 on 16/1/21.
//  Copyright (c) 2016年 mobiletrain. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YLColoers : NSObject
/**
 *  创建一个颜色数组
 */
+(NSArray *)returnColorsForPicture;

/**
 *  是否已经存在相同类别
 */
+(BOOL)jusdgeIfDiffrentNameInArray:(NSArray*)nameArray  name:(NSString*)name;
@end
