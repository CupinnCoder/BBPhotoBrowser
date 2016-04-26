//
//  BBCameraSlideDownView.m
//  BBCamera
//
//  Created by Gary on 7/17/15.
//  Copyright © 2015 Gary. All rights reserved.
//

#import "BBCameraSlideDownView.h"

@interface BBCameraSlideDownView () <BBCameraSlideViewProtocol>

@end

@implementation BBCameraSlideDownView

#pragma mark -
#pragma mark - TGCameraSlideViewProtocol

- (CGFloat)initialPositionWithView:(UIView *)view
{
    return CGRectGetHeight(view.frame)/2;
}

- (CGFloat)finalPosition
{
    return CGRectGetMaxY(self.frame);
}

@end
