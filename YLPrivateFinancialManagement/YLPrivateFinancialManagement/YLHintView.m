//
//  YLHintView.m
//  YL老师答题系统
//
//  Created by 千锋 on 15/12/2.
//  Copyright (c) 2015年 mobiletrain. All rights reserved.
//

#import "YLHintView.h"

@implementation YLHintView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self=[super initWithFrame:frame]) {
        self.backgroundColor=[UIColor colorWithRed:0.2 green:0.1 blue:0.2 alpha:0.5];
        hintLabel=[[UILabel alloc]init];
        [self addSubview:hintLabel];
        [hintLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mas_left).offset(10);
            make.right.equalTo(self.mas_right).offset(-10);
            make.top.equalTo(self.mas_top);
            make.bottom.equalTo(self.mas_bottom);
        }];
        hintLabel.numberOfLines=0;
        hintLabel.textAlignment=NSTextAlignmentCenter;
        hintLabel.adjustsFontSizeToFitWidth=YES;
        hintLabel.font=[UIFont systemFontOfSize:25];
        hintLabel.textColor=[UIColor whiteColor];
        [self addSubview:hintLabel];
    }
    return self;
}
-(void)setMessage:(NSString *)message{
    hintLabel.text=message;
}
-(void)showOnView:(UIView *)parentView ForTimeInterval:(NSTimeInterval)interval{
    [parentView addSubview:self];
    timer=[NSTimer scheduledTimerWithTimeInterval:interval target:self selector:@selector(removeFromSuperview) userInfo:nil repeats:NO];
}
-(void)dealloc{
    if (timer) {
        [timer invalidate];
        timer=nil;
    }
}
@end




























