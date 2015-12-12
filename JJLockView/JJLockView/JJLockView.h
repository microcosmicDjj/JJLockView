//
//  JJLockView.h
//  JJLockView
//
//  Created by Mac on 15/12/11.
//  Copyright © 2015年 DJJ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JJLockLabel.h"

@protocol JJLockViewDalegate <NSObject>
@optional
- (void) password:(NSString *) password;
@end

@interface JJLockView : UIView

@property (weak, nonatomic) IBOutlet id<JJLockViewDalegate> dalegate;
@property (nonatomic, strong) JJLockLabel *lockLabel;

/**清空手势*/
- (void) clean;

@end
