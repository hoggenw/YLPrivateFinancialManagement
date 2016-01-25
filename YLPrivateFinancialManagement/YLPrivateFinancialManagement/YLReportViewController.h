//
//  YLReportViewController.h
//  YLPrivateFinancialManagement
//
//  Created by 千锋 on 16/1/11.
//  Copyright (c) 2016年 mobiletrain. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YLMumViewController.h"
typedef NS_ENUM(NSInteger, SHOWPIEKIND){
    SHOWPIEKINDDEFAULT=0,
    SHOWPIEKINDBIGCLASS=1,
    SHOWPIEKINDALLKINDS=2,
};
@interface YLReportViewController : YLMumViewController
@property(nonatomic,assign)BIGCLASS chooseClass;
@property(nonatomic,assign)SHOWPIEKIND  chooseKind;
@end
