//
//  YLMumViewController.h
//  YLPrivateFinancialManagement
//
//  Created by 千锋 on 16/1/11.
//  Copyright (c) 2016年 mobiletrain. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger, BIGCLASS){
    COSTDETAIL=1,
    GETDETAL=2,
    DEFAULTDETAIL=0,
};
@interface YLMumViewController : UIViewController
-(void)customTabBarButtonTitle:(NSString *)title image:(NSString *)imageName target:(id)taget action:(SEL)selector isLeft:(BOOL)isLeft;
@end
