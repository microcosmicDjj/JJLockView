//
//  JJLockLabel.h
//  JJLockView
//
//  Created by Mac on 15/12/11.
//  Copyright © 2015年 DJJ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JJLockLabel : UILabel

/*
 * MARK: 普通信息
 */
- (void) normalMsg:(NSString *) msg;

/*
 * MARK: 警示信息
 */
- (void) warnMsg:(NSString *) msg;

@end
