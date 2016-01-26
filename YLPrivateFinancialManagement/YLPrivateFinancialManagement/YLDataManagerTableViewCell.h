//
//  YLDataManagerTableViewCell.h
//  YLPrivateFinancialManagement
//
//  Created by 千锋 on 16/1/26.
//  Copyright (c) 2016年 mobiletrain. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YLCostModel;
@class YLGetModel;
@interface YLDataManagerTableViewCell : UITableViewCell
@property(nonatomic,strong)YLGetModel *getModel;
@property(nonatomic,strong)YLCostModel *costModel;
@property(nonatomic,strong)UIButton    *deletaButton;
@end
