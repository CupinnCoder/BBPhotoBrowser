//
//  BBTapDetectingView.h
//  BBPhotoBrowser
//
//  Created by Gary on 9/1/15.
//  Copyright © 2015 Gary. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol BBTapDetectingViewDelegate;

@interface BBTapDetectingView : UIView
@property (nonatomic, weak) id <BBTapDetectingViewDelegate> tapDelegate;
@end

@protocol BBTapDetectingViewDelegate <NSObject>
@optional
- (void)view:(UIView *)view singleTapDetected:(UITouch *)touch;
- (void)view:(UIView *)view doubleTapDetected:(UITouch *)touch;
- (void)view:(UIView *)view tripleTapDetected:(UITouch *)touch;
@end