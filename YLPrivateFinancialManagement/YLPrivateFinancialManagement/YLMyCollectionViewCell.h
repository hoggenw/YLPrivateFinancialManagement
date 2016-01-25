//
//  YLMyCollectionViewCell.h
//  YLPrivateFinancialManagement
//
//  Created by 千锋 on 16/1/23.
//  Copyright (c) 2016年 mobiletrain. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YLMyCollectionViewCell : UICollectionViewCell
@property(nonatomic ,copy)NSString *model;
@property(nonatomic,strong)UILabel *myLabel;
@property(nonatomic,strong)UIButton *button;

@end
