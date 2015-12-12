//
//  RoundnessView.m
//  JJLockView
//
//  Created by Mac on 15/12/11.
//  Copyright © 2015年 DJJ. All rights reserved.
//

#import "JJRoundnessView.h"
#import "JJLockConstant.h"

@implementation JJRoundnessView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    
    //画空心圆

    //中心点
    CGPoint pointCenter = CGPointMake(self.frame.size.width/2, self.frame.size.height/2);
    //半径
    CGFloat radius = (self.frame.size.width/2-1);
    
    UIBezierPath *hollowPath = [UIBezierPath bezierPath];
    
    [hollowPath addArcWithCenter:pointCenter radius:radius startAngle:0 endAngle:180 clockwise:YES];
    
    //画实心圆
    UIBezierPath *fillPath = [UIBezierPath bezierPath];
    [fillPath addArcWithCenter:pointCenter radius:10 startAngle:0 endAngle:180.0 clockwise:YES];

    //绘制
    if (_selected) {
        [select_Color setStroke];
        [hollowPath stroke];
        
        [select_Color setFill];
        [fillPath stroke];
        [fillPath fill];
    } else {
        [normal_Color setStroke];
        [hollowPath stroke];
    }
}

/**
 * MARK:set方法确保调用的时候会渲染
 */
- (void) setSelected:(BOOL)selected
{
    _selected = selected;
    [self setNeedsDisplay];
}


@end
