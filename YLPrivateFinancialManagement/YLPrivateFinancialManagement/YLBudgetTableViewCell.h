//
//  YLBudgetTableViewCell.h
//  YLPrivateFinancialManagement
//
//  Created by 千锋 on 16/1/18.
//  Copyright (c) 2016年 mobiletrain. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YLBudgeModel;
//@protocol YLBCellDelegate;


@interface YLBudgetTableViewCell : UITableViewCell
//@property (nonatomic,assign)id<YLBCellDelegate>delegate;
@property(nonatomic,strong)YLBudgeModel *model;
@end
//
//@protocol YLBCellDelegate <NSObject>
//
//- (void)getCell:(YLBudgetTableViewCell *)cell;
//
//@end