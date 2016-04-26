//
//  BBTapDetectingImageView.h
//  BBPhotoBrowser
//
//  Created by Gary on 8/28/15.
//  Copyright © 2015 TimeFace. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol BBTapDetectingImageViewDelegate;

@interface BBTapDetectingImageView : UIImageView
@property (nonatomic, weak) id <BBTapDetectingImageViewDelegate> tapDelegate;
@end

@protocol BBTapDetectingImageViewDelegate <NSObject>
@optional
- (void)imageView:(UIImageView *)imageView singleTapDetected:(UITouch *)touch;
- (void)imageView:(UIImageView *)imageView doubleTapDetected:(UITouch *)touch;
- (void)imageView:(UIImageView *)imageView tripleTapDetected:(UITouch *)touch;
@end
