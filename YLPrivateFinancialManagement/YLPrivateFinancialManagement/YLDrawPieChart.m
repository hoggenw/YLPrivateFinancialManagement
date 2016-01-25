//
//  YLDrawPieChart.m
//  YLDrawCirle
//
//  Created by 千锋 on 16/1/13.
//  Copyright (c) 2016年 mobiletrain. All rights reserved.
//

#import "YLDrawPieChart.h"
#import "YLPieModel.h"
@implementation YLDrawPieChart{
    NSArray   *colorArray;
    NSArray   *dataArray;
    CGPoint  center;
    NSArray  *modelArray;
}

-(void)draw{
    NSArray *myArray=[self dealData];
    CGFloat starAngle=0;
    CGFloat endAngle=0;
    if (myArray.count==0) {
        
    }else{
        for (int index=0; index<myArray.count; index++) {
            CGFloat nowPI=[myArray[index] doubleValue];
            endAngle+=nowPI*M_PI*2;
            UIBezierPath *bp=[[UIBezierPath alloc]init];
            center.x=self.center.x;
            center.y=(self.center.y-100)/2;
            [bp moveToPoint:center];
            CGPoint firstPoint=CGPointMake(center.x+100*cos(starAngle), center.y+100*sin(starAngle));
            [bp addLineToPoint:firstPoint];
            bp.lineWidth=2;
            [bp
             addArcWithCenter:center radius:100.0 startAngle:starAngle endAngle:endAngle clockwise:YES];
            bp.lineWidth=2;
            [bp moveToPoint:center];
            CGPoint secondePoint=CGPointMake(center.x+100*cos(endAngle),center.y+100*sin(endAngle));
            [bp addLineToPoint:secondePoint];
            bp.lineWidth=2;
            [colorArray[index] setStroke];
            UILabel *label=[[UILabel alloc]init];
            if (nowPI>0.5) {
           label.frame=CGRectMake((firstPoint.x+secondePoint.x)/2-110, (firstPoint.y+secondePoint.y)/2, 80, 20);
            }else{
            label.frame=CGRectMake((firstPoint.x+secondePoint.x)/2, (firstPoint.y+secondePoint.y)/2, 80, 20);
            }
            [self addSubview:label];
            YLPieModel *model=[[YLPieModel alloc]init];
            model=modelArray[index];
            label.text=[NSString stringWithFormat:@"%@%.1lf%%",model.name,[myArray[index] doubleValue]*100];
            label.font=[UIFont systemFontOfSize:8];
            label.textColor=[UIColor blackColor];
            [bp stroke];
            
            [colorArray[index] setFill];
            [bp fill];
            starAngle=endAngle;
        }
        if (myArray.count!=1) {
            UIBezierPath *bp=[[UIBezierPath alloc]init];
            bp.lineWidth=2;
            [bp
             addArcWithCenter:center radius:3.0 startAngle:0 endAngle:M_PI*2 clockwise:YES];
            [[UIColor whiteColor] setFill];
            [bp fill];
        }
    }
    
    
}

- (void)drawRect:(CGRect)rect {
    [self draw];
}
-(void)beginDraw:(NSArray *)array{
    colorArray=[YLColoers returnColorsForPicture];
    modelArray=array;
    dataArray=[self dealNember:array];
    [self setNeedsDisplay];
}
-(NSArray *)dealData{
    CGFloat totol=0;
    for (int index=0; index<dataArray.count&&index<colorArray.count; index++) {
        totol+=[dataArray[index] doubleValue];
    }
    NSMutableArray *myDataArray=[NSMutableArray array];
    for (int index=0; index<dataArray.count&&index<colorArray.count; index++) {
        CGFloat percentage=[dataArray[index] doubleValue]/totol;
        [myDataArray addObject:@(percentage)];
    }
    return [myDataArray copy];
}
//提取数值数组
-(NSArray*)dealNember:(NSArray*)array{
    NSMutableArray *needArray=[NSMutableArray array];
    for (int index=0; index<array.count; index++) {
        YLPieModel *model=[[YLPieModel alloc]init];
        model=array[index];
        [needArray addObject:@(model.number)];
        
    }
    return needArray;
}
@end
