//
//  YLCostOneTimeViewController.m
//  YLPrivateFinancialManagement
//
//  Created by 千锋 on 16/1/12.
//  Copyright (c) 2016年 mobiletrain. All rights reserved.
//

#import "YLCostOneTimeViewController.h"
#import "YLCostModel.h"
#import "YLCostView.h"
#import "YLCostButton.h"
#import "YLHintView.h"
#define MAX_WORDS 100
typedef NS_ENUM(NSInteger, SHOWMODEL){
    CLASSMODEL=0,
    KINDMODEL=1,
    
    
};
@interface YLCostOneTimeViewController ()<UITextViewDelegate,UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>{
    YLCostModel *model;
    UIImageView *view;
    UIImageView  *numberView;
    NSArray *costArray;
    UITableView *myTableView;
    NSMutableArray *tableViewArray;
    SHOWMODEL showModel;
    YLDataBaseManager *manager;
}

@end

@implementation YLCostOneTimeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"支出一笔";
    manager=[YLDataBaseManager shareManager];
    [self customTabBarButtonTitle:@"返回" image:@"button_barbar" target:self action:@selector(onLeftClicked:)  isLeft:YES];
    model=[[YLCostModel alloc]init];
    [self creatMumViewOfButtons];
    
}
-(void)onLeftClicked:(UIButton*)sender{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//创建上半部分的页面
-(void)creatMumViewOfButtons{
    view=[[UIImageView alloc]init];
    [self.view addSubview:view];
    view.userInteractionEnabled=YES;
    view.image=[UIImage imageNamed:@"half_bg"];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.top.equalTo(self.view.mas_top);
        make.bottom.equalTo(self.view.mas_top).offset(self.view.bounds.size.height);
    }];
    YLCostView *costView=[[YLCostView alloc]init];
    //创建数字输入框
    YLCostButton *button=[costView creatButton];
    button.layer.borderWidth=1;
    [button setTitle:@"0.0" forState:UIControlStateNormal];
    button.titleLabel.textAlignment=NSTextAlignmentRight;
    [button addTarget:self action:@selector(onCostButtonContent:) forControlEvents:UIControlEventTouchUpInside];
    //花费显示框的tag值
    button.tag=209;
    [view addSubview:button];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(view.mas_left).offset(10);
        make.right.equalTo(view.mas_right).offset(-10);
        make.top.equalTo(view.mas_top).offset(74);
        make.height.equalTo(@(40));
    }];
    costArray=[YLNsuserD getArrayForKey:@"costArray"];
    NSDictionary *firstDict=[costArray firstObject];
    NSArray *allKeys=[firstDict allKeys];
    NSString *justKey=[allKeys firstObject];
    NSString *content=[firstDict[justKey] firstObject];
    NSArray *array=@[justKey,content,[self getDateNow]];
    NSArray *labelArray=@[@"类别:",@"项目:",@"日期:"];
    for(int index=0;index<3;index++){
        UIButton *normalButton=[costView creatNormalButtom];
        [normalButton setTitle:@"选择" forState:UIControlStateNormal];
        [normalButton setBackgroundImage:[UIImage imageNamed:@"buttonbar"] forState:UIControlStateNormal];
        normalButton.tag=206+index;
        [normalButton addTarget:self action:@selector(onChosseButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:normalButton];
        [normalButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(button.mas_bottom).offset(10+index*45);
            make.left.equalTo(view.mas_left).offset(10);
            make.height.equalTo(@(40));
            make.width.equalTo(@(60));
        }];
        //创建label存种类
        UILabel *titleLabel=[[UILabel alloc]init];
        titleLabel.text=labelArray[index];
        titleLabel.layer.cornerRadius=3;
        titleLabel.font=[UIFont systemFontOfSize:16];
        titleLabel.textColor=[UIColor blackColor];
        titleLabel.backgroundColor=[UIColor whiteColor];
        [view addSubview:titleLabel];
        [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(button.mas_bottom).offset(10+index*45);
            make.left.equalTo(normalButton.mas_right).offset(2);
            make.width.equalTo(@(40));
            make.height.equalTo(@(40));
        }];
        //创建选择框
        YLCostButton *textButton=[costView creatButton];
        //其实是button
        textButton.backgroundColor=[UIColor whiteColor];
        [view addSubview:textButton];
        textButton.tag=220+index;
        [textButton addTarget:self action:@selector(onChosseButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        textButton.titleLabel.font=[UIFont systemFontOfSize:16];
        textButton.titleLabel.lineBreakMode=NSLineBreakByTruncatingTail;
        [textButton setTitle:array[index] forState:UIControlStateNormal];
        textButton.titleLabel.textAlignment=NSTextAlignmentLeft;
        [textButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(button.mas_bottom).offset(10+index*45);
            make.left.equalTo(titleLabel.mas_right).offset(1);
            make.right.equalTo(view.mas_right).offset(-20);
            make.height.equalTo(@(40));
        }];
    }
    //创建备注textField
    UIButton *standardButton=(id)[view viewWithTag:208];
    UITextView*ramarkText=[[UITextView alloc]init];
    ramarkText.font=[UIFont systemFontOfSize:14];
    //限制文字数量的代理实现
    ramarkText.delegate=self;
    ramarkText.tag=233;
    ramarkText.backgroundColor=[UIColor whiteColor];
    [view addSubview:ramarkText];
    [ramarkText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(view.mas_left).offset(10);
        make.top.equalTo(standardButton.mas_bottom).offset(5);
        make.right.equalTo(view.mas_right).offset(-20);
        make.height.equalTo(@(80));
    }];
    ramarkText.layer.borderWidth=2;
    //设置键盘上返回键的类型
    ramarkText.returnKeyType=UIReturnKeyDone;
    ramarkText.keyboardType=UIKeyboardTypeDefault;
    //uilabel来做背景图片
    UILabel *label=[[UILabel alloc]init];
    label.textColor=[UIColor lightGrayColor];
    label.font=[UIFont systemFontOfSize:16];
    label.backgroundColor=[UIColor clearColor];
    label.text=@"备注：";
    label.tag=234;
    [ramarkText addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(ramarkText.mas_top);
        make.left.equalTo(ramarkText.mas_left);
    }];
    //创建完成按钮
    UIButton *doneButton=[costView creatNormalButtom];
    doneButton.tag=235;
    [doneButton setTitle:@"完成" forState:UIControlStateNormal];
    [doneButton addTarget:self action:@selector(doneButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:doneButton];
    [doneButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(ramarkText.mas_bottom).offset(10);
        make.left.equalTo(view.mas_left).offset(60);
        make.right.equalTo(view.mas_right).offset(-60);
    }];
    [doneButton setBackgroundImage:[UIImage imageNamed:@"doneBuBG"] forState:UIControlStateNormal];
    doneButton.layer.cornerRadius=5;
    doneButton.clipsToBounds=YES;
    
    
}

#pragma mark-按键回调方法
//选中种类的buttons的回调方法
-(void)onChosseButtonClicked:(UIButton *)sender{
    [self selfTextViewResignFirstResponder];
    if (!tableViewArray) {
        tableViewArray=[NSMutableArray array];
    }else{
        [tableViewArray removeAllObjects];
    }
    [numberView removeFromSuperview];
    numberView=nil;
    costArray=[YLNsuserD getArrayForKey:@"costArray"];
    //类别选着的回调方法
    if (sender.tag==206||sender.tag==220) {
        showModel=CLASSMODEL;
        
        for (NSDictionary *temp in costArray) {
            NSString *str=[[temp allKeys] firstObject];
            [tableViewArray addObject:str];
        }
        if (!numberView) {
            [self creatSelfView];
            [self creatTableView];
        }
        
        
        //项目选择的回调方法
    }else if(sender.tag==207||sender.tag==221){
        showModel=KINDMODEL;
        YLCostButton *thisButton=(id)[view viewWithTag:220];
        NSString *standard=thisButton.titleLabel.text;
        for (NSDictionary *temp in costArray) {
            NSString *str=[[temp allKeys]firstObject];
            if ([standard isEqualToString:str]) {
                tableViewArray=[temp[standard] mutableCopy];
                break;
            }
        }
        if (!numberView) {
            [self creatSelfView];
            [self creatTableView];
        }
       
        
        //时间选择的回调方法
    }else if (sender.tag==208||sender.tag==222){
        
        if (!numberView) {
            [self creatSelfView];
            [self creatDatePicker];
        }
        
    }
}
//记账完成的按钮点击回调方法
-(void)doneButtonClicked:(UIButton *)sender{
    [self selfTextViewResignFirstResponder];
    [numberView removeFromSuperview];
    numberView=nil;
    YLCostButton *mainButton=(id)[view viewWithTag:220];
    YLCostButton *changeButton=(id)[view viewWithTag:221];
    YLCostButton *constButton=(id)[view viewWithTag:209];
    YLCostButton *timeButton=(id)[view viewWithTag:222];
    model.dateNow=timeButton.titleLabel.text;
    NSString *centerString=[constButton.titleLabel.text componentsSeparatedByString:@"."][0];
    
    if (constButton.titleLabel.text.length==centerString.length+1) {
        constButton.titleLabel.text=[[constButton.titleLabel.text componentsSeparatedByString:@"."]firstObject];
        [constButton setTitle:[[constButton.titleLabel.text componentsSeparatedByString:@"."]firstObject] forState:UIControlStateNormal];
    }
    model.costMoney=constButton.titleLabel.text;
    model.bigClass=mainButton.titleLabel.text;
    model.kind=changeButton.titleLabel.text;
    if ([model.costMoney isEqualToString:@"0.0"]||[model.costMoney isEqualToString:@"0"]) {
        [YLNsuserD showAlert:@"填写的支出不能为零.." andViewController:self];
    }else{
        if ([manager insertYLCostModel:model]) {
            [view removeFromSuperview];
             view=nil;
            [self creatMumViewOfButtons];
            YLHintView *hView=[[YLHintView alloc]initWithFrame:CGRectMake(0, 0,150, 120)];
            hView.center=self.view.center;
            [self.view addSubview:hView];
            hView.message=@"已计入账本";
            [hView showOnView:self.view ForTimeInterval:1];
        }
        
    }
}
//花费的按钮回调的方法
-(void)onCostButtonContent:(UIButton *)sender{
    [numberView removeFromSuperview];
    numberView=nil;
    if (!numberView) {
        [self selfTextViewResignFirstResponder];
        [self creatSelfView];
        [self creatNumberControl];
    }
    
}

//键盘编辑完成回调方法
-(void)flishEditNumber:(UIButton *)sender {
    YLCostButton *button=(id)[view viewWithTag:209];
    if ([button.titleLabel.text isEqualToString:@""]) {
        button.titleLabel.text=@"0.0";
        [button setTitle:@"0.0" forState:UIControlStateNormal];
    }
    if ([button.titleLabel.text componentsSeparatedByString:@"."].count==1) {
        button.titleLabel.text=[[button.titleLabel.text componentsSeparatedByString:@"."]firstObject];
    }
    model.costMoney=button.titleLabel.text;
    [numberView removeFromSuperview];
    numberView=nil;
}
//数字花费显示回调方法
-(void)onCostNumberShow:(UIButton *)sender{
    YLCostButton *button=(id)[view viewWithTag:209];
    if ([sender.titleLabel.text isEqualToString:@"."]&&([button.titleLabel.text isEqualToString:@""]||[button.titleLabel.text isEqualToString:@"0.0"])) {
        
    }else{
        NSMutableString *buttonStr=[NSMutableString string];
        if ([button.titleLabel.text isEqualToString:@"0.0"]) {
            button.titleLabel.text=@"";
            buttonStr=[NSMutableString stringWithString:@""];
        }else{
            buttonStr=[NSMutableString stringWithString:button.titleLabel.text];
        }
        NSString *resultStr=[YLNsuserD judgeNumberIfRight:buttonStr addString:sender.titleLabel.text];
        button.titleLabel.text=resultStr;
        [button setTitle:resultStr forState:UIControlStateNormal];
    }
}
//删除按钮回调方法
//自定义键盘删除一个一个删除
-(void)deleteNumber:(UIButton*)sender{
    YLCostButton *button=(id)[view viewWithTag:209];
    if (button.titleLabel.text.length!=0) {
        NSMutableString *str1,*str=[button.titleLabel.text mutableCopy];
        str1=[NSMutableString string];
        
        for (int i=0; i<str.length-1; i++) {
            [str1 appendFormat:@"%c",[str characterAtIndex:i]];
        }
        button.titleLabel.text=str1;
        [button setTitle:str1 forState:UIControlStateNormal];
    }else{
    }
}
//自定义键盘重置方法
-(void)deleteAllEditNumber:(UIButton *)sender{
    YLCostButton *button=(id)[view viewWithTag:209];
    NSString *str=@"";
    button.titleLabel.text=str;
    [button setTitle:str forState:UIControlStateNormal];
}
#pragma mark-按键回调方法的支持方法
//自定义画板，装载控件母视图
-(void)creatSelfView{
    numberView=[[UIImageView alloc]init];
    numberView.userInteractionEnabled=YES;
    numberView.backgroundColor=[UIColor clearColor];
    [self.view addSubview:numberView];
    [numberView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view.mas_bottom);
        make.centerX.equalTo(self.view.mas_centerX);
        make.width.equalTo(self.view.mas_width);
        make.height.equalTo(@(290));
        
    }];
    
}
//创建选着时间的方法
-(void)creatDatePicker{
    UIDatePicker *datePicker=[[UIDatePicker alloc]init];
    [numberView addSubview:datePicker];
    datePicker.date=[NSDate date];
    NSTimeInterval halfYearInterval = 365 * 24 * 60 * 60;
    NSDate *today = [NSDate date];
    NSDate *halfYearFromToday = [today dateByAddingTimeInterval:halfYearInterval];
    [datePicker setDatePickerMode:UIDatePickerModeDate];
    datePicker.maximumDate = halfYearFromToday;
    [datePicker mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(numberView).insets(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
   
    [datePicker addTarget:self action:@selector(datePickerChange:) forControlEvents:UIControlEventValueChanged];
    
    
}
//选者时间处理保证主键唯一
- (void)datePickerChange:(UIDatePicker *)paramPicker{
    YLCostButton *timeButton=(id)[view viewWithTag:222];
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
    
    model.mainKey=[formatter dateFromString:timeString];
    
    NSString *dataStr=[select formattedDateWithStyle:NSDateFormatterFullStyle];
    timeButton.titleLabel.text=dataStr;
    [timeButton setTitle:dataStr forState:UIControlStateNormal];
}
//建造数字按钮
-(void)creatNumberControl{
    NSArray *nameArray=@[@[@"7",@"8",@"9",@"删除"],@[@"4",@"5",@"6"],@[@"1",@"2",@"3",@"确定"],@[@"0",@".",@"C"]];
    CGFloat width=(self.view.bounds.size.width-10)/4.f;
    CGFloat height=70.f;
    NSUInteger countRIght=0;
    for (int index=0; index<nameArray.count; index++) {
        NSArray *array=nameArray[index];
        for (int counts=0; counts<array.count; counts++) {
            UIButton *setButton=[UIButton buttonWithType:UIButtonTypeCustom];
            [setButton setTitle:array[counts] forState:UIControlStateNormal];
            if (counts==3) {
                setButton.frame=CGRectMake(5+width*counts, 5+height*index, width, height*2);
            }else{
                setButton.frame=CGRectMake(5+width*counts, 5+height*index, width, height);
            }
            if (index==2) {
                setButton.tag=240+counts+index*(countRIght)+1;
            }else{
                setButton.tag=240+counts+index*(countRIght);//243删除,250确定,254，重置
            }
            setButton.titleLabel.font=[UIFont systemFontOfSize:22];
            [setButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            if (setButton.tag==243) {
                [setButton addTarget:self action:@selector(deleteNumber:) forControlEvents:UIControlEventTouchUpInside];
            }else if(setButton.tag==250){
                [setButton addTarget:self action:@selector(flishEditNumber:) forControlEvents:UIControlEventTouchUpInside];
            }else if (setButton.tag==254){
                [setButton addTarget:self action:@selector(deleteAllEditNumber:) forControlEvents:UIControlEventTouchUpInside];
            }else{
                [setButton addTarget:self action:@selector(onCostNumberShow:) forControlEvents:UIControlEventTouchUpInside];
            }
            setButton.layer.borderWidth=0.5;
            [setButton setBackgroundColor:[UIColor whiteColor]];
            [numberView addSubview:setButton];
            
            
        }
        countRIght=array.count;
    }
}
//创建tabelView
#pragma mark-TableView
-(void)creatTableView{
    myTableView=[[UITableView alloc]init];
    [numberView addSubview:myTableView];
    [myTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(numberView).insets(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    myTableView.delegate=self;
    myTableView.dataSource=self;
    myTableView.rowHeight=40;
    
    
    
}


//组中单元格数组
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return tableViewArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"CELL"];
    if (!cell) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"CELL"];
    }
    cell.textLabel.text=tableViewArray[indexPath.row];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //220 221
    YLCostButton *mainButton=(id)[view viewWithTag:220];
    YLCostButton *changeButton=(id)[view viewWithTag:221];
    //如果是种类就调用这个方法
    if (showModel==CLASSMODEL) {
        //如果是最后一项
        if((indexPath.row+1)==tableViewArray.count){
             [self addClassOrKind];
        }else{
        mainButton.titleLabel.text=tableViewArray[indexPath.row];
        [mainButton setTitle:tableViewArray[indexPath.row] forState:UIControlStateNormal];
        for (NSDictionary *temp in costArray) {
            NSString *str=[[temp allKeys]firstObject];
            if ([tableViewArray[indexPath.row] isEqualToString:str]) {
                NSString *content=[temp[tableViewArray[indexPath.row]] firstObject];
                changeButton.titleLabel.text=content;
                [changeButton setTitle:content forState:UIControlStateNormal];
                break;
            }
        }
        }
        
    }
    //如果是项目就调用这个方法
    if (showModel==KINDMODEL) {
        //如果是最后一项
        if((indexPath.row+1)==tableViewArray.count){
            [self addClassOrKind];
        }else{
            //如果不是最后一项就调用下面的方法
            NSString *content=tableViewArray[indexPath.row];
            changeButton.titleLabel.text=content;
            [changeButton setTitle:content forState:UIControlStateNormal];
         
        }
    }
    [numberView removeFromSuperview];
    numberView=nil;
    
    
    
}
#pragma mark-添加项目的回调方法
-(void)addClassOrKind{
    YLCostButton *mainButton=(id)[view viewWithTag:220];
    YLCostButton *changeButton=(id)[view viewWithTag:221];
    NSMutableArray *myArray=[[YLNsuserD getArrayForKey:@"costArray"] mutableCopy];
    if (showModel==CLASSMODEL) {
        UIAlertController *ac = [UIAlertController alertControllerWithTitle:@"创建种类" message:@"请输入添加的的名称" preferredStyle:UIAlertControllerStyleAlert];
        // 给警告控制器中添加文本框
        [ac addTextFieldWithConfigurationHandler:^(UITextField *textField) {
            // 此处可以对文本框进行定制
            textField.clearButtonMode = UITextFieldViewModeAlways;
            textField.delegate = self;
            textField.returnKeyType = UIReturnKeyDone;
        }];
        
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            UITextField *textField = [ac.textFields firstObject];//可以创建很多个
            NSString *name = [textField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
            NSMutableArray *nameArray=[NSMutableArray array];
            for (int index=0; index<myArray.count; index++) {
                NSDictionary *dicts=myArray[index];
                [nameArray addObject:[[dicts allKeys]firstObject]];
            }
            if ([YLColoers jusdgeIfDiffrentNameInArray:nameArray name:name]) {
                YLHintView *hView=[[YLHintView alloc]initWithFrame:CGRectMake(0, 0,150, 120)];
                hView.center=self.view.center;
                [self.view addSubview:hView];
                 hView.message=@"已存在相同类别";
                [hView showOnView:self.view ForTimeInterval:1.5];
            }else{
             if (![name isEqualToString: @""]) {
            NSDictionary *dict=@{name:@[@"点击新增项目+"]};
            NSInteger insertPlace=tableViewArray.count-1;
            [tableViewArray insertObject:name atIndex:insertPlace];
                dispatch_async(dispatch_get_main_queue(), ^{
                    // 回到主线程在表格视图中插入新行
                    [myTableView insertRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:insertPlace inSection:0]] withRowAnimation:UITableViewRowAnimationRight];
                });
                
           
            [myArray insertObject:dict atIndex:insertPlace];
            [YLNsuserD saveArray:myArray forKey:@"costArray"];
            
            mainButton.titleLabel.text=name;
            [mainButton setTitle:name forState:UIControlStateNormal];
            
            changeButton.titleLabel.text=@"";
            [changeButton setTitle:@"" forState:UIControlStateNormal];
             }else{
                 
             }
            }
        }];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
        [ac addAction:okAction];
        [ac addAction:cancelAction];
        [self presentViewController:ac animated:YES completion:nil];
    }
    if (showModel==KINDMODEL) {
        UIAlertController *ac = [UIAlertController alertControllerWithTitle:@"创建项目" message:@"请输入添加的的名称" preferredStyle:UIAlertControllerStyleAlert];
        // 给警告控制器中添加文本框
        [ac addTextFieldWithConfigurationHandler:^(UITextField *textField) {
            // 此处可以对文本框进行定制
            textField.clearButtonMode = UITextFieldViewModeAlways;
            textField.delegate = self;
            textField.returnKeyType = UIReturnKeyDone;
        }];
        
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        UITextField *textField = [ac.textFields firstObject];//可以创建很多个
        NSString *name = [textField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
            NSMutableArray *nameArray=[NSMutableArray array];
            for (int index=0;index<myArray.count;index++){
                NSDictionary *temp=myArray[index];
                if ([mainButton.titleLabel.text isEqualToString:[[temp allKeys]firstObject]]) {
                    nameArray=[temp[mainButton.titleLabel.text]mutableCopy];
                }
            }
            if ([YLColoers jusdgeIfDiffrentNameInArray:nameArray name:name]) {
                YLHintView *hView=[[YLHintView alloc]initWithFrame:CGRectMake(0, 0,150, 120)];
                hView.center=self.view.center;
                [self.view addSubview:hView];
                hView.message=@"已存在相同类别";
                [hView showOnView:self.view ForTimeInterval:1.5];
            }else{
             if (![name isEqualToString: @""]) {
            NSInteger insertPlace=tableViewArray.count-1;
            [tableViewArray insertObject:name atIndex:insertPlace];
            dispatch_async(dispatch_get_main_queue(), ^{
                // 回到主线程在表格视图中插入新行
                [myTableView insertRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:insertPlace inSection:0]] withRowAnimation:UITableViewRowAnimationRight];
            });
            NSMutableArray *newArray=[NSMutableArray array];
            for (int index=0;index<myArray.count;index++){
                NSDictionary *temp=myArray[index];
                if ([mainButton.titleLabel.text isEqualToString:[[temp allKeys]firstObject]]) {
                    newArray=[temp[mainButton.titleLabel.text]mutableCopy];
                    [newArray insertObject:name atIndex:insertPlace];
                    NSDictionary *newTemp=@{mainButton.titleLabel.text:newArray};
                    [myArray insertObject:newTemp atIndex:index];
                    [myArray removeObject:temp];
                    [YLNsuserD saveArray:myArray forKey:@"costArray"];
                    break;
                }
            }
            changeButton.titleLabel.text=name;
            [changeButton setTitle:name forState:UIControlStateNormal];
             }else{
                 
             }
            }
        }];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
        [ac addAction:okAction];
        [ac addAction:cancelAction];
        [self presentViewController:ac animated:YES completion:nil];
        
    }
    [numberView removeFromSuperview];
    numberView=nil;
    
}
#pragma mark-获得日期，其他回调方法
-(NSString *)getDateNow{
    NSDate *date=[NSDate date];
    NSString *dataStr=[date formattedDateWithStyle:NSDateFormatterFullStyle];
    model.mainKey=date;
    return dataStr;
}
#pragma mark_textView的代理方法
-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    NSString *temp = [textView.text stringByReplacingCharactersInRange:range withString:text];
    if (temp.length > MAX_WORDS) {
        textView.text = [temp substringToIndex:MAX_WORDS];
        return NO;
    }if ([text isEqualToString:@"\n"]) {
        
        [textView resignFirstResponder];
        
        return NO;
        
    }
    return YES;
}

-(BOOL)textViewShouldEndEditing:(UITextView *)textView{
    [textView resignFirstResponder];
    
    return YES;
}
-(void)textViewDidEndEditing:(UITextView *)textView{
    if (textView.text.length!=0) {
        model.remarks=textView.text;
    }else{
        UITextView *myTextView=(id)[view viewWithTag:233];
        UILabel *label=[[UILabel alloc]init];
        label.textColor=[UIColor lightGrayColor];
        label.font=[UIFont systemFontOfSize:16];
        label.backgroundColor=[UIColor clearColor];
        label.text=@"备注：";
        label.tag=234;
        [myTextView addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(myTextView.mas_top);
            make.left.equalTo(myTextView.mas_left);
        }];
    }
    
}
-(void)textViewDidBeginEditing:(UITextView *)textView{
    UITextView *myTextView=(id)[view viewWithTag:233];
    UILabel *mylabel=(id)[myTextView viewWithTag:234];
    [numberView removeFromSuperview];
    numberView=nil;
    [mylabel removeFromSuperview];
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self selfTextViewResignFirstResponder];
    YLCostButton *button=(id)[view viewWithTag:209];
    if ([button.titleLabel.text isEqualToString:@""]) {
        button.titleLabel.text=@"0.0";
        [button setTitle:@"0.0" forState:UIControlStateNormal];
    }
    if ([button.titleLabel.text componentsSeparatedByString:@"."].count==1) {
        button.titleLabel.text=[[button.titleLabel.text componentsSeparatedByString:@"."]firstObject];
    }
    model.costMoney=button.titleLabel.text;
    [numberView removeFromSuperview];
    numberView=nil;
}
-(void)selfTextViewResignFirstResponder{
    UITextView *myTextView=(id)[view viewWithTag:233];
    [myTextView resignFirstResponder];
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if (textField.text.length >= MAX_WORDS/5) {
        return NO;
    }
    return YES;
}
@end

























