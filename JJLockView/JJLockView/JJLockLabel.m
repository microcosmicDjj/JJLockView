//
//  JJLockLabel.m
//  JJLockView
//
//  Created by Mac on 15/12/11.
//  Copyright © 2015年 DJJ. All rights reserved.
//

#import "JJLockLabel.h"
#import "JJLockConstant.h"

@implementation JJLockLabel

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupView];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self setupView];
    }
    return self;
}

- (void) setupView
{
    self.font = [UIFont systemFontOfSize:18];
    self.textAlignment = NSTextAlignmentCenter;
}

/*
 * MARK: 普通信息
 */
- (void) normalMsg:(NSString *) msg
{
    self.text = msg;
    self.textColor = normal_Color;
}

/*
 * MARK: 警示信息
 */
- (void) warnMsg:(NSString *) msg
{
    self.text = msg;
    self.textColor = select_Color;
    [self shakeView];
}

/*
 * MARK: 抖动效果
 */
-(void)shakeView
{
    CGFloat t =2.0;
    CGAffineTransform translateRight  =CGAffineTransformTranslate(CGAffineTransformIdentity, t,0.0);
    CGAffineTransform translateLeft =CGAffineTransformTranslate(CGAffineTransformIdentity,-10,0.0);
    
    self.transform = translateLeft;
    
    __weak __typeof(self) weakSelf = self;
    [UIView animateWithDuration:0.07 delay:0.0 options:UIViewAnimationOptionAutoreverse|UIViewAnimationOptionRepeat animations:^{
        [UIView setAnimationRepeatCount:2.0];
        weakSelf.transform = translateRight;
    } completion:^(BOOL finished){
        if(finished){
            [UIView animateWithDuration:0.05 delay:0.0 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
                weakSelf.transform =CGAffineTransformIdentity;
            } completion:NULL];
        }
    }];
    
}

@end
