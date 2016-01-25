//
//  YLCostModelSetViewController.m
//  YLPrivateFinancialManagement
//
//  Created by 千锋 on 16/1/23.
//  Copyright (c) 2016年 mobiletrain. All rights reserved.
//

#import "YLCostModelSetViewController.h"
#import "YLPieReportView.h"
#import "YLMyCollectionViewCell.h"
#import "YLCostModelKindSetViewController.h"
#define MAX_WORDS 100
@interface YLCostModelSetViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UITextFieldDelegate>{
    UIImageView *selfBackView;
    YLPieReportView *chooseButtonView;
    UIView *backView;
    UIView *collectionBackView;
    NSMutableArray *dataArray;
    UICollectionView *_collectionView;
    UIView  *kindChooseBackView;
    BOOL  ifDelete;
}

@end

@implementation YLCostModelSetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"支出模版";
    chooseButtonView=[[YLPieReportView alloc]init];
     [self creaSelfBackView];
    [self customTabBarButtonTitle:@"返回" image:@"button_barbar" target:self action:@selector(onLeftClicked:)  isLeft:YES];
    backView=[[UIView alloc]initWithFrame:CGRectMake(0, 64, self.view.bounds.size.width, 40)];
    [self.view addSubview:backView];
    NSArray *nameArray=@[@"大类编辑",@"小类编辑"];
    [chooseButtonView creatChooseKindButtonView:backView nameArray:nameArray];
    [self creatChooseKindButtonCallBack];
    [self creatAddOrDeleteView];
   
    
    
}
-(void)creatkindChooseBackView{
    if (!kindChooseBackView) {
         kindChooseBackView=[[UIView alloc]init];
    }else{
        kindChooseBackView=nil;
         kindChooseBackView=[[UIView alloc]init];
    }
    [self.view addSubview:kindChooseBackView];
   [kindChooseBackView mas_makeConstraints:^(MASConstraintMaker *make) {
       make.top.equalTo(backView.mas_bottom);
       make.left.equalTo(self.view.mas_left);
       make.right.equalTo(self.view.mas_right);
       make.bottom.equalTo(self.view.mas_bottom);
   }];
}
//根据所选编辑不同的种类创建视图
-(void)creatAddOrDeleteView{
    if (collectionBackView==nil) {
         collectionBackView=[[UIView alloc]init];
    }else{
        collectionBackView=nil;
        collectionBackView=[[UIView alloc]init];
    }
   
    if (_chooseClassOrKindd==COSTDETAIL||_chooseClassOrKindd==DEFAULTDETAIL) {
        [self.view addSubview:collectionBackView];
        [kindChooseBackView removeFromSuperview];
        kindChooseBackView=nil;
        [collectionBackView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.view.mas_left);
            make.right.equalTo(self.view.mas_right);
            make.top.equalTo(backView.mas_bottom);
            make.height.equalTo(@(240));
        }];
        [self creatCollectionView];
    }else if(_chooseClassOrKindd==GETDETAL){
        NSArray *costArray=[YLNsuserD getArrayForKey:@"costArray"];
        [self creatkindChooseBackView];
        NSMutableArray *nameArray=[NSMutableArray array];
        for (int index=0; index<costArray.count-1; index++) {
            NSDictionary *temp=costArray[index];
            NSString *sttrName=[[temp allKeys]firstObject];
            [nameArray addObject:sttrName];
        }
        for (int index=0; index<nameArray.count; index++) {
            UIButton *button=[UIButton buttonWithType:UIButtonTypeCustom];
            [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [button setBackgroundImage:[UIImage imageNamed:@"button_bar"] forState:UIControlStateNormal];
            [button setTitle:[NSString stringWithFormat:@"编辑%@",nameArray[index]] forState:UIControlStateNormal];
            button.layer.cornerRadius=10;
            button.titleLabel.font=[UIFont systemFontOfSize:18];
            button.clipsToBounds=YES;
            [button addTarget:self action:@selector(allKindsButtonAction:) forControlEvents:UIControlEventTouchUpInside];
            [kindChooseBackView addSubview:button];
            [button mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerX.equalTo(kindChooseBackView.mas_centerX);
                make.width.equalTo(@(160));
                make.height.equalTo(@(40));
                make.top.equalTo(kindChooseBackView.mas_top).offset(20+43*index);
            }];
        }
    }
    
}

#pragma mark-创建集合视图
-(void)creatCollectionView{
    ifDelete=NO;
    UICollectionViewFlowLayout *layOUT=[[UICollectionViewFlowLayout alloc]init];
    [layOUT setScrollDirection:UICollectionViewScrollDirectionVertical];
    layOUT.itemSize=CGSizeMake(80, 30);
    layOUT.sectionInset=UIEdgeInsetsMake(10, 10,10, 10);
    _collectionView=[[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, 200, 200)collectionViewLayout:layOUT];
    [collectionBackView addSubview:_collectionView];
    [_collectionView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(collectionBackView.mas_left).offset(5);
        make.right.equalTo(collectionBackView.mas_right).offset(-5);
        make.top.equalTo(collectionBackView.mas_top);
        make.bottom.equalTo(collectionBackView.mas_bottom).offset(-40);
    }];
    _collectionView.backgroundColor=[UIColor whiteColor];
    //注册可重用单元格
    [_collectionView registerClass:[YLMyCollectionViewCell class] forCellWithReuseIdentifier:@"CELL"];
    //绑定数据源委托
    _collectionView.delegate=self;
    _collectionView.dataSource=self;
    NSArray *nameArray=@[@"添加",@"删除"];
    for (int index=0; index<nameArray.count; index++) {
        UIButton *button=[UIButton buttonWithType:UIButtonTypeCustom];
        [button setTitle:nameArray[index] forState:UIControlStateNormal];
        button.tag=1000+index;
        button.titleLabel.font=[UIFont systemFontOfSize:18];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setBackgroundImage:[UIImage imageNamed:@"buttonbar"] forState:UIControlStateNormal];
        [collectionBackView addSubview:button];
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(collectionBackView.mas_centerX).offset(-60+60*index);
            make.bottom.equalTo(collectionBackView.mas_bottom);
            make.height.equalTo(@(40));
            make.width.equalTo(@(60));
        }];
    }
    [self creatButtonCallBack];
    //加载数据
    [self loadDataModel];
}
-(void)loadDataModel{
    if (!dataArray) {
        dataArray=[NSMutableArray array];
    }else{
        [dataArray removeAllObjects];
    }
    if (_chooseClassOrKindd==COSTDETAIL||_chooseClassOrKindd==DEFAULTDETAIL) {
        NSArray *CostArray=[YLNsuserD getArrayForKey:@"costArray"];
        for (int index=0; index<CostArray.count; index++) {
            if (index!=CostArray.count-1) {
                NSDictionary *temp=CostArray[index];
                NSString *string=[[temp allKeys]firstObject];
                [dataArray addObject:string];
            }
        }
    }else if(_chooseClassOrKindd==GETDETAL){
       
        
    }
}
//小类编辑点击回调
-(void)allKindsButtonAction:(UIButton*)sender{
    YLCostModelKindSetViewController *kindVC=[[YLCostModelKindSetViewController alloc]init];
    kindVC.kindname=sender.titleLabel.text;
    [self.navigationController pushViewController:kindVC animated:YES];
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return dataArray.count;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    YLMyCollectionViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"CELL" forIndexPath:indexPath];
    cell.model=dataArray[indexPath.row];
    if (ifDelete) {
        cell.button.hidden=NO;
        //动画效果
        cell.transform=CGAffineTransformMakeRotation(-0.05);
        //第一个参数表示动画持续时间，参数2表示动画延迟时间
        [UIView animateWithDuration:0.1 delay:0 options:UIViewAnimationOptionRepeat|UIViewAnimationOptionAutoreverse|UIViewAnimationOptionAllowUserInteraction animations:^{
            cell.transform=CGAffineTransformMakeRotation(0.1);
        } completion:nil];
        
    }else{
        cell.button.hidden=YES;
        cell.transform=CGAffineTransformMakeRotation(0);
    }
    
    [cell.button addTarget:self action:@selector(ondeletaAction:) forControlEvents:UIControlEventTouchUpInside];
    return cell;
}
#pragma mark-创建小类回调
#pragma mark-创建回调
//集合视图上删除按钮的回调方法
-(void)ondeletaAction:(UIButton *)sender{
    YLMyCollectionViewCell *cell=(YLMyCollectionViewCell*)sender.superview.superview;
    //获取单元格对应的Iindexpath
    NSIndexPath *indexPath=[_collectionView indexPathForCell:cell];
    NSString *name=dataArray[indexPath.row];
    NSArray *costArray=[YLNsuserD getArrayForKey:@"costArray"];
    NSMutableArray *changeArray=[NSMutableArray arrayWithArray:costArray];
    NSDictionary *dict=[NSDictionary dictionary];
    for (NSDictionary *temp in changeArray) {
        NSString *sttrName=[[temp allKeys]firstObject];
        if ([sttrName isEqualToString:name]) {
            dict=temp;
            break;
        }
    }
    [changeArray removeObject:dict];
    [YLNsuserD saveArray:changeArray forKey:@"costArray"];
    [collectionBackView removeFromSuperview];
    collectionBackView=nil;
    [self creatAddOrDeleteView];
}
//创建添加和删除按钮的回调方法
-(void)creatButtonCallBack{
    UIButton *buttonAdd=(id)[collectionBackView viewWithTag:1000];
    UIButton *buttonDelete=(id)[collectionBackView viewWithTag:1001];
    [buttonAdd addTarget:self action:@selector(buttonAddAction:) forControlEvents:UIControlEventTouchUpInside];
    [buttonDelete addTarget:self action:@selector(buttonDeleteAction:) forControlEvents:UIControlEventTouchUpInside];
}
//添加按钮的回调方法
-(void)buttonAddAction:(UIButton *)sender{
       UIButton *buttonDelete=(id)[collectionBackView viewWithTag:1001];
    [buttonDelete setTitle:@"删除" forState:UIControlStateNormal];
     ifDelete=NO;
    [_collectionView reloadData];
    NSMutableArray *myArray=[[YLNsuserD getArrayForKey:@"costArray"] mutableCopy];
    UIAlertController *ac = [UIAlertController alertControllerWithTitle:@"创建分类" message:@"请输入添加分类的名称" preferredStyle:UIAlertControllerStyleAlert];
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
        if (![name isEqualToString: @""]) {
            NSDictionary *dict=@{name:@[@"点击新增项目+"]};
            NSInteger insertPlace=((int)myArray.count-2)<0?0:(myArray.count-2);
            NSInteger dataArrayInsertPlace=((int)myArray.count-1)<0?0:(myArray.count-1);
            [myArray insertObject:dict atIndex:insertPlace];
            [dataArray insertObject:name atIndex:dataArrayInsertPlace];
            [YLNsuserD saveArray:myArray forKey:@"costArray"];
            dispatch_async(dispatch_get_main_queue(), ^{
                [collectionBackView removeFromSuperview];
                collectionBackView=nil;
                [self creatAddOrDeleteView];
            });
        }else{
            
        }
     
        
    }];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    [ac addAction:okAction];
    [ac addAction:cancelAction];
    [self presentViewController:ac animated:YES completion:nil];
}
//删除按钮的回调方法
-(void)buttonDeleteAction:(UIButton *)sender{
    if (dataArray.count==0) {
        return;
    }
    if (ifDelete) {
        [sender setTitle:@"删除" forState:UIControlStateNormal];
        ifDelete=NO;
        
    }else{
        [sender setTitle:@"完成" forState:UIControlStateNormal];
        ifDelete=YES;
    }
    [_collectionView reloadData];
}
//创建选着大类还是小类的回调方法
-(void)creatChooseKindButtonCallBack{
    UIButton *bigClassButton=(id)[backView viewWithTag:920];
    UIButton *allKindsButton=(id)[backView viewWithTag:921];
    [bigClassButton addTarget:self action:@selector(bigClassChooseButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [allKindsButton addTarget:self action:@selector(allKindsButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
}

//选着大类的回调方法
-(void)bigClassChooseButtonClicked:(UIButton*)sender{
    _chooseClassOrKindd=COSTDETAIL;
    [collectionBackView removeFromSuperview];
     collectionBackView=nil;
    [self creatAddOrDeleteView];
   
}
//选着小类编辑的回调方法
-(void)allKindsButtonClicked:(UIButton*)sender{
    _chooseClassOrKindd=GETDETAL;
    [collectionBackView removeFromSuperview];
    collectionBackView=nil;
    [self creatAddOrDeleteView];
    
}
-(void)onLeftClicked:(UIButton*)sender{
    [self.navigationController popToRootViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if (textField.text.length >= MAX_WORDS) {
        return NO;
    }
    return YES;
}
-(void)textViewDidEndEditing:(UITextView *)textView{
    
    
}
//创建整个背景图
-(void)creaSelfBackView{
    selfBackView=[[UIImageView alloc]initWithFrame:self.view.frame];
    [self.view addSubview:selfBackView];
    selfBackView.userInteractionEnabled=YES;
    selfBackView.image=[UIImage imageNamed:@"report__bg"];
}
@end
