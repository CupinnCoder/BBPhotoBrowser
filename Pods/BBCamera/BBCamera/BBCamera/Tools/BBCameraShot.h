//
//  BBCameraShot.h
//  BBCamera
//
//  Created by Gary on 7/16/15.
//  Copyright © 2015 Gary. All rights reserved.
//

@import Foundation;
@import AVFoundation;
@import UIKit;

@interface BBCameraShot : NSObject

+ (void)takePhotoCaptureView:(UIView *)captureView
            stillImageOutput:(AVCaptureStillImageOutput *)stillImageOutput
            videoOrientation:(AVCaptureVideoOrientation)videoOrientation
                    cropSize:(CGSize)cropSize
                  completion:(void (^)(UIImage *photo))completion;

@end
