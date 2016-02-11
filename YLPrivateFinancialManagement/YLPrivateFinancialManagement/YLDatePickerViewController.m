//
//  YLDatePickerViewController.m
//  YLPrivateFinancialManagement
//
//  Created by Waterstrong on 2/8/16.
//  Copyright © 2016 mobiletrain. All rights reserved.
//

#import "YLDatePickerViewController.h"

@implementation YLDatePickerViewController{
    UIImageView *selfBackView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"支出一笔";
    [self creaSelfBackView];
    [self customTabBarButtonTitle:@"返回" image:@"button_barbar" target:self action:@selector(onLeftClicked:)  isLeft:YES];
    [self creatDatePicker];
    
}
-(void)onLeftClicked:(UIButton*)sender{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)creaSelfBackView{
    selfBackView=[[UIImageView alloc]initWithFrame:self.view.frame];
    [self.view addSubview:selfBackView];
    selfBackView.userInteractionEnabled=YES;
    selfBackView.image=[UIImage imageNamed:@"report__bg"];
}
-(void)creatDatePicker{
    UIDatePicker *datePicker=[[UIDatePicker alloc]init];
    datePicker.date=[NSDate date];
    NSTimeInterval halfYearInterval = 365 * 24 * 60 * 60;
    NSDate *today = [NSDate date];
    NSDate *halfYearFromToday = [today dateByAddingTimeInterval:halfYearInterval];
    [datePicker setDatePickerMode:UIDatePickerModeDate];
    datePicker.maximumDate = halfYearFromToday;
    [selfBackView addSubview:datePicker];
    [datePicker mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(selfBackView.mas_left);
        make.right.equalTo(selfBackView.mas_right);
        make.top.equalTo(selfBackView.mas_top).offset(67);
        
    }];
    UIButton *button=[UIButton buttonWithType:UIButtonTypeCustom];
    button.titleLabel.textAlignment=NSTextAlignmentCenter;
    [button setTitle:@"完成" forState:UIControlStateNormal];
    [selfBackView addSubview:button];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    button.titleLabel.font=[UIFont boldSystemFontOfSize:20];
    [button setBackgroundImage:[UIImage imageNamed:@"cellBG"] forState:UIControlStateNormal];
    button.clipsToBounds=YES;
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(selfBackView.mas_centerX);
        make.width.equalTo(@(80));
        make.top.equalTo(datePicker.mas_bottom).offset(10);
        make.height.equalTo(@(50));
    }];
    [button addTarget:self action:@selector(onLeftClicked:) forControlEvents:UIControlEventTouchUpInside];
    [datePicker addTarget:self action:@selector(datePickerChange:) forControlEvents:UIControlEventValueChanged];
    
    
}
//选者时间处理保证主键唯一
- (void)datePickerChange:(UIDatePicker *)paramPicker{
    
    NSDate *select=paramPicker.date;
    //转化主键格式与当前时间时分秒对应确保唯一主键
    NSDate *nowDate=[NSDate date];
    NSString *selectString=[select formattedDateWithFormat:@"YYYY/MM/dd HH:mm:ss"];
    NSString  *nowDateSting=[nowDate formattedDateWithFormat:@"YYYY/MM/dd HH:mm:ss"];
    NSMutableString *timeString=[NSMutableString string];
    NSArray *selectStringArray=[selectString componentsSeparatedByString:@" "];
    NSArray *nowDateStingArray=[nowDateSting componentsSeparatedByString:@" "];
    NSString *need1=[selectStringArray firstObject] ;
    NSString *need2=[nowDateStingArray lastObject];
    timeString=[NSMutableString stringWithString:[NSString stringWithFormat:@"%@ %@",need1,need2]];
    NSDateFormatter *formatter=[[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    NSString *dataStr=[select formattedDateWithStyle:NSDateFormatterFullStyle];
    if (_myDatePicker) {
        _myDatePicker([formatter dateFromString:timeString],dataStr);
    }
   
}
@end
