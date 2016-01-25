//
//  YLProgressView.m
//  YLPrivateFinancialManagement
//
//  Created by 千锋 on 16/1/6.
//  Copyright (c) 2016年 mobiletrain. All rights reserved.
//

#import "YLProgressView.h"
#import "Masonry.h"
@implementation YLProgressView

-(void)creatProgresssView:(BOOL)isLeft superView:(UIView *)superView{
   
    UIView *view=[[UIView alloc]init];
    [superView addSubview:view];
    view.clipsToBounds =YES;
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(superView.mas_top).offset(140);
        make.bottom.equalTo(superView.mas_bottom).offset(-60);
        make.width.equalTo(@(35));
        if (isLeft) {
            make.left.equalTo(superView.mas_left).offset(15);
             view.tag=290;
        }else{
            make.right.equalTo(superView.mas_right).offset(-15);
             view.tag=291;
        }
        
    }];
     //创建text标签
    UILabel *topText=[[UILabel alloc]init];
    [superView addSubview:topText];
    if (isLeft) {
        topText.tag=300;
    }else{
        topText.tag=301;
    }
    //======================text======赋值
    topText.text=[NSString stringWithFormat:@"%.1lf",0.0];
    topText.font=[UIFont systemFontOfSize:16];
    topText.textColor=[UIColor blackColor];
    [topText mas_makeConstraints:^(MASConstraintMaker *make) {
        if (isLeft) {
           make.left.equalTo(view.mas_left);
        }else{
            make.right.equalTo(view.mas_right);
        }
        
        make.bottom.equalTo(view.mas_top).offset(-5);
    }];
    UITextField *bottomText=[[UITextField alloc]init];
    if (isLeft) {
        bottomText.text=@"预算剩余";
        bottomText.userInteractionEnabled=NO;
    }else{
        bottomText.text=@"本月支出";
        bottomText.userInteractionEnabled=NO;

    }
    [superView addSubview:bottomText];
    bottomText.font=[UIFont systemFontOfSize:18];
    bottomText.textColor=[UIColor blackColor];
    [bottomText mas_makeConstraints:^(MASConstraintMaker *make) {
        if (isLeft) {
            make.left.equalTo(superView.mas_left).offset(5);
        }else{
            make.right.equalTo(superView.mas_right).offset(-5);
        }
        make.top.equalTo(view.mas_bottom).offset(5);
    }];
    
    _foreImageView=[[UIImageView alloc]init];
    _backImageView=[[UIImageView alloc]init];
    [view addSubview:_backImageView];
     [view addSubview:_foreImageView];
    _backImageView.image=[UIImage imageNamed:@"white_back"];
    [_backImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(view).with.insets(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    if (isLeft) {
        _foreImageView.image=[UIImage imageNamed:@"budget"];
        _foreImageView.tag=210;
        CGFloat height=120;
        [_foreImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(view.mas_left).offset(0);
            make.right.equalTo(view.mas_right).offset(0);
            make.bottom.equalTo(view.mas_bottom).offset(0);
            make.top.equalTo(view.mas_top).offset(height);
        }];
    }else{
        _foreImageView.image=[UIImage imageNamed:@"cost"];
         CGFloat height=0;
        _foreImageView.tag=211;
        [_foreImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(view.mas_left).offset(0);
            make.right.equalTo(view.mas_right).offset(0);
            make.bottom.equalTo(view.mas_bottom).offset(0);
            make.top.equalTo(view.mas_bottom).offset(-height);
        }];
    }
 
}


@end
