//
//  YLBudgetTableViewCell.m
//  YLPrivateFinancialManagement
//
//  Created by 千锋 on 16/1/18.
//  Copyright (c) 2016年 mobiletrain. All rights reserved.
//

#import "YLBudgetTableViewCell.h"
#import "YLBudgeModel.h"
@implementation YLBudgetTableViewCell{
     UIImageView     *view;
}
-(void)setModel:(YLBudgeModel *)model{
    _model=model;
    if (!view) {
        view=[[UIImageView alloc]init];
    }else{
        for (UIView *temp in self.contentView.subviews) {
            [temp removeFromSuperview];
        }
        view=[[UIImageView alloc]init];
    }
    [self creatTabelCellView:self.contentView model:model];
    
}
-(void)creatTabelCellView:(UIView *)surpView model:(YLBudgeModel*)model{
    view.image=[UIImage imageNamed:@"cellBG"];
    [surpView addSubview:view];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(surpView.mas_top);
        make.left.equalTo(surpView.mas_left);
        make.right.equalTo(surpView.mas_right);
        make.bottom.equalTo(surpView.mas_bottom);
    }];
    UILabel *mainLabel=[[UILabel alloc]init];
    mainLabel.font=[UIFont systemFontOfSize:18];
    mainLabel.textColor=[UIColor blackColor];
    mainLabel.text=model.name;
    mainLabel.tag=608;
    mainLabel.layer.borderWidth=0.5;
    mainLabel.textAlignment=NSTextAlignmentCenter;
    [surpView addSubview:mainLabel];
    [mainLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(surpView.mas_left).offset(10);
        make.centerY.equalTo(surpView.mas_centerY);
        make.right.equalTo(surpView.mas_left).offset(110);
    }];
    UILabel *UpLabel=[[UILabel alloc]init];
    [surpView addSubview:UpLabel];
    UpLabel.font=[UIFont systemFontOfSize:16];
    UpLabel.tag=605;
    UpLabel.textColor=[UIColor blackColor];
    UpLabel.text=[NSString stringWithFormat:@"预算：%@",model.budget];
    UpLabel.textAlignment=NSTextAlignmentLeft;
    [UpLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(mainLabel.mas_right).offset(10);
        make.top.equalTo(surpView.mas_top);
        make.bottom.equalTo(surpView.mas_bottom);
    }];
    UILabel *downLabel=[[UILabel alloc]init];
    downLabel.font=[UIFont systemFontOfSize:16];
    downLabel.textColor=[UIColor blackColor];
    downLabel.tag=606;
    downLabel.text=[NSString stringWithFormat:@"余额：%@",model.surplus];
    downLabel.textAlignment=NSTextAlignmentLeft;
    [surpView addSubview:downLabel];
    [downLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(UpLabel.mas_right).offset(10);
        make.top.equalTo(surpView.mas_top);
        make.bottom.equalTo(surpView.mas_bottom);
        
    }];
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
