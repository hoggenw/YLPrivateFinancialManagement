//
//  YLDetailViewController.h
//  YLPrivateFinancialManagement
//
//  Created by 千锋 on 16/1/11.
//  Copyright (c) 2016年 mobiletrain. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YLMumViewController.h"
//创建两个枚举方便于选着控制

typedef NS_ENUM(NSInteger, KINDSOFSHOWDETAIL){
    DETAULTKIND=0,
    DAYKINDDETAIL=1,
    MONTHKINDDATAIL=2,
    KAINSDATAIL=3,
};

@interface YLDetailViewController : YLMumViewController
@property(nonatomic,assign)BIGCLASS chooseClass;
@property(nonatomic,assign)KINDSOFSHOWDETAIL chooseShowKind;
@end
