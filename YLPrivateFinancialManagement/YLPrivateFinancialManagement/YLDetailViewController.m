//
//  YLDetailViewController.m
//  YLPrivateFinancialManagement
//
//  Created by 千锋 on 16/1/11.
//  Copyright (c) 2016年 mobiletrain. All rights reserved.
//

#import "YLDetailViewController.h"
#import "YLDetailView.h"
#import "YLDetailTableViewCell.h"
#import "YLBudgeModel.h"
@interface YLDetailViewController ()<UITableViewDataSource,UITableViewDelegate>{
    UIImageView *upButtonView;
    YLDetailView *creatDetailView;
    UIImageView *downButtonView;
    UITableView *myTableView;
    NSMutableArray *tableViewArray;
    YLDataDeal  *dataDeal;
}

@end

@implementation YLDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"收支明细";
    creatDetailView=[[YLDetailView alloc]init];
    [self customTabBarButtonTitle:@"返回" image:@"button_barbar" target:self action:@selector(onLeftClicked:)  isLeft:YES];
    [self creatSelfTitleImageView];
    NSArray *nameArray=@[@"收入明细",@"支出明细"];
    [creatDetailView creatTwoButtonForDetailView:[self creatUpButtonView] nameArray:nameArray];
    NSArray *fourNameArray=@[@"按日分类",@"按月分类",@"类别分类"];
    [creatDetailView creatFourKindsButtonForDetailView:[self creatDownButtonView] nameArray:fourNameArray];
    dataDeal=[YLDataDeal shareDataDeal];
    [self creatTableView];
  
}
#pragma mark-创建中间的tabelview
-(void)creatTableView{
    myTableView=[[UITableView alloc]init];
    [self.view addSubview:myTableView];
    [myTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(upButtonView.mas_bottom);
        make.bottom.equalTo(downButtonView.mas_top);
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
    }];
    myTableView.tableFooterView = [[UIView alloc] init];
    myTableView.delegate=self;
    myTableView.dataSource=self;
    myTableView.rowHeight=60;
    [myTableView registerClass:[YLDetailTableViewCell class] forCellReuseIdentifier:@"CELL"];
    [self loadData];
    [self creatDownButtonCallBack];
    
    
}
//登陆数据
-(void)loadData{
    if (!tableViewArray) {
        tableViewArray=[NSMutableArray array];
    }else{
        [tableViewArray removeAllObjects];
    }
    //花费
    if (_chooseClass==DEFAULTDETAIL||_chooseClass==COSTDETAIL) {
        //按日花费
        if (_chooseShowKind==DETAULTKIND||_chooseShowKind==DAYKINDDETAIL) {
            tableViewArray=[NSMutableArray arrayWithArray:[YLDataDeal costTotalByDay]];
            //按月花费
        }else if (_chooseShowKind==MONTHKINDDATAIL){
            tableViewArray=[NSMutableArray arrayWithArray:[YLDataDeal costTotalByMonth]];
            //种类花费
        }else if (_chooseShowKind==KAINSDATAIL){
            tableViewArray=[NSMutableArray arrayWithArray:[YLDataDeal costTotalByKinds]];
        }
        //
    }else if(_chooseClass==GETDETAL){
        if (_chooseShowKind==DETAULTKIND||_chooseShowKind==DAYKINDDETAIL) {
            tableViewArray=[[YLDataDeal getTotalByDay]mutableCopy];
        }else if (_chooseShowKind==MONTHKINDDATAIL){
            tableViewArray=[[YLDataDeal getTotalByMonth]mutableCopy];
        }else if (_chooseShowKind==KAINSDATAIL){
            tableViewArray=[[YLDataDeal getTotalByKinds]mutableCopy];
        }
        
        
    }
   
}

//组中单元格数组
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return tableViewArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    YLDetailTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"CELL" forIndexPath:indexPath];
    cell.model=tableViewArray[indexPath.row];
    return cell;
}

-(void)onLeftClicked:(UIButton*)sender{
    [self.navigationController popToRootViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)creatSelfTitleImageView{
    UIImageView *titleImageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 64)];
    [self.view addSubview:titleImageView];
    titleImageView.image=[UIImage imageNamed:@"cost_bg_up"];
}
-(UIImageView *)creatUpButtonView{
    upButtonView =[[UIImageView alloc]initWithFrame:CGRectMake(0, 64, self.view.bounds.size.width, 40)];
    upButtonView.userInteractionEnabled=YES;
    [self.view addSubview:upButtonView];
    return upButtonView;

}
-(UIImageView *)creatDownButtonView{
    downButtonView =[[UIImageView alloc]initWithFrame:CGRectMake(0, self.view.bounds.size.height-50, self.view.bounds.size.width,50)];
    downButtonView.userInteractionEnabled=YES;
    [self.view addSubview:downButtonView];
    return downButtonView;
    
}
//下面按键的回调方法
-(void)creatDownButtonCallBack{
    UIButton *dayButton=(id)[downButtonView viewWithTag:810];
    UIButton *monthButton=(id)[downButtonView viewWithTag:811];
    UIButton *kindButton=(id)[downButtonView viewWithTag:812];
    [dayButton addTarget:self action:@selector(dayShowButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [monthButton addTarget:self action:@selector(monthButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [kindButton addTarget:self action:@selector(kindButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    UIButton *costButton=(id)[upButtonView viewWithTag:800];//收入
    UIButton *getButton=(id)[upButtonView viewWithTag:801];//支出
    [costButton addTarget:self action:@selector(costButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [getButton addTarget:self action:@selector(getButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    
}
//支出
-(void)getButtonClicked:(UIButton *)sender{
    _chooseClass=COSTDETAIL;
    [myTableView removeFromSuperview];
    myTableView=nil;
    [self creatTableView];
}
//收入
-(void)costButtonClicked:(UIButton *)sender{
    _chooseClass=GETDETAL;
    [myTableView removeFromSuperview];
    myTableView=nil;
    [self creatTableView];
}
-(void)dayShowButtonClicked:(UIButton *)sender{
    _chooseShowKind=DAYKINDDETAIL;
    [myTableView removeFromSuperview];
    myTableView=nil;
    [self creatTableView];
}
-(void)monthButtonClicked:(UIButton *)sender{
    _chooseShowKind=MONTHKINDDATAIL;
    [myTableView removeFromSuperview];
    myTableView=nil;
    [self creatTableView];
}
-(void)kindButtonClicked:(UIButton *)sender{
    _chooseShowKind=KAINSDATAIL;
    [myTableView removeFromSuperview];
    myTableView=nil;
    [self creatTableView];
}
@end































