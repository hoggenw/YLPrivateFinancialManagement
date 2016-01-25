//
//  YLMyCollectionViewCell.m
//  YLPrivateFinancialManagement
//
//  Created by 千锋 on 16/1/23.
//  Copyright (c) 2016年 mobiletrain. All rights reserved.
//

#import "YLMyCollectionViewCell.h"

@implementation YLMyCollectionViewCell
-(void)setModel:(NSString *)model{
    if (!_myLabel) {
        _myLabel=[[UILabel alloc]initWithFrame:CGRectMake(0,0,CGRectGetWidth(self.frame), CGRectGetHeight(self.frame))];
        _button=[UIButton buttonWithType:UIButtonTypeCustom];
        _button.frame=CGRectMake(0, 0, 30, 30);
        [self.contentView addSubview:_myLabel];
        [self.contentView addSubview:_button];
       [_button setBackgroundImage:[UIImage imageNamed:@"close"] forState:UIControlStateNormal];
        //[_button setImage:[UIImage imageNamed:@"close"] forState:UIControlStateNormal];
        _button.hidden=YES;
        _myLabel.font=[UIFont systemFontOfSize:18];
        _myLabel.textColor=[UIColor blackColor];
        _myLabel.backgroundColor=[UIColor lightGrayColor];
        _myLabel.textAlignment=NSTextAlignmentCenter;
    }else{
        [_myLabel removeFromSuperview];
        [_button removeFromSuperview];
        _myLabel=[[UILabel alloc]initWithFrame:CGRectMake(0,0,CGRectGetWidth(self.frame), CGRectGetHeight(self.frame))];
        _button=[UIButton buttonWithType:UIButtonTypeCustom];
        _button.frame=CGRectMake(0, 0, 30, 30);
        [self.contentView addSubview:_myLabel];
        [self.contentView addSubview:_button];
        [_button setBackgroundImage:[UIImage imageNamed:@"close"] forState:UIControlStateNormal];
        //[_button setImage:[UIImage imageNamed:@"close"] forState:UIControlStateNormal];
        _myLabel.backgroundColor=[UIColor lightGrayColor];
        _button.hidden=YES;
        _myLabel.font=[UIFont systemFontOfSize:18];
        _myLabel.textColor=[UIColor blackColor];
        _myLabel.textAlignment=NSTextAlignmentCenter;

    }
    _myLabel.text=model;
}
@end
