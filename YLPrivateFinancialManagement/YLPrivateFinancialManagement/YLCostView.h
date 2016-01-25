//
//  YLCostView.h
//  YLPrivateFinancialManagement
//
//  Created by 千锋 on 16/1/14.
//  Copyright (c) 2016年 mobiletrain. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YLCostButton;
@interface YLCostView : UIView

/**创建button*/
-(YLCostButton*)creatButton;
/**创建textField*/
-(UITextField *)creatTextFeild;
/**创建普通Butonn*/
-(UIButton *)creatNormalButtom;

@end
