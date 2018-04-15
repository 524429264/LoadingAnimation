//
//  LoadingAnimation.m
//  
//
//  Created by 田耀辉 on 2018/4/7.
//  Copyright © 2018年 田耀辉. All rights reserved.
//

#import "LoadingAnimation.h"

static NSString *kLoadingTitle = @"加载中。。。";
#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height
#define kScreenSize [UIScreen mainScreen].bounds.size

@interface LoadingAnimation ()
{
    CGPoint blueCenter;
    CGPoint greenCenter;
    CGAffineTransform blueTransform;
    CGAffineTransform greenTransform;
    UIWindow *_window;
}
@property(nonatomic,strong)UIView *maskView;
@property(nonatomic,strong)UILabel *titleLb;

@property (strong, nonatomic)  UIView *blueView;
@property (strong, nonatomic)  UIView *greenView;
@end


@implementation LoadingAnimation
+(instancetype)shareAnimation
{
    static LoadingAnimation *animation = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        animation = [self new];
    });
    return animation;
}

-(instancetype)init
{
    if (self = [super init]) {
        self.frame = CGRectMake(0, 0, 100, 50);
        self.center = CGPointMake(kScreenWidth/2.0, kScreenHeight/2.0);
        
        UIView *blueView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 30, 30)];
        blueView.center = CGPointMake(35, 25);
        blueView.backgroundColor = [UIColor blueColor];
        [self drawCircleView:blueView];
        self.blueView = blueView;
        [self addSubview:blueView];
        
        
        UIView *greenView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 50, 50)];
        greenView.center = CGPointMake(75, 25);
        greenView.backgroundColor = [UIColor greenColor];
        self.greenView = greenView;
        [self drawCircleView:greenView];
        [self addSubview:greenView];
        
        blueCenter = self.blueView.center;
        greenCenter= self.greenView.center;
        
        blueTransform = self.blueView.transform;
        greenTransform = self.greenView.transform;
        self.hidden = YES;
        
    }
    return self;
}



/**
 开始动画
 */
-(void)startAnimating
{
    self.hidden = NO;
    self.titleLb.frame =CGRectMake(0, CGRectGetMaxY(self.frame)+15, kScreenWidth, 30);

    
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    [UIView beginAnimations:@"LoadingAnimation" context:nil];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDuration:0.5];
    [UIView setAnimationRepeatAutoreverses:YES];
    [UIView setAnimationRepeatCount:MAXFLOAT];
    
    self.blueView.transform = CGAffineTransformMakeScale(5/3.0, 5/3.0);
    self.blueView.center = CGPointMake(25, 25);
    self.greenView.transform = CGAffineTransformMakeScale(0.6, 0.6);
    self.greenView.center = CGPointMake(65, 25);
    
    [UIView setAnimationDidStopSelector:@selector(animationDidStop:finished:context:)];
    [UIView commitAnimations];
}


/**
 动画状态
 */
- (BOOL)isAnimating
{
    if ([self superview]) {
        return YES;
    }
    return NO;
}



/**
 动画结束回调方法
 */
-(void) animationDidStop:(NSString *)animationID finished:(NSNumber *)finished context:(void *)context
{
    _blueView.center = blueCenter;
    _blueView.transform = blueTransform;

    _greenView.center = greenCenter;
    _greenView.transform =greenTransform;
}


/**
 结束动画
 */
- (void)stopAnimating
{
    if (!self.isAnimating) {
        return;
    }
    dispatch_async(dispatch_get_main_queue(), ^{
        if (_maskView) {
            [_maskView removeFromSuperview];
        }
        if (_titleLb) {
            [_titleLb removeFromSuperview];
        }
        [self removeFromSuperview];
    });
}

-(void)startAnimatingWithTitle:(NSString *)title
{
    self.titleLb.text = title;
    [[UIApplication sharedApplication].keyWindow addSubview:self.maskView];
    [[UIApplication sharedApplication].keyWindow addSubview:self.titleLb];
    [self startAnimating];
}



/**
 半透明遮罩视图
 */
- (UIView *)maskView
{
    if (!_maskView) {
        _maskView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight )];
        _maskView.backgroundColor = [UIColor colorWithRed:40/255 green:40/255 blue:40/255 alpha:0.4];
    }
    return _maskView;
}


/**
 加载提示文字
 */
- (UILabel *)titleLb
{
    if (!_titleLb) {
        _titleLb = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.frame)+15, kScreenWidth, 30)];
        _titleLb.textColor = [UIColor whiteColor];
        _titleLb.text = kLoadingTitle;
        _titleLb.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLb;
}

/**
 绘制圆角
 */
- (void)drawCircleView:(UIView*)view
{
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.path = [UIBezierPath bezierPathWithRoundedRect:view.bounds cornerRadius:view.bounds.size.width/2.0].CGPath;
    view.layer.mask = maskLayer;
}
    
    
@end
