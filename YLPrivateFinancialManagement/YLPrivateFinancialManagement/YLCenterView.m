//
//  YLCenterView.m
//  YLPrivateFinancialManagement
//
//  Created by 千锋 on 16/1/7.
//  Copyright (c) 2016年 mobiletrain. All rights reserved.
//

#import "YLCenterView.h"

@implementation YLCenterView{
    UIView *myCenterView;
}


-(void)creatCenterView:(UIView *)superView target:(id)taget action:(SEL)selector{
    myCenterView=[[UIView alloc]init];
    myCenterView.backgroundColor=[UIColor clearColor];
    [superView addSubview:myCenterView];
    myCenterView.tag=282;
    [myCenterView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(superView.mas_left).offset(55);
        make.right.equalTo(superView.mas_right).offset(-55);
        make.top.equalTo(superView.mas_top).offset(80);
        make.bottom.equalTo(superView.mas_bottom).offset(-60);
    }];
    [self creatLableView:myCenterView];
    [self creatCenterButtons:myCenterView isUp:YES target:taget action:selector];
    [self creatCenterButtons:myCenterView isUp:NO target:taget action:selector];
    
}
/**创建收入支出button*/
-(void)creatCenterButtons:(UIView*)superView isUp:(BOOL)isUp target:(id)taget action:(SEL)selector{
    UIButton *button=[UIButton buttonWithType:UIButtonTypeCustom];
    if (isUp) {
        [button setTitle:@"支出一笔  丨速记" forState:UIControlStateNormal];
        [button addTarget:taget action:selector forControlEvents:UIControlEventTouchUpInside];
        button.tag=400;
    }else{
        [button setTitle:@"收入一笔  丨速记" forState:UIControlStateNormal];
        [button addTarget:taget action:selector forControlEvents:UIControlEventTouchUpInside];
        button.tag=401;
    }
    [superView addSubview:button];
    [button setBackgroundImage:[UIImage imageNamed:@"orange_color"] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    button.titleLabel.textAlignment=NSTextAlignmentCenter;
    button.titleLabel.font=[UIFont systemFontOfSize:24];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(superView.mas_left).offset(10);
        make.right.equalTo(superView.mas_right).offset(-10);
        make.height.equalTo(@(50));
        if (isUp) {
            make.bottom.equalTo(superView.mas_bottom).offset(-100);
        }else{
            make.bottom.equalTo(superView.mas_bottom).offset(-20);
        }
    }];
    

}
/**创建显示的两个Label*/
-(void)creatLableView:(UIView*)superView{
    UILabel *leftLabel=[[UILabel alloc]init];
    UILabel *rightLabel=[[UILabel alloc]init];
    [superView addSubview:leftLabel];
    [superView addSubview:rightLabel];
    leftLabel.textColor=[UIColor blackColor];
    rightLabel.textColor=[UIColor blackColor];
    leftLabel.font=[UIFont systemFontOfSize:18];
    rightLabel.font=[UIFont systemFontOfSize:18];
    leftLabel.tag=280;
    rightLabel.tag=281;
    _todayGet=0;
    _todayCost=0;
    leftLabel.text=[NSString stringWithFormat:@"今日支出:%.1lf",_todayCost];
    rightLabel.text=[NSString stringWithFormat:@"今日收入:%.1lf",_todayGet];
    [leftLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(superView.mas_left).offset(30);
        make.right.equalTo(superView.mas_right).offset(5);
        make.top.equalTo(superView.mas_top).offset(30);
       
    }];
  
    [rightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(superView.mas_left).offset(30);
        make.right.equalTo(superView.mas_right).offset(5);
        make.top.equalTo(leftLabel.mas_bottom).offset(20);

    }];
    
    
}
@end
