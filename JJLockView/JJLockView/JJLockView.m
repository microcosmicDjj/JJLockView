//
//  JJLockView.m
//  JJLockView
//
//  Created by Mac on 15/12/11.
//  Copyright © 2015年 DJJ. All rights reserved.
//

#import "JJLockView.h"
#import "JJRoundnessView.h"
#import "JJLockConstant.h"

@interface  JJLockView()

@property (nonatomic, strong) NSMutableArray *selectRoundnessViews;
@property (nonatomic, assign) CGPoint point;
@property (nonatomic, strong) NSMutableArray *roundnessViews;

@end

@implementation JJLockView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupBtns];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self setupBtns];
    }
    return self;
}


- (void) setupBtns
{
    self.backgroundColor = [UIColor clearColor];
    CGRect rect = [UIScreen mainScreen].bounds;

    //圆形起始位置
    CGFloat originationY = (rect.size.height - rect.size.width)/2;
    
    //初始化lockLabel指视
    _lockLabel = [[JJLockLabel alloc] initWithFrame:CGRectMake(0, 0, rect.size.width, 21)];
    _lockLabel.center = CGPointMake(rect.size.width/2, originationY/2+20);
    [self addSubview:_lockLabel];
    
    //排布9个圆形
    CGFloat roundnessViewWH = 65;

    for (int i = 0;i<9 ;i++ ) {
        //计算view之间的间隔
        CGFloat roundnessViewSpace = (rect.size.width - (roundnessViewWH * 3))/4;
        //计算x，y
        CGFloat roundnessViewX = roundnessViewSpace +  (roundnessViewWH + roundnessViewSpace)*(i%3);
        CGFloat roundnessViewY = originationY + roundnessViewSpace +  (roundnessViewWH + roundnessViewSpace)*(i/3);
        
        JJRoundnessView *roundnessView = [[JJRoundnessView alloc] initWithFrame:CGRectMake(roundnessViewX, roundnessViewY, roundnessViewWH, roundnessViewWH)];
        roundnessView.selected = NO;
        [self addSubview:roundnessView];
        //添加至数组
        [self.roundnessViews addObject:roundnessView];
        
        //利用tag值，得到密码
        roundnessView.tag = i+1;
    }
    
}

/*
 * MRAK:手势移动的时候
 */
- (void) touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self];
    
    for (JJRoundnessView *roundnessView in self.roundnessViews) {
        if (CGRectContainsPoint(roundnessView.frame, point)) {
            if (roundnessView.selected == NO) {
                roundnessView.selected = YES;
                //将经过的roundnessView.center点放进数组
                [self.selectRoundnessViews addObject:roundnessView];
            }
        } else {
            //如果没有经过，就将点赋值给宁外一个点
            _point = point;
        }
    }
    [self setNeedsDisplay];
}

/*
 * MRAK:手势停止的时候
 */
- (void) touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    JJRoundnessView *roundnessView = self.selectRoundnessViews.lastObject;
    //修正位置
    _point = roundnessView.center;
    
    [self setNeedsDisplay];
    //拼接NSString
    NSString *strs = [[NSString alloc] init];
    for (JJRoundnessView *roundnessView in self.selectRoundnessViews) {
        strs = [strs stringByAppendingString:[NSString stringWithFormat:@"%ld",(long)roundnessView.tag]];
    }
    //回调
    if ([self.dalegate respondsToSelector:@selector(password:)] && ![strs isEqualToString:@""]) {
        [self.dalegate password:strs];
    }
}

- (void)drawRect:(CGRect)rect {
    UIBezierPath *path = [UIBezierPath bezierPath];
    
    //遍历所有的点
    for (int i=0;i<self.selectRoundnessViews.count;i++) {
        JJRoundnessView *roundnessView = self.selectRoundnessViews[i];
//        CGPoint point = [value CGPointValue];
        if (i == 0) {
            [path moveToPoint:roundnessView.center];  //起始位置
        } else {
            [path addLineToPoint:roundnessView.center];
        }
    }
    [path addLineToPoint:_point];
    
    // 设置连接点样式
    path.lineJoinStyle = kCGLineJoinRound;
    path.lineCapStyle = kCGLineCapRound;
    
    [path setLineWidth:link_Width];
    [select_Color set];
    
    [path stroke];
}

/*
 * MARK:清空所有点
 */
- (void) clean
{
    [self.selectRoundnessViews removeAllObjects];
    for (JJRoundnessView *roundnessView in self.roundnessViews) {
        roundnessView.selected = NO;
    }
}

/*
 * MARK:懒加载
 */
- (NSMutableArray *) selectRoundnessViews
{
    if (!_selectRoundnessViews) {
        _selectRoundnessViews = [[NSMutableArray alloc] init];
    }
    return _selectRoundnessViews;
}

- (NSMutableArray *) roundnessViews
{
    if (!_roundnessViews) {
        _roundnessViews = [[NSMutableArray alloc] init];
    }
    return _roundnessViews;
}

@end
