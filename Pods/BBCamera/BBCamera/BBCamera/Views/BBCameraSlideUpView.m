//
//  BBCameraSlideUpView.m
//  BBCamera
//
//  Created by Gary on 7/17/15.
//  Copyright © 2015 Gary. All rights reserved.
//

#import "BBCameraSlideUpView.h"

@interface BBCameraSlideUpView () <BBCameraSlideViewProtocol>

@end

@implementation BBCameraSlideUpView

#pragma mark -
#pragma mark - TGCameraSlideViewProtocol

- (CGFloat)initialPositionWithView:(UIView *)view
{
    return 0;
}

- (CGFloat)finalPosition
{
    return -CGRectGetHeight(self.frame);
}

@end
