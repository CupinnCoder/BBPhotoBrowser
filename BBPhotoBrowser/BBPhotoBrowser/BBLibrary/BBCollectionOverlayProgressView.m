//
//  BBCollectionOverlayProgressView.m
//  BBPhotoBrowser
//
//  Created by Melvin on 1/4/16.
//  Copyright © 2016 TimeFace. All rights reserved.
//

#import "BBCollectionOverlayProgressView.h"
#import <QuartzCore/QuartzCore.h>

static const CGFloat kBBCenterHoleInsetRatio          = 0.2f;
static const CGFloat kBBProgressShapeInsetRatio       = 0.03f;
static const CGFloat kBBDefaultAlpha                  = 0.45f;

@interface BBCollectionOverlayProgressView() {
    
}


@property (nonatomic, strong) CAShapeLayer *boxShape;
@property (nonatomic, strong) CAShapeLayer *progressShape;

@end

@implementation BBCollectionOverlayProgressView

- (instancetype)init
{
    return [self initWithFrame:CGRectZero];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        self.alpha = kBBDefaultAlpha;
        
        self.boxShape = [CAShapeLayer layer];
        
        self.boxShape.fillColor         = [UIColor blackColor].CGColor;
        self.boxShape.anchorPoint       = CGPointMake(0.5f, 0.5f);
        self.boxShape.contentsGravity   = kCAGravityCenter;
        self.boxShape.fillRule          = kCAFillRuleEvenOdd;
        
        self.progressShape = [CAShapeLayer layer];
        
        self.progressShape.fillColor    = [UIColor clearColor].CGColor;
        self.progressShape.strokeColor  = [UIColor blackColor].CGColor;
        
        [self.layer addSublayer:self.boxShape];
        [self.layer addSublayer:self.progressShape];
    }
    
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat minSide = MIN(CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds));
    
    CGFloat centerHoleInset     = kBBCenterHoleInsetRatio * minSide;
    CGFloat progressShapeInset  = kBBProgressShapeInsetRatio * minSide;
    
    CGRect pathRect = CGRectMake(CGPointZero.x,
                                 CGPointZero.y,
                                 CGRectGetWidth(self.bounds),
                                 CGRectGetHeight(self.bounds));
    
    UIBezierPath *path = [UIBezierPath bezierPathWithRect:pathRect];
    
    CGFloat width = minSide - (centerHoleInset * 2);
    CGFloat height = width;
    
    [path appendPath:[UIBezierPath bezierPathWithRoundedRect:CGRectMake((CGRectGetWidth(self.bounds) - width) / 2.0f,
                                                                        (CGRectGetHeight(self.bounds) - height) / 2.0f,
                                                                        width,
                                                                        height)
                                                cornerRadius:(width / 2.0f)]];
    
    [path setUsesEvenOddFillRule:YES];
    
    self.boxShape.path = path.CGPath;
    self.boxShape.bounds = pathRect;
    self.boxShape.position = CGPointMake(CGRectGetMidX(pathRect), CGRectGetMidY(pathRect));
    
    CGFloat diameter = minSide - (2 * centerHoleInset) - (2 * progressShapeInset);
    CGFloat radius = diameter / 2.0f;
    
    self.progressShape.path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake((CGRectGetWidth(self.bounds) / 2.0f) - (radius / 2.0f),
                                                                                 (CGRectGetHeight(self.bounds) / 2.0f) - (radius / 2.0f),
                                                                                 radius,
                                                                                 radius)
                                                         cornerRadius:radius].CGPath;
    
    self.progressShape.lineWidth = radius;
}

- (void)setProgress:(float)progress
{
    if ([self pinnedProgress:progress] != _progress) {
        self.progressShape.strokeStart = progress;
        if (_progress == 1.0f && progress < 1.0f) {
            [self.boxShape removeAllAnimations];
        }
        _progress = [self pinnedProgress:progress];
    }
}

- (float)pinnedProgress:(float)progress {
    float pinnedProgress = MAX(0.0f, progress);
    pinnedProgress = MIN(1.0f, pinnedProgress);
    return pinnedProgress;
}

@end
