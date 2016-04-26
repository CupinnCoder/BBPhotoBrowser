//
//  BBPhotoCaptionView.h
//  BBPhotoBrowser
//
//  Created by Gary on 11/18/15.
//  Copyright © 2015 TimeFace. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BBPhotoProtocol.h"

typedef NS_ENUM(NSUInteger, BBPanGestureRecognizerDirection) {
    BBPanGestureRecognizerDirectionUndefined,
    BBPanGestureRecognizerDirectionUp,
    BBPanGestureRecognizerDirectionDown,
    BBPanGestureRecognizerDirectionLeft,
    BBPanGestureRecognizerDirectionRight
};

@interface BBPhotoCaptionView : UIView

// Init
- (id)initWithPhoto:(id<BBPhoto>)photo;
- (id)initWithPhoto:(id<BBPhoto>)photo width:(CGFloat)width frame:(CGRect)frame;
- (void)setupCaption;
- (CGSize)sizeThaBBits:(CGSize)size;
- (void)setupCaptionToolBarView:(UIView *)toolBarView;

@end
