//
//  BBCameraFocus.h
//  BBCamera
//
//  Created by Gary on 7/16/15.
//  Copyright © 2015 Gary. All rights reserved.
//

@import AVFoundation;
@import UIKit;

@interface BBCameraFocus : NSObject

+ (void)focusWithCaptureSession:(AVCaptureSession *)session
                     touchPoint:(CGPoint)touchPoint
                    inFocusView:(UIView *)focusView;

@end
