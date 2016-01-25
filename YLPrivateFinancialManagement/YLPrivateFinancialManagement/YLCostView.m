//
//  YLCostView.m
//  YLPrivateFinancialManagement
//
//  Created by 千锋 on 16/1/14.
//  Copyright (c) 2016年 mobiletrain. All rights reserved.
//

#import "YLCostView.h"
#import "YLCostButton.h"
@implementation YLCostView

/**创建button*/
-(YLCostButton*)creatButton{
    YLCostButton *button=[YLCostButton buttonWithType:UIButtonTypeCustom];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    button.titleLabel.font=[UIFont systemFontOfSize:28];
    [button setBackgroundColor:[UIColor whiteColor]];
    
    return button;
}
/**创建textField*/
-(UITextField *)creatTextFeild{
    UITextField *bottomText=[[UITextField alloc]init];
    bottomText.font=[UIFont systemFontOfSize:16];
    bottomText.textAlignment=NSTextAlignmentRight;
    bottomText.userInteractionEnabled=NO;
    bottomText.textColor=[UIColor blackColor];
    return bottomText;
    
}
/**创建普通Butonn*/
-(UIButton *)creatNormalButtom{
    UIButton *button=[UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    button.titleLabel.font=[UIFont systemFontOfSize:20];
    return button;
}




















@end
