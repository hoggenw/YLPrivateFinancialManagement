//
//  YLGetModelViewController.m
//  YLPrivateFinancialManagement
//
//  Created by 千锋 on 16/1/23.
//  Copyright (c) 2016年 mobiletrain. All rights reserved.
//

#import "YLGetModelViewController.h"
#import "YLMyCollectionViewCell.h"
#define MAX_WORDS 100
@interface YLGetModelViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UITextFieldDelegate>{
    UIImageView *selfBackView;
    NSMutableArray *dataArray;
    UICollectionView *_collectionView;
    BOOL  ifDelete;
}

@end

@implementation YLGetModelViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self creaSelfBackView];
    self.title=@"收入模版";
    [self customTabBarButtonTitle:@"返回" image:@"button_barbar" target:self action:@selector(onLeftClicked:)  isLeft:YES];
    [self creatCollectionView];
    
}
-(void)creatCollectionView{
    ifDelete=NO;
    UICollectionViewFlowLayout *layOUT=[[UICollectionViewFlowLayout alloc]init];
    [layOUT setScrollDirection:UICollectionViewScrollDirectionVertical];
    layOUT.itemSize=CGSizeMake(80, 30);
    layOUT.sectionInset=UIEdgeInsetsMake(10, 10,10, 10);
    _collectionView=[[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, 200, 200)collectionViewLayout:layOUT];
    [self.view addSubview:_collectionView];
    [_collectionView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(5);
        make.right.equalTo(self.view.mas_right).offset(-5);
        make.top.equalTo(self.view.mas_top).offset(74);
        make.height.equalTo(@(200));
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
        [self.view addSubview:button];
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.view.mas_centerX).offset(-60+60*index);
            make.top.equalTo(_collectionView.mas_bottom);
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
    NSArray *getArray=[YLNsuserD getArrayForKey:@"getArray"];
    for (int index=0; index<getArray.count; index++) {
        if (index!=getArray.count-1) {
            [dataArray addObject:getArray[index]];
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
#pragma mark-回调实现
-(void)buttonAddAction:(UIButton *)sender{
    UIButton *buttonDelete=(id)[self.view viewWithTag:1001];
    [buttonDelete setTitle:@"删除" forState:UIControlStateNormal];
    ifDelete=NO;
    [_collectionView reloadData];
    NSMutableArray *myArray=[[YLNsuserD getArrayForKey:@"getArray"] mutableCopy];
    UIAlertController *ac = [UIAlertController alertControllerWithTitle:@"创建项目" message:@"请输入添加分类的名称" preferredStyle:UIAlertControllerStyleAlert];
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
        NSInteger insertPlace=((int)myArray.count-2)<0?0:(myArray.count-2);
        NSInteger dataArrayInsertPlace=((int)myArray.count-1)<0?0:(myArray.count-1);
        [myArray insertObject:name atIndex:insertPlace];
        [dataArray insertObject:name atIndex:dataArrayInsertPlace];
        [YLNsuserD saveArray:myArray forKey:@"getArray"];
        dispatch_async(dispatch_get_main_queue(), ^{
            [_collectionView removeFromSuperview];
            UIButton *buttonAdd=(id)[self.view viewWithTag:1000];
            UIButton *buttonDelete=(id)[self.view viewWithTag:1001];
            [buttonDelete removeFromSuperview];
            [buttonAdd removeFromSuperview];
            _collectionView=nil;
          [self creatCollectionView];
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
-(void)ondeletaAction:(UIButton *)sender{
    YLMyCollectionViewCell *cell=(YLMyCollectionViewCell*)sender.superview.superview;
    //获取单元格对应的Iindexpath
    NSIndexPath *indexPath=[_collectionView indexPathForCell:cell];
    NSString *name=dataArray[indexPath.row];
     NSArray *getArray=[YLNsuserD getArrayForKey:@"getArray"];
    NSMutableArray *changeArray=[NSMutableArray arrayWithArray:getArray];
    [changeArray removeObject:name];
    [YLNsuserD saveArray:changeArray forKey:@"getArray"];
    [_collectionView removeFromSuperview];
    UIButton *buttonAdd=(id)[self.view viewWithTag:1000];
    UIButton *buttonDelete=(id)[self.view viewWithTag:1001];
    [buttonDelete removeFromSuperview];
    [buttonAdd removeFromSuperview];
    _collectionView=nil;
    [self creatCollectionView];
}
#pragma mark-创建回调
-(void)creatButtonCallBack{
    UIButton *buttonAdd=(id)[self.view viewWithTag:1000];
    UIButton *buttonDelete=(id)[self.view viewWithTag:1001];
    [buttonAdd addTarget:self action:@selector(buttonAddAction:) forControlEvents:UIControlEventTouchUpInside];
    [buttonDelete addTarget:self action:@selector(buttonDeleteAction:) forControlEvents:UIControlEventTouchUpInside];
}

-(void)creaSelfBackView{
    selfBackView=[[UIImageView alloc]initWithFrame:self.view.frame];
    [self.view addSubview:selfBackView];
    selfBackView.userInteractionEnabled=YES;
    selfBackView.image=[UIImage imageNamed:@"report__bg"];
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
@end
