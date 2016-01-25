//
//  YLDetailTableViewCell.m
//  YLPrivateFinancialManagement
//
//  Created by 千锋 on 16/1/21.
//  Copyright (c) 2016年 mobiletrain. All rights reserved.
//

#import "YLDetailTableViewCell.h"
#import "YLBudgeModel.h"
@implementation YLDetailTableViewCell{
    UILabel *mainLabel;
}
-(void)setModel:(YLBudgeModel *)model{
    _model=model;
    if (!mainLabel) {
        mainLabel=[[UILabel alloc]init];
    }else{
        for (UIView *temp in self.contentView.subviews) {
            [temp removeFromSuperview];
        }
        mainLabel=[[UILabel alloc]init];
    }
    [self creatTabelCellView:self.contentView model:model];
    
}
-(void)creatTabelCellView:(UIView *)surpView model:(YLBudgeModel*)model{
    mainLabel=[[UILabel alloc]init];
    mainLabel.font=[UIFont systemFontOfSize:16];
    mainLabel.textColor=[UIColor blackColor];
    mainLabel.text=model.name;
    mainLabel.tag=608;
    mainLabel.textAlignment=NSTextAlignmentLeft;
    [surpView addSubview:mainLabel];
    [mainLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(surpView.mas_left).offset(10);
        make.centerY.equalTo(surpView.mas_centerY);
        make.right.equalTo(surpView.mas_left).offset(150);
    }];
    UILabel *UpLabel=[[UILabel alloc]init];
    [surpView addSubview:UpLabel];
    UpLabel.font=[UIFont systemFontOfSize:16];
    UpLabel.tag=605;
    UpLabel.textColor=[UIColor blackColor];
    UpLabel.text=model.budget;
    UpLabel.textColor=[UIColor blueColor];
    UpLabel.textAlignment=NSTextAlignmentCenter;
    [UpLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(mainLabel.mas_right).offset(10);
        make.top.equalTo(surpView.mas_top);
        make.bottom.equalTo(surpView.mas_bottom);
    }];
    UILabel *downLabel=[[UILabel alloc]init];
    downLabel.font=[UIFont systemFontOfSize:16];
    downLabel.textColor=[UIColor blackColor];
    downLabel.tag=606;
    downLabel.text=model.surplus;
    downLabel.textAlignment=NSTextAlignmentRight;
    [surpView addSubview:downLabel];
    [downLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(surpView.mas_right).offset(-10);
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
