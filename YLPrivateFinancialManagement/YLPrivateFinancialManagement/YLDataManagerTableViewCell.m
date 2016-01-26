//
//  YLDataManagerTableViewCell.m
//  YLPrivateFinancialManagement
//
//  Created by 千锋 on 16/1/26.
//  Copyright (c) 2016年 mobiletrain. All rights reserved.
//

#import "YLDataManagerTableViewCell.h"
#import "YLGetModel.h"
#import "YLCostModel.h"

@implementation YLDataManagerTableViewCell{
    UILabel *mainLabel;
}

- (void)awakeFromNib {
    // Initialization code
}
-(void)setGetModel:(YLGetModel *)getModel{
    _getModel=getModel;
    if (!mainLabel) {
        mainLabel=[[UILabel alloc]init];
    }else{
        for (UIView *temp in self.contentView.subviews) {
            [temp removeFromSuperview];
        }
        mainLabel=[[UILabel alloc]init];
    }
    [self creatTabelCellView:self.contentView getmodel:getModel];
    
}
-(void)setCostModel:(YLCostModel *)costModel{
    _costModel=costModel;
    if (!mainLabel) {
        mainLabel=[[UILabel alloc]init];
    }else{
        for (UIView *temp in self.contentView.subviews) {
            [temp removeFromSuperview];
        }
        mainLabel=[[UILabel alloc]init];
    }
    [self creatTabelCellView:self.contentView costmodel:costModel];
}
//收入页面cell
-(void)creatTabelCellView:(UIView *)surpView getmodel:(YLGetModel*)model{
    if ([model.getMoney isEqualToString:@"收入"]) {
        mainLabel=[[UILabel alloc]init];
        mainLabel.font=[UIFont systemFontOfSize:20];
        mainLabel.textColor=[UIColor blackColor];
        mainLabel.text=model.kind;
        mainLabel.tag=608;
        mainLabel.textAlignment=NSTextAlignmentCenter;
        [surpView addSubview:mainLabel];
        [mainLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(surpView.mas_left).offset(10);
            make.centerY.equalTo(surpView.mas_centerY);
            make.right.equalTo(surpView.mas_left).offset(100);
        }];
        UIView *centerView=[[UIView alloc]init];
        [surpView addSubview:centerView];
        centerView.backgroundColor=[UIColor lightGrayColor];
        [centerView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(mainLabel.mas_right);
            make.width.equalTo(@(1));
            make.top.equalTo(surpView.mas_top);
            make.bottom.equalTo(surpView.mas_bottom);
        }];
        UILabel *UpLabel=[[UILabel alloc]init];
        [surpView addSubview:UpLabel];
        UpLabel.font=[UIFont systemFontOfSize:20];
        UpLabel.tag=605;
        UpLabel.text=model.getMoney;
        UpLabel.textColor=[UIColor blackColor];
        UpLabel.textAlignment=NSTextAlignmentCenter;
        [UpLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(centerView.mas_right);
            make.top.equalTo(surpView.mas_top);
            make.bottom.equalTo(surpView.mas_bottom);
            make.width.equalTo(@(80));
        }];
        UIView *centerView1=[[UIView alloc]init];
        [surpView addSubview:centerView1];
        centerView1.backgroundColor=[UIColor lightGrayColor];
        [centerView1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(UpLabel.mas_right);
            make.width.equalTo(@(1));
            make.top.equalTo(surpView.mas_top);
            make.bottom.equalTo(surpView.mas_bottom);
        }];
        UILabel *downLabel=[[UILabel alloc]init];
        downLabel.font=[UIFont systemFontOfSize:20];
        downLabel.textColor=[UIColor blackColor];
        downLabel.tag=606;
        downLabel.text=model.dateNow;
        downLabel.textAlignment=NSTextAlignmentCenter;
        [surpView addSubview:downLabel];
        [downLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(surpView.mas_right).offset(-30);
            make.left.equalTo(centerView1.mas_right);
            make.top.equalTo(surpView.mas_top);
            make.bottom.equalTo(surpView.mas_bottom);
            
        }];
    }else{
        mainLabel=[[UILabel alloc]init];
        mainLabel.font=[UIFont systemFontOfSize:16];
        mainLabel.textColor=[UIColor blackColor];
        mainLabel.text=model.kind;
        mainLabel.tag=608;
        mainLabel.textAlignment=NSTextAlignmentCenter;
        [surpView addSubview:mainLabel];
        [mainLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(surpView.mas_left).offset(10);
            make.centerY.equalTo(surpView.mas_centerY);
            make.right.equalTo(surpView.mas_left).offset(100);
        }];
        UIView *centerView=[[UIView alloc]init];
        [surpView addSubview:centerView];
        centerView.backgroundColor=[UIColor lightGrayColor];
        [centerView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(mainLabel.mas_right);
            make.width.equalTo(@(1));
            make.top.equalTo(surpView.mas_top);
            make.bottom.equalTo(surpView.mas_bottom);
        }];
        UILabel *UpLabel=[[UILabel alloc]init];
        [surpView addSubview:UpLabel];
        UpLabel.font=[UIFont systemFontOfSize:16];
        UpLabel.tag=605;
        UpLabel.textColor=[UIColor blackColor];
        UpLabel.text=model.getMoney;
        UpLabel.textColor=[UIColor blueColor];
        UpLabel.textAlignment=NSTextAlignmentCenter;
        [UpLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(centerView.mas_right);
            make.top.equalTo(surpView.mas_top);
            make.bottom.equalTo(surpView.mas_bottom);
            make.width.equalTo(@(80));
        }];
        UIView *centerView1=[[UIView alloc]init];
        [surpView addSubview:centerView1];
        centerView1.backgroundColor=[UIColor lightGrayColor];
        [centerView1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(UpLabel.mas_right);
            make.width.equalTo(@(1));
            make.top.equalTo(surpView.mas_top);
            make.bottom.equalTo(surpView.mas_bottom);
        }];
        UILabel *downLabel=[[UILabel alloc]init];
        downLabel.font=[UIFont systemFontOfSize:12];
        downLabel.textColor=[UIColor blackColor];
        downLabel.tag=606;
        downLabel.text=model.dateNow;
        downLabel.textAlignment=NSTextAlignmentCenter;
        [surpView addSubview:downLabel];
        [downLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(surpView.mas_right).offset(-30);
            make.left.equalTo(centerView1.mas_right);
            make.top.equalTo(surpView.mas_top);
            make.bottom.equalTo(surpView.mas_bottom);
            
        }];
        _deletaButton=[UIButton buttonWithType:UIButtonTypeCustom];
        [surpView addSubview:_deletaButton];
        [_deletaButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(downLabel.mas_right);
            make.right.equalTo(surpView.mas_right);
            make.centerY.equalTo(surpView.mas_centerY);
            make.height.equalTo(@(30));
        }];
        [_deletaButton setBackgroundImage:[UIImage imageNamed:@"close"] forState:UIControlStateNormal];
    }
}
//支出页面cell
-(void)creatTabelCellView:(UIView *)surpView costmodel:(YLCostModel*)model{
    if ([model.costMoney isEqualToString:@"花费"]) {
        mainLabel=[[UILabel alloc]init];
        mainLabel.font=[UIFont systemFontOfSize:20];
        mainLabel.textColor=[UIColor blackColor];
        mainLabel.text=model.kind;
        mainLabel.tag=608;
        mainLabel.textAlignment=NSTextAlignmentCenter;
        [surpView addSubview:mainLabel];
        [mainLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(surpView.mas_left).offset(10);
            make.centerY.equalTo(surpView.mas_centerY);
            make.right.equalTo(surpView.mas_left).offset(100);
        }];
        UIView *centerView=[[UIView alloc]init];
        [surpView addSubview:centerView];
        centerView.backgroundColor=[UIColor lightGrayColor];
        [centerView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(mainLabel.mas_right);
            make.width.equalTo(@(1));
            make.top.equalTo(surpView.mas_top);
            make.bottom.equalTo(surpView.mas_bottom);
        }];
        UILabel *UpLabel=[[UILabel alloc]init];
        [surpView addSubview:UpLabel];
        UpLabel.font=[UIFont systemFontOfSize:20];
        UpLabel.tag=605;
        UpLabel.text=model.costMoney;
        UpLabel.textColor=[UIColor blackColor];
        UpLabel.textAlignment=NSTextAlignmentCenter;
        [UpLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(centerView.mas_right);
            make.top.equalTo(surpView.mas_top);
            make.bottom.equalTo(surpView.mas_bottom);
            make.width.equalTo(@(80));
        }];
        UIView *centerView1=[[UIView alloc]init];
        [surpView addSubview:centerView1];
        centerView1.backgroundColor=[UIColor lightGrayColor];
        [centerView1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(UpLabel.mas_right);
            make.width.equalTo(@(1));
            make.top.equalTo(surpView.mas_top);
            make.bottom.equalTo(surpView.mas_bottom);
        }];
        UILabel *downLabel=[[UILabel alloc]init];
        downLabel.font=[UIFont systemFontOfSize:20];
        downLabel.textColor=[UIColor blackColor];
        downLabel.tag=606;
        downLabel.text=model.dateNow;
        downLabel.textAlignment=NSTextAlignmentCenter;
        [surpView addSubview:downLabel];
        [downLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(surpView.mas_right).offset(-30);
            make.left.equalTo(centerView1.mas_right);
            make.top.equalTo(surpView.mas_top);
            make.bottom.equalTo(surpView.mas_bottom);
            
        }];
    }else{
    mainLabel=[[UILabel alloc]init];
    mainLabel.font=[UIFont systemFontOfSize:16];
    mainLabel.textColor=[UIColor blackColor];
    mainLabel.text=model.kind;
    mainLabel.tag=608;
    mainLabel.textAlignment=NSTextAlignmentCenter;
    [surpView addSubview:mainLabel];
    [mainLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(surpView.mas_left).offset(10);
        make.centerY.equalTo(surpView.mas_centerY);
        make.right.equalTo(surpView.mas_left).offset(100);
    }];
    UIView *centerView=[[UIView alloc]init];
    [surpView addSubview:centerView];
    centerView.backgroundColor=[UIColor lightGrayColor];
    [centerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(mainLabel.mas_right);
        make.width.equalTo(@(1));
        make.top.equalTo(surpView.mas_top);
        make.bottom.equalTo(surpView.mas_bottom);
    }];
    UILabel *UpLabel=[[UILabel alloc]init];
    [surpView addSubview:UpLabel];
    UpLabel.font=[UIFont systemFontOfSize:16];
    UpLabel.tag=605;
    UpLabel.textColor=[UIColor blackColor];
    UpLabel.text=model.costMoney;
    UpLabel.textColor=[UIColor blueColor];
    UpLabel.textAlignment=NSTextAlignmentCenter;
    [UpLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(centerView.mas_right);
        make.top.equalTo(surpView.mas_top);
        make.bottom.equalTo(surpView.mas_bottom);
        make.width.equalTo(@(80));
    }];
    UIView *centerView1=[[UIView alloc]init];
    [surpView addSubview:centerView1];
    centerView1.backgroundColor=[UIColor lightGrayColor];
    [centerView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(UpLabel.mas_right);
        make.width.equalTo(@(1));
        make.top.equalTo(surpView.mas_top);
        make.bottom.equalTo(surpView.mas_bottom);
    }];
    UILabel *downLabel=[[UILabel alloc]init];
    downLabel.font=[UIFont systemFontOfSize:12];
    downLabel.textColor=[UIColor blackColor];
    downLabel.tag=606;
    downLabel.text=model.dateNow;
    downLabel.textAlignment=NSTextAlignmentCenter;
    [surpView addSubview:downLabel];
    [downLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(surpView.mas_right).offset(-30);
        make.left.equalTo(centerView1.mas_right);
        make.top.equalTo(surpView.mas_top);
        make.bottom.equalTo(surpView.mas_bottom);
        
    }];
    _deletaButton=[UIButton buttonWithType:UIButtonTypeCustom];
    [surpView addSubview:_deletaButton];
    [_deletaButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(downLabel.mas_right);
        make.right.equalTo(surpView.mas_right);
        make.centerY.equalTo(surpView.mas_centerY);
        make.height.equalTo(@(30));
    }];
    [_deletaButton setBackgroundImage:[UIImage imageNamed:@"close"] forState:UIControlStateNormal];
    }
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
