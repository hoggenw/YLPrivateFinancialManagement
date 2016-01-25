//
//  YLProgressView.h
//  YLPrivateFinancialManagement
//
//  Created by 千锋 on 16/1/6.
//  Copyright (c) 2016年 mobiletrain. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YLProgressView : UIView
/**创建两个progressview的填充图*/
@property(nonatomic,strong)UIImageView *backImageView;
@property(nonatomic,strong)UIImageView  *foreImageView;

-(void)creatProgresssView:(BOOL)isLeft superView:(UIView*)superView;
@end
