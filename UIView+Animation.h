//
//  UIView+Animation.h
//  UIAnimationSamples
//
//  Created by Ray Wenderlich on 11/15/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Animation)

NS_ASSUME_NONNULL_BEGIN

- (void) moveTo:(CGPoint)destination duration:(float)secs option:(UIViewAnimationOptions)option;
- (void) moveTo:(CGPoint)destination withFrame:(CGRect)frame duration:(float)secs option:(UIViewAnimationOptions)option;
- (void) downUnder:(float)secs option:(UIViewAnimationOptions)option;
- (void) addSubviewWithZoomInAnimation:(UIView*)view duration:(float)secs option:(UIViewAnimationOptions)option;
- (void) removeWithZoomOutAnimation:(float)secs option:(UIViewAnimationOptions)option;
- (void) addSubviewWithFadeAnimation:(UIView*)view duration:(float)secs option:(UIViewAnimationOptions)option;
- (void) addSubviewWithFadeAnimation:(UIView*)view duration:(float)secs option:(UIViewAnimationOptions)option opacity:(float)opacity;
- (void) removeWithSinkAnimation:(int)steps;
- (void) removeWithSinkAnimationRotateTimer:(NSTimer*) timer;

- (void) zoomOutAnimation:(UIView*)view duration:(float)secs option:(UIViewAnimationOptions)option;

- (void) zoomOutAnimation:(float)secs option:(UIViewAnimationOptions)option;


- (void) addSubviewWithZoomAndDestinationInAnimation:(UIView*)view duration:(float)secs option:(UIViewAnimationOptions)option destination :(CGPoint)destination;

+(void)popLabel:(UIView*)view;

NS_ASSUME_NONNULL_END

- (void)moveTo:(CGPoint)destination duration:(float)secs option:(UIViewAnimationOptions)option completion:(void (^ __nullable)(BOOL finished))completion;



@end





//[[cell imageView] setTransform:CGAffineTransformMakeScale(1.1, 1.1)];
//[UIView animateWithDuration:0.1
//                      delay:0
//                    options:UIViewAnimationOptionAllowUserInteraction
// | UIViewAnimationOptionBeginFromCurrentState
//                 animations:^{
//                     [[cell imageView] setTransform:CGAffineTransformIdentity];
//                 }
//                 completion:nil];
