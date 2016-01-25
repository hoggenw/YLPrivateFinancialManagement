//
//  YLBudgetViewController.m
//  YLPrivateFinancialManagement
//
//  Created by 千锋 on 16/1/12.
//  Copyright (c) 2016年 mobiletrain. All rights reserved.
//

#import "YLBudgetViewController.h"
#import "YLCostButton.h"
#import "YLBudgeModel.h"
#import "YLCostModel.h"
#import "YLBudgetTableViewCell.h"
#import "YLHintView.h"
#define MAX_WORDS 100
typedef NS_ENUM(NSInteger, CHOOSEKEYBOARD){
    BUDGETKEYBOARD=0,
    TEXTFILEKEYBORAD=1,
    
    
};
@interface YLBudgetViewController ()<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>{
    UIImageView *upImageView;
    UIImageView  *numberView;
    UIImageView *downImageView;
    UITableView *myTableView;
    NSMutableArray *tableViewArray;
    CHOOSEKEYBOARD nowChoose;
    UIAlertController *ac;
    YLBudgeModel *modelNew;
    UIView *textFieldView;
    NSInteger indexRow;
}

@end

@implementation YLBudgetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"预算";
    [self customTabBarButtonTitle:@"返回" image:@"button_barbar" target:self action:@selector(onLeftClicked:)  isLeft:YES];
    [self creatView];
    [self creatTableView];
    CGFloat budget= [YLNsuserD getDoubleForKey:@"budget"];
    [self reloadBudget:budget];
    [self creatBottomButton];
}
-(void)creatBottomButton{
    UIButton *button=[UIButton buttonWithType:UIButtonTypeSystem];
    [button setBackgroundImage:[UIImage imageNamed:@"button_budget"] forState:UIControlStateNormal];
    [button setTitle:@"分类预算加总" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(onBottomButtonAction:) forControlEvents:UIControlEventTouchDown];
    [downImageView addSubview:button];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(downImageView.mas_left).offset(15);
        make.right.equalTo(downImageView.mas_right).offset(-15);
        make.bottom.equalTo(downImageView.mas_bottom).offset(-5);
        make.height.equalTo(@(50));
    }];
    button.layer.cornerRadius=10;
    button.clipsToBounds=YES;
    button.titleLabel.font=[UIFont boldSystemFontOfSize:22];

}
-(void)onLeftClicked:(UIButton*)sender{
    [self.navigationController popToRootViewControllerAnimated:YES];
}
-(void)onBottomButtonAction:(UIButton*)sender{
    CGFloat budget=[self kindsBudget];
    [self reloadBudget:budget];
    YLHintView *hView=[[YLHintView alloc]initWithFrame:CGRectMake(0, 0, 200, 150)];
    hView.center=self.view.center;
    [self.view addSubview:hView];
  
    hView.message=@"分类预算已归总";
   [hView showOnView:self.view ForTimeInterval:1.2];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//更新总预算的方法
-(void)reloadBudget:(CGFloat)budget{
    CGFloat kindsBudget=[self kindsBudget];
    if (budget>=kindsBudget) {
        [YLNsuserD saveDouble:budget forKey:@"budget"];
        
    }else{
        [YLNsuserD saveDouble:kindsBudget forKey:@"budget"];
        budget=kindsBudget;
    }
    YLCostButton *budgetButton=(id)[upImageView viewWithTag:600];
    UILabel   *leftLabel=(id)[upImageView viewWithTag:601];
    UILabel   *rightLabel=(id)[upImageView viewWithTag:610];
    CGFloat costThisMonth=[YLTimeDeal costThisMonthTotal];
    CGFloat surplus=(budget-costThisMonth)>0?(budget-costThisMonth):0;
    dispatch_async(dispatch_get_main_queue(), ^{
        leftLabel.text=[NSString stringWithFormat:@"%.1lf",costThisMonth];
        rightLabel.text=[NSString stringWithFormat:@"%.1lf",surplus];
        budgetButton.titleLabel.text=[NSString stringWithFormat:@"%.0lf",budget];
        [budgetButton setTitle:[NSString stringWithFormat:@"%.0lf",budget] forState:UIControlStateNormal];
    });
    
}
//所有分类的总预算
-(CGFloat)kindsBudget{
    CGFloat kindsBudget=0;
    NSArray *nameArray=[YLNsuserD getArrayForKey:@"costArray"];
    for (int index=0; index<nameArray.count; index++) {
        if (index!=nameArray.count-1) {
            YLBudgeModel *model=[[YLBudgeModel alloc]init];
            NSDictionary *temp=nameArray[index];
            model.name=[[temp allKeys] firstObject];
            kindsBudget+=[YLNsuserD getDoubleForKey:model.name];
        }
    }
    return kindsBudget;
}

//计算该种类花费
-(CGFloat)costThisMonthTotal:(NSString*)name{
    //字符串时间转换
    CGFloat costNow=0;
    //获取现在时间
    NSDate *date=[NSDate date];
    NSDate *nextMonthDate=[date dateByAddingMonths:1];
    NSDate *thisMonthBegin=[YLTimeDeal dealTimeDate:date];
    NSDate *thisMonthEnd=[YLTimeDeal dealTimeDate:nextMonthDate];
    //拼接本月时间
    YLDataBaseManager *manager=[YLDataBaseManager shareManager];
    NSArray *costArray=[manager selectCostModelFrom:thisMonthBegin to:thisMonthEnd];
    for (YLCostModel *model in costArray) {
        if ([model.bigClass isEqualToString:name]) {
            costNow+=[model.costMoney doubleValue];
        }
        
    }
    return costNow;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    nowChoose=TEXTFILEKEYBORAD;
    indexRow=indexPath.row;
    [numberView removeFromSuperview];
    numberView=nil;
   modelNew=tableViewArray[indexPath.row];
    NSString *message=[NSString stringWithFormat:@"请输入%@预算的额度",modelNew.name];
    ac = [UIAlertController alertControllerWithTitle:@"预算" message:message preferredStyle:UIAlertControllerStyleAlert];
    __weak typeof(self) weakSelf=self;
    // 给警告控制器中添加文本框
    [ac addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        // 此处可以对文本框进行定制
        textField.clearButtonMode = UITextFieldViewModeAlways;
        textField.delegate = weakSelf;
        textField.tag=609;
        textField.inputView=[weakSelf creatTextFieldView];
        
    }];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        // 点击确定按钮就创建相册
        UITextField *textField = [ac.textFields firstObject];
        if ([textField.text isEqualToString:@""]) {
            textField.text=@"0.0";
        }
         modelNew.budget=[NSString stringWithFormat:@"%.1lf",[textField.text doubleValue]];
        CGFloat centerNumber=[modelNew.budget doubleValue]-[self costThisMonthTotal:modelNew.name];
        modelNew.surplus=[NSString stringWithFormat:@"%.1lf",centerNumber>0?centerNumber:0];
        [tableViewArray removeObjectAtIndex:indexPath.row];
        [tableViewArray insertObject:modelNew atIndex:indexPath.row];
        //记录完成后存储
        [YLNsuserD saveDouble:[modelNew.budget doubleValue] forKey:modelNew.name];
        //取出本地存储的预算
        CGFloat budget= [YLNsuserD getDoubleForKey:@"budget"];
        [self reloadBudget:budget];
        dispatch_async(dispatch_get_main_queue(), ^{
            [myTableView reloadData];
        });
    }];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    [ac addAction:okAction];
    [ac addAction:cancelAction];
    [self presentViewController:ac animated:YES completion:nil];
    
}
#pragma mark-创建tabelView
-(void)creatTableView{
    myTableView=[[UITableView alloc]init];
    UIImageView *backView=[[UIImageView alloc]init];
    backView.image=[UIImage imageNamed:@"report__bg"];
    [myTableView setBackgroundView:backView];
    [downImageView addSubview:myTableView];
    [myTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(downImageView).insets(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    myTableView.tableFooterView=[[UIView alloc]init];
    myTableView.delegate=self;
    myTableView.dataSource=self;
    myTableView.rowHeight=60;
    [myTableView registerClass:[YLBudgetTableViewCell class] forCellReuseIdentifier:@"CELL"];
    [self loadData];
    
    
}
//登陆数据
-(void)loadData{
    if (!tableViewArray) {
        tableViewArray=[NSMutableArray array];
    }else{
        [tableViewArray removeAllObjects];
    }
    NSArray *nameArray=[YLNsuserD getArrayForKey:@"costArray"];
    for (int index=0; index<nameArray.count; index++) {
        if (index!=nameArray.count-1) {
            YLBudgeModel *model=[[YLBudgeModel alloc]init];
            NSDictionary *temp=nameArray[index];
            model.name=[[temp allKeys] firstObject];
            model.budget=[NSString stringWithFormat:@"%.1lf",[YLNsuserD getDoubleForKey:model.name] ];
            CGFloat centerNumber=[YLNsuserD getDoubleForKey:model.name]-[self costThisMonthTotal:model.name];
            model.surplus=[NSString stringWithFormat:@"%.1lf",centerNumber>0?centerNumber:0];
            [tableViewArray addObject:model];
        }
    }
}

//组中单元格数组
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return tableViewArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    YLBudgetTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"CELL" forIndexPath:indexPath];
    cell.model=tableViewArray[indexPath.row];
    return cell;
}

#pragma mark-按键回调方法
//键盘编辑完成回调方法
-(void)flishEditNumber:(UIButton *)sender {
    if (nowChoose==BUDGETKEYBOARD) {
        YLCostButton *button=(id)[upImageView viewWithTag:600];
        if ([button.titleLabel.text isEqualToString:@""]) {
            button.titleLabel.text=@"0.0";
            [button setTitle:@"0.0" forState:UIControlStateNormal];
        }
        //判断是否存储预算
        CGFloat budget=[button.titleLabel.text doubleValue];
        [self reloadBudget:budget];
        [numberView removeFromSuperview];
        numberView=nil;
        
    }else if(nowChoose==TEXTFILEKEYBORAD){
        UITextField *textField=(id)[ac.view viewWithTag:609];
        if ([textField.text isEqualToString:@""]) {
            textField.text=@"0.0";
        }
        modelNew.budget=[NSString stringWithFormat:@"%.1lf",[textField.text doubleValue]];
        CGFloat centerNumber=[modelNew.budget doubleValue]-[self costThisMonthTotal:modelNew.name];
        modelNew.surplus=[NSString stringWithFormat:@"%.1lf",centerNumber>0?centerNumber:0];
        [tableViewArray removeObjectAtIndex:indexRow];
        [tableViewArray insertObject:modelNew atIndex:indexRow];
        [YLNsuserD saveDouble:[modelNew.budget doubleValue] forKey:modelNew.name];
        //取出本地存储的预算
        CGFloat budget= [YLNsuserD getDoubleForKey:@"budget"];
        [self reloadBudget:budget];
        dispatch_async(dispatch_get_main_queue(), ^{
            [myTableView reloadData];
            [textFieldView removeFromSuperview];
            textFieldView=nil;
        });
        
        [ac dismissViewControllerAnimated:YES completion:nil];
    }
}
-(void)budgetButtonClicked:(UIButton *)sender{
    nowChoose=BUDGETKEYBOARD;
    if (!numberView) {
        [self creatSelfView];
        [self creatNumberControl:numberView];
    }
}

//数字花费显示回调方法
-(void)onCostNumberShow:(UIButton *)sender{
    if (nowChoose==BUDGETKEYBOARD) {
        YLCostButton *button=(id)[upImageView viewWithTag:600];
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
    }else if(nowChoose==TEXTFILEKEYBORAD){
        UITextField *textField=(id)[ac.view viewWithTag:609];
        if ([sender.titleLabel.text isEqualToString:@"."]&&([textField.text isEqualToString:@""]||[textField.text isEqualToString:@"0.0"])) {
            
        }else{
            NSMutableString *buttonStr=[NSMutableString string];
            if ([textField.text isEqualToString:@"0.0"]) {
                textField.text=@"";
                buttonStr=[NSMutableString stringWithString:@""];
            }else{
                buttonStr=[NSMutableString stringWithString:textField.text];
            }
            NSString *resultStr=[YLNsuserD judgeNumberIfRight:buttonStr addString:sender.titleLabel.text];
            textField.text=resultStr;
        }
    }
   
}
//删除按钮回调方法
//自定义键盘删除一个一个删除
-(void)deleteNumber:(UIButton*)sender{
    if (nowChoose==BUDGETKEYBOARD) {
        YLCostButton *button=(id)[upImageView viewWithTag:600];
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
    }else if(nowChoose==TEXTFILEKEYBORAD){
        UITextField *textField=(id)[ac.view viewWithTag:609];
        if (textField.text.length!=0) {
            NSMutableString *str1,*str=[textField.text mutableCopy];
            str1=[NSMutableString string];
            
            for (int i=0; i<str.length-1; i++) {
                [str1 appendFormat:@"%c",[str characterAtIndex:i]];
            }
            textField.text=str1;
        }else{
        }
    }
}

//自定义键盘重置方法
-(void)deleteAllEditNumber:(UIButton *)sender{
    if (nowChoose==BUDGETKEYBOARD) {
        YLCostButton *button=(id)[upImageView viewWithTag:600];
        NSString *str=@"";
        button.titleLabel.text=str;
        [button setTitle:str forState:UIControlStateNormal];
    }else if(nowChoose==TEXTFILEKEYBORAD){
        UITextField *textField=(id)[ac.view viewWithTag:609];
        textField.text=@"";
    }
    
}
#pragma mark-其他回调方法
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    YLCostButton *button=(id)[upImageView viewWithTag:600];
    if ([button.titleLabel.text isEqualToString:@""]) {
        button.titleLabel.text=@"0.0";
        [button setTitle:@"0.0" forState:UIControlStateNormal];
    }else{
    CGFloat buget=[YLNsuserD getDoubleForKey:@"budget"];
    NSString *str=[NSString stringWithFormat:@"%.1lf",buget];
    button.titleLabel.text=str;
    [button setTitle:str forState:UIControlStateNormal];
    }
    [numberView removeFromSuperview];
     numberView=nil;
}
//
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if (textField.text.length >= MAX_WORDS/5) {
        return NO;
    }
    return YES;
}
#pragma mark-创建视图
//创建预算上半部分背景图
-(void)creatView{
    //创建背景图片
    upImageView=[[UIImageView alloc]init];
    upImageView.userInteractionEnabled=YES;
    upImageView.image=[UIImage imageNamed:@"yusuanup"];
    [self.view addSubview:upImageView];
    [upImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top);
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.bottom.equalTo(self.view.mas_top).offset(160);
    }];
    //创建label
    UILabel *selfLabel=[[UILabel alloc]init];
    selfLabel.textAlignment=NSTextAlignmentCenter;
    selfLabel.text=@"本月总预算";
    selfLabel.font=[UIFont systemFontOfSize:18];
    [upImageView addSubview:selfLabel];
    [selfLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(upImageView.mas_centerX);
        make.top.equalTo(upImageView.mas_top).offset(60);
    }];
    //创建显示button
    YLCostButton *budgetButton=[YLCostButton buttonWithType:UIButtonTypeCustom];
    budgetButton.titleLabel.textAlignment=NSTextAlignmentCenter;
    budgetButton.titleLabel.font=[UIFont systemFontOfSize:36];
    budgetButton.tag=600;
    CGFloat budget=[YLNsuserD getDoubleForKey:@"budget"];
    [budgetButton setTitle:[NSString stringWithFormat:@"%.1lf",budget] forState:UIControlStateNormal];
    [budgetButton addTarget:self action:@selector(budgetButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [upImageView addSubview:budgetButton];
    [budgetButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(upImageView.mas_left);
        make.right.equalTo(upImageView.mas_right);
        make.top.equalTo(selfLabel.mas_bottom);
    }];
    //创建下面显示的label；
    CGFloat costThisMonth=[YLTimeDeal costThisMonthTotal];
    CGFloat surplus=(budget-costThisMonth)>0?(budget-costThisMonth):0;
    NSArray *array=@[@"已用",@(costThisMonth),@"剩余",@(surplus)];
    for (int index=0; index<4; index++) {
        UILabel *ShowLabel=[[UILabel alloc]init];
        if (index%2==0) {
            ShowLabel.textAlignment=NSTextAlignmentCenter;
            ShowLabel.text=array[index];
        }else{
            ShowLabel.textAlignment=NSTextAlignmentRight;
            if (index==3) {
                ShowLabel.tag=610;
            }else{
            ShowLabel.tag=600+index;
            }
            ShowLabel.text=[NSString stringWithFormat:@"%@", array[index]];
        }
        [upImageView addSubview:ShowLabel];
        ShowLabel.font=[UIFont systemFontOfSize:16];
        ShowLabel.layer.borderWidth=0.3;
        NSInteger width=(self.view.bounds.size.width-1)/4.f;
        [ShowLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            if (index==2) {
                make.left.equalTo(upImageView.mas_left).offset(width*index+1);
            }else{
                make.left.equalTo(upImageView.mas_left).offset(width*index);
            }
            make.top.equalTo(budgetButton.mas_bottom).offset(1);
            make.bottom.equalTo(upImageView.mas_bottom).offset(-1);
            make.width.equalTo(@(width));
        }];
        downImageView=[[UIImageView alloc]init];
        
        downImageView.userInteractionEnabled=YES;
        [self.view addSubview:downImageView];
        [downImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(upImageView.mas_bottom);
            make.left.equalTo(self.view.mas_left);
            make.right.equalTo(self.view.mas_right);
            make.bottom.equalTo(self.view.mas_bottom);
        }];
    }
}
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
-(void)creatNumberControl:(UIView*)superView{
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
                setButton.tag=640+counts+index*(countRIght)+1;
            }else{
                setButton.tag=640+counts+index*(countRIght);//243删除,250确定,254，重置
            }
            setButton.titleLabel.font=[UIFont systemFontOfSize:22];
            [setButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            if (setButton.tag==643) {
                [setButton addTarget:self action:@selector(deleteNumber:) forControlEvents:UIControlEventTouchUpInside];
            }else if(setButton.tag==650){
                [setButton addTarget:self action:@selector(flishEditNumber:) forControlEvents:UIControlEventTouchUpInside];
            }else if (setButton.tag==654){
                [setButton addTarget:self action:@selector(deleteAllEditNumber:) forControlEvents:UIControlEventTouchUpInside];
            }else{
                [setButton addTarget:self action:@selector(onCostNumberShow:) forControlEvents:UIControlEventTouchUpInside];
            }
            setButton.layer.borderWidth=0.5;
            [setButton setBackgroundColor:[UIColor whiteColor]];
            [superView addSubview:setButton];
            
            
        }
        countRIght=array.count;
    }
}
//自定义键盘
-(UIView *)creatTextFieldView{
    textFieldView=[[UIView alloc]init];
    textFieldView.frame=CGRectMake(0, 0, 0, 290);
    [self creatNumberControl:textFieldView];
    return textFieldView;
    
}
@end



























