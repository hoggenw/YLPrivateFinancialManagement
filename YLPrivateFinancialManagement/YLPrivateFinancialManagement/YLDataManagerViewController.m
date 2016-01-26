//
//  YLDataManagerViewController.m
//  YLPrivateFinancialManagement
//
//  Created by 千锋 on 16/1/26.
//  Copyright (c) 2016年 mobiletrain. All rights reserved.
//

#import "YLDataManagerViewController.h"
#import "YLDetailView.h"
#import "YLDataManagerTableViewCell.h"
#import "YLGetModel.h"
#import "YLCostModel.h"
#import "YLHintView.h"
@interface YLDataManagerViewController ()<UITableViewDataSource,UITableViewDelegate>{
    UIImageView *selfBackView;
    UIImageView *upButtonView;
     YLDetailView *creatDataManagerView;
    UITableView *myTableView;
    NSMutableArray *tableViewArray;
}

@end

@implementation YLDataManagerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self creaSelfBackView];
    creatDataManagerView=[[YLDetailView alloc]init];
    [self customTabBarButtonTitle:@"返回" image:@"button_barbar" target:self action:@selector(onLeftClicked:)  isLeft:YES];
    NSArray *nameArray=@[@"收入数据管理",@"支出数据管理"];
    [creatDataManagerView creatTwoButtonForDetailView:[self creatUpButtonView] nameArray:nameArray];
   [self creatDownButtonCallBack];
    [self creatTableView];
}
#pragma mark-创建tabelview
-(void)creatTableView{
    myTableView=[[UITableView alloc]init];
    [self.view addSubview:myTableView];
    [myTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(upButtonView.mas_bottom);
        make.bottom.equalTo(self.view.mas_bottom);
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
    }];
    myTableView.tableFooterView = [[UIView alloc] init];
    myTableView.delegate=self;
    myTableView.dataSource=self;
    myTableView.rowHeight=60;
    [myTableView registerClass:[YLDataManagerTableViewCell class] forCellReuseIdentifier:@"CELL"];
    [self loadData];
    
    
    
}
//登陆数据
-(void)loadData{
    if (!tableViewArray) {
        tableViewArray=[NSMutableArray array];
    }else{
        [tableViewArray removeAllObjects];
    }
    //花费
    if (_chooseGetOrCost==DEFAULTDETAIL||_chooseGetOrCost==COSTDETAIL) {
        tableViewArray=[NSMutableArray arrayWithArray:[[YLDataBaseManager shareManager]selectCostModelByDESC]];
        YLCostModel *model=[[YLCostModel alloc]init];
        model.kind=@"项目";
        model.costMoney=@"花费";
        model.dateNow=@"日期";
        [tableViewArray insertObject:model atIndex:0];
        
    }else if(_chooseGetOrCost==GETDETAL){
        tableViewArray=[NSMutableArray arrayWithArray:[[YLDataBaseManager shareManager]selectGetModelByDESC]];
        YLGetModel *model=[[YLGetModel alloc]init];
        model.kind=@"项目";
        model.getMoney=@"收入";
        model.dateNow=@"日期";
        [tableViewArray insertObject:model atIndex:0];
    }
    
}

//组中单元格数组
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return tableViewArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    YLDataManagerTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"CELL" forIndexPath:indexPath];
    if (indexPath.row==0) {
        if([tableViewArray[indexPath.row]isKindOfClass:[YLGetModel class]]){
            cell.getModel=tableViewArray[indexPath.row];
        }else if ([tableViewArray[indexPath.row]isKindOfClass:[YLCostModel class]]){
            cell.costModel=tableViewArray[indexPath.row];
        }
    }else{
    if([tableViewArray[indexPath.row]isKindOfClass:[YLGetModel class]]){
        cell.getModel=tableViewArray[indexPath.row];
    }else if ([tableViewArray[indexPath.row]isKindOfClass:[YLCostModel class]]){
        cell.costModel=tableViewArray[indexPath.row];
    }
    [cell.deletaButton addTarget:self action:@selector(deletaButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return cell;
    
}

#pragma mark-创建页面及按键回调
//删除按钮回调
-(void)deletaButtonAction:(UIButton *)sender{
    YLDataManagerTableViewCell *cell=(YLDataManagerTableViewCell*)sender.superview.superview;
    //获取单元格对应的Iindexpath
    NSIndexPath *indexPath=[myTableView indexPathForCell:cell];
    if ([tableViewArray[indexPath.row] isKindOfClass:[YLGetModel class]]) {
        YLGetModel *model=[[YLGetModel alloc]init];
        model=tableViewArray[indexPath.row];
        if ([[YLDataBaseManager shareManager]deletYLGetModel:model]) {
            YLHintView *hView=[[YLHintView alloc]initWithFrame:CGRectMake(0, 0, 120, 80)];
            hView.center=self.view.center;
            hView.message=@"删除成功";
            [hView showOnView:myTableView ForTimeInterval:1.2];
        }
    }else if([tableViewArray[indexPath.row] isKindOfClass:[YLCostModel class]]){
        YLCostModel *model=[[YLCostModel alloc]init];
        model=tableViewArray[indexPath.row];
        if ([[YLDataBaseManager shareManager]deletYLCostModel:model]){
            YLHintView *hView=[[YLHintView alloc]initWithFrame:CGRectMake(0, 0, 120, 80)];
            hView.center=self.view.center;
            
            hView.message=@"删除成功";
            [hView showOnView:myTableView ForTimeInterval:1.2];
        }
        
    }
    [myTableView removeFromSuperview];
     myTableView=nil;
    [self creatTableView];
}
-(void)creatDownButtonCallBack{
    UIButton *getButton=(id)[upButtonView viewWithTag:800];//收入
    UIButton *costButton=(id)[upButtonView viewWithTag:801];//支出
    [costButton addTarget:self action:@selector(costButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [getButton addTarget:self action:@selector(getButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    
}
//支出
-(void)costButtonClicked:(UIButton *)sender{
    _chooseGetOrCost=COSTDETAIL;
    [myTableView removeFromSuperview];
    myTableView=nil;
    [self creatTableView];
}
//收入
-(void)getButtonClicked:(UIButton *)sender{
     _chooseGetOrCost=GETDETAL;
    [myTableView removeFromSuperview];
    myTableView=nil;
    [self creatTableView];
}
-(void)onLeftClicked:(UIButton*)sender{
    [self dismissViewControllerAnimated:YES completion:nil];
}
-(void)creaSelfBackView{
    selfBackView=[[UIImageView alloc]initWithFrame:self.view.frame];
    [self.view addSubview:selfBackView];
    selfBackView.userInteractionEnabled=YES;
    selfBackView.image=[UIImage imageNamed:@"report__bg"];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(UIImageView *)creatUpButtonView{
    upButtonView =[[UIImageView alloc]initWithFrame:CGRectMake(0, 64, self.view.bounds.size.width, 40)];
    upButtonView.userInteractionEnabled=YES;
    [self.view addSubview:upButtonView];
    return upButtonView;
    
}

@end
