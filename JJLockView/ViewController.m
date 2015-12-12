//
//  ViewController.m
//  JJLockView
//
//  Created by Mac on 15/12/11.
//  Copyright © 2015年 DJJ. All rights reserved.
//

#import "ViewController.h"
#import "JJRoundnessView.h"
#import "JJLockView.h"

@interface ViewController () <JJLockViewDalegate>

@property (nonatomic, weak) IBOutlet JJLockView *lockView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
   /*
    * 代码创建
    */
//    CGRect rect = [UIScreen mainScreen].bounds;
//    
//    _lockView = [[JJLockView alloc] init];
//    _lockView.frame = CGRectMake(0, 0, rect.size.width,rect.size.height);
//    _lockView.center = self.view.center;
//    _lockView.dalegate  = self;
//    [self.view addSubview:_lockView];
    
}
//_lockView代理方法
//方便继续定制
- (void) password:(NSString *) password
{
    if (password.length < 4) {
        [_lockView.lockLabel warnMsg:@"请连接至少4个点"];
        [_lockView clean];
        return;
    }
    [_lockView.lockLabel normalMsg:[NSString stringWithFormat:@"密码为:%@",password]];
    [_lockView clean];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
