//
//  BBCameraSlideView.h
//  BBCamera
//
//  Created by Gary on 7/17/15.
//  Copyright © 2015 Gary. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TGCameraSlideViewProtocol;

@interface BBCameraSlideView : UIView

+ (void)showSlideUpView:(BBCameraSlideView *)slideUpView
          slideDownView:(BBCameraSlideView *)slideDownView
                 atView:(UIView *)view
             completion:(void (^)(void))completion;

+ (void)hideSlideUpView:(BBCameraSlideView *)slideUpView
          slideDownView:(BBCameraSlideView *)slideDownView
                 atView:(UIView *)view
             completion:(void (^)(void))completion;

@end

@protocol BBCameraSlideViewProtocol <NSObject>

- (CGFloat)initialPositionWithView:(UIView *)view;
- (CGFloat)finalPosition;

@end