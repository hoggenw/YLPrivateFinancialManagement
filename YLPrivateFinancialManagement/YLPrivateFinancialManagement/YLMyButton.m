//
//  YLMyButton.m
//  YLPrivateFinancialManagement
//
//  Created by 千锋 on 16/1/5.
//  Copyright (c) 2016年 mobiletrain. All rights reserved.
//

#import "YLMyButton.h"

@implementation YLMyButton
//下面两个方法自定义button 的图片位置和文字位置
-(CGRect)titleRectForContentRect:(CGRect)contentRect{
    return CGRectMake(0, self.bounds.size.height*2/3, self.bounds.size.width, self.bounds.size.height/3);
    
}
-(CGRect)imageRectForContentRect:(CGRect)contentRect{
    return CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height*2/3);
}

@end
