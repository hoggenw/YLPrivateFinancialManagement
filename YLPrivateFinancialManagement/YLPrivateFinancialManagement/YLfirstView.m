//
//  YLfirstView.m
//  YLPrivateFinancialManagement
//
//  Created by 千锋 on 16/1/5.
//  Copyright (c) 2016年 mobiletrain. All rights reserved.
//

#import "YLfirstView.h"
#import "YLMyButton.h"
#import "Masonry.h"
@implementation YLfirstView
-(instancetype)init{
    if (self=[super init]) {
        
    }
    return self;
}
/**设置页面底部控制视图*/
-(void)creatControlButton:(UIView *)superView target:(id)taget action:(SEL)selector{
    NSArray *nameArray=@[@"收入",@"支出",@"预算",@"明细",@"报表"];
    NSArray *picName=@[@"shouru",@"zhicu",@"yusuan",@"mingxi",@"tubiao"];
    //中间量，存储创造button的位置
    YLMyButton *firstButton=nil;
    //承载button的背景
    UIImageView *myview=[[UIImageView alloc]init];
    myview.tag=200;
    myview.frame=CGRectMake(0, superView.bounds.size.height-80, superView.bounds.size.width, 80);
    myview.alpha=1;
    myview.image=[UIImage imageNamed:@"fenlan"];
    myview.userInteractionEnabled=YES;
    [superView addSubview:myview];
    //计算buttton大小固定后的中间间隙
    float yy=(superView.bounds.size.width-(nameArray.count*50))/(nameArray.count+1)*1.0;
    //循环创造button
    for (int index=0; index<nameArray.count; index++) {
        
        YLMyButton *button=[YLMyButton buttonWithType:UIButtonTypeCustom];
        [button setImage:[UIImage imageNamed:picName[index]] forState:UIControlStateNormal];
        [button setTitle:nameArray[index] forState:UIControlStateNormal];
        
        
        [myview addSubview:button];
        button.translatesAutoresizingMaskIntoConstraints=NO;
        button.tag=201+index;
        button.titleLabel.textAlignment=NSTextAlignmentCenter;
        button.titleLabel.font=[UIFont systemFontOfSize:16];
        [button addTarget:taget action:selector forControlEvents:UIControlEventTouchUpInside];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
                make.width.equalTo(@(50));
                make.height.equalTo(@(60));
                make.centerY.equalTo(myview.mas_centerY);
            if (firstButton==nil) {
                
                make.left.equalTo(myview.mas_left).offset(yy);
            }else{
                make.left.equalTo(firstButton.mas_right).offset(yy);
            }
        }];
        //创建完成以后，将创建好的 button给中间变量方便下一个button参考
        firstButton=(YLMyButton*)button;
        
    }
    
}
@end
