//
//  LoadingAnimation.h
//
//
//  Created by 田耀辉 on 2018/4/7.
//  Copyright © 2018年 田耀辉. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoadingAnimation : UIView
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


@end
