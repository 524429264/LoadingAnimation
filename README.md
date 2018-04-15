# LoadingAnimation
该项目为加载动画的示例：
![Image](https://github.com/524429264/LoadingAnimation/blob/master/LoadingAnimation/LoadingAnimation/img-folder/loading.png)


@property(nonatomic, readonly, getter=isAnimating) BOOL animating;

+(instancetype)shareAnimation;

/**
开始动画
*/
- (void)startAnimating;


/**
结束动画
*/
- (void)stopAnimating;


/**
动画状态
*/
- (BOOL)isAnimating;


/**
可以设置动画提示文字

@param title 提示文字
*/
-(void)startAnimatingWithTitle:(NSString *)title;
