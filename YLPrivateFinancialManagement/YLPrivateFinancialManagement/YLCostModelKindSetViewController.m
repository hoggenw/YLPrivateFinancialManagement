//
//  YLCostModelKindSetViewController.m
//  YLPrivateFinancialManagement
//
//  Created by 千锋 on 16/1/25.
//  Copyright (c) 2016年 mobiletrain. All rights reserved.
//

#import "YLCostModelKindSetViewController.h"
#import "YLMyCollectionViewCell.h"
@interface YLCostModelKindSetViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UITextFieldDelegate>{
     UIImageView *selfBackView;
    UIView *collectionBackView;
    UICollectionView *_collectionView;
     BOOL  ifDelete;
    NSMutableArray *dataArray;
}

@end

@implementation YLCostModelKindSetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
     [self creaSelfBackView];
    self.title=[NSString stringWithFormat:@"%@编辑",[self dealNeedString:_kindname]];
    [self customTabBarButtonTitle:@"返回" image:@"button_barbar" target:self action:@selector(onLeftClicked:)  isLeft:YES];
    [self creatAddOrDeleteView];
}
#pragma markt-创建集合视图
//根据所选编辑不同的种类创建视图
-(void)creatAddOrDeleteView{
    collectionBackView=[[UIView alloc]init];
    [self.view addSubview:collectionBackView];
    [collectionBackView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.view.mas_left);
            make.right.equalTo(self.view.mas_right);
            make.top.equalTo(self.view.mas_top).offset(70);
            make.height.equalTo(@(240));
        }];
    [self creatCollectionView];
      
}
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
        NSArray *CostArray=[YLNsuserD getArrayForKey:@"costArray"];
        for (int index=0; index<CostArray.count-1; index++) {
            NSDictionary *temp=CostArray[index];
            NSString *string=[[temp allKeys]firstObject];
            if ([string isEqualToString:[self dealNeedString:_kindname]]) {
                NSMutableArray *array=[NSMutableArray arrayWithArray:temp[string]];
                [array removeLastObject];
                dataArray=array;
                break;
            }
        }
    
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

#pragma mark-方法回调
-(void)ondeletaAction:(UIButton *)sender{
    YLMyCollectionViewCell *cell=(YLMyCollectionViewCell*)sender.superview.superview;
    //获取单元格对应的Iindexpath
    NSIndexPath *indexPath=[_collectionView indexPathForCell:cell];
    NSString *name=dataArray[indexPath.row];
    NSArray *costArray=[YLNsuserD getArrayForKey:@"costArray"];
    [dataArray removeObject:name];
    [dataArray addObject:@"点击新增项目+"];
    NSMutableArray *changeArray=[NSMutableArray arrayWithArray:costArray];
    NSDictionary *dict=@{[self dealNeedString:_kindname]:dataArray};
    for (int index=0;index<changeArray.count-1;index++){
        NSDictionary *temp =changeArray[index];
        NSString *sttrName=[[temp allKeys]firstObject];
        if ([sttrName isEqualToString:[self dealNeedString:_kindname]]) {
            [changeArray removeObject:temp];
            [changeArray insertObject:dict atIndex:index];
            break;
        }
    }
    [YLNsuserD saveArray:changeArray forKey:@"costArray"];
    [collectionBackView removeFromSuperview];
    collectionBackView=nil;
    [self creatAddOrDeleteView];
}
-(void)creatButtonCallBack{
    UIButton *buttonAdd=(id)[collectionBackView viewWithTag:1000];
    UIButton *buttonDelete=(id)[collectionBackView viewWithTag:1001];
    [buttonAdd addTarget:self action:@selector(buttonAddAction:) forControlEvents:UIControlEventTouchUpInside];
    [buttonDelete addTarget:self action:@selector(buttonDeleteAction:) forControlEvents:UIControlEventTouchUpInside];
}
#pragma mark-回调实现
-(void)buttonAddAction:(UIButton *)sender{
    UIButton *buttonDelete=(id)[self.view viewWithTag:1001];
    [buttonDelete setTitle:@"删除" forState:UIControlStateNormal];
    ifDelete=NO;
    [_collectionView reloadData];
    NSMutableArray *myArray=[[YLNsuserD getArrayForKey:@"costArray"] mutableCopy];
    UIAlertController *ac = [UIAlertController alertControllerWithTitle:@"创建项目" message:@"请输入添加项目的名称" preferredStyle:UIAlertControllerStyleAlert];
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
            [dataArray addObject:name];
            NSMutableArray *dictArray=[NSMutableArray arrayWithArray:dataArray];
            [dictArray addObject:@"点击新增项目+"];
            NSDictionary *dict=@{[self dealNeedString:_kindname]:dictArray};
             NSMutableArray *changeArray=[NSMutableArray arrayWithArray:myArray];
            for (int index=0;index<changeArray.count-1;index++){
                NSDictionary *temp =changeArray[index];
                NSString *sttrName=[[temp allKeys]firstObject];
                if ([sttrName isEqualToString:[self dealNeedString:_kindname]]) {
                    [changeArray removeObject:temp];
                    [changeArray insertObject:dict atIndex:index];
                    break;
                }
            }
            [YLNsuserD saveArray:changeArray forKey:@"costArray"];
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
-(void)onLeftClicked:(UIButton*)sender{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)creaSelfBackView{
    selfBackView=[[UIImageView alloc]initWithFrame:self.view.frame];
    [self.view addSubview:selfBackView];
    selfBackView.userInteractionEnabled=YES;
    selfBackView.image=[UIImage imageNamed:@"report__bg"];
}
-(NSString *)dealNeedString:(NSString *)string{
    NSArray *array=[string componentsSeparatedByString:@"辑"];
    return [array lastObject];
}

@end
