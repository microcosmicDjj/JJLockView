# JJLockView
解锁dome方便定制


    CGRect rect = [UIScreen mainScreen].bounds;
    
    _lockView = [[JJLockView alloc] init];
    _lockView.frame = CGRectMake(0, 0, rect.size.width,rect.size.height);
    _lockView.center = self.view.center;
    _lockView.dalegate  = self;
    [self.view addSubview:_lockView];

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

![123](https://github.com/microcosmicDjj/JJLockView/blob/master/p.png)
