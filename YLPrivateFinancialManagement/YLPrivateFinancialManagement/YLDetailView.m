//
//  YLDetailView.m
//  YLPrivateFinancialManagement
//
//  Created by 千锋 on 16/1/20.
//  Copyright (c) 2016年 mobiletrain. All rights reserved.
//

#import "YLDetailView.h"

@implementation YLDetailView
/**
 *  创建两个按钮，分别是支出和收入
 */
-(void)creatTwoButtonForDetailView:(UIView *)superView nameArray:(NSArray *)nameArray{
    for (int index=0; index<nameArray.count; index++) {
        UIButton *button=[UIButton buttonWithType:UIButtonTypeCustom];
        button.tag=800+index;
        CGFloat width=superView.bounds.size.width/nameArray.count;
        button.titleLabel.textAlignment=NSTextAlignmentCenter;
        [button setTitle:nameArray[index] forState:UIControlStateNormal];
        [superView addSubview:button];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        button.titleLabel.font=[UIFont boldSystemFontOfSize:24];
        [button setBackgroundImage:[UIImage imageNamed:@"cellBG"] forState:UIControlStateNormal];
        button.clipsToBounds=YES;
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(superView.mas_left).offset(width*index);
            make.width.equalTo(@(width));
            make.top.equalTo(superView.mas_top);
            make.height.equalTo(@(40));
        }];
        
    }
}
-(void)creatFourKindsButtonForDetailView:(UIView *)superView nameArray:(NSArray *)nameArray{
    for (int index=0; index<nameArray.count; index++) {
        UIButton *button=[UIButton buttonWithType:UIButtonTypeCustom];
        button.tag=810+index;
        CGFloat width=superView.bounds.size.width/nameArray.count;
        button.titleLabel.textAlignment=NSTextAlignmentCenter;
        [button setTitle:nameArray[index] forState:UIControlStateNormal];
        [superView addSubview:button];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        button.titleLabel.font=[UIFont boldSystemFontOfSize:20];
        [button setBackgroundImage:[UIImage imageNamed:@"cellBG"] forState:UIControlStateNormal];
        button.clipsToBounds=YES;
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(superView.mas_left).offset(width*index);
            make.width.equalTo(@(width));
            make.top.equalTo(superView.mas_top);
            make.height.equalTo(@(50));
        }];
        
    }
}
@end
