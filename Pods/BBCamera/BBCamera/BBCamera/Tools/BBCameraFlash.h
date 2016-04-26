//
//  BBCameraFlash.h
//  BBCamera
//
//  Created by Gary on 7/16/15.
//  Copyright © 2015 Gary. All rights reserved.
//

@import Foundation;
@import AVFoundation;
@import UIKit;

@interface BBCameraFlash : NSObject

+ (void)changeModeWithCaptureSession:(AVCaptureSession *)session andButton:(UIButton *)button;
+ (void)flashModeWithCaptureSession:(AVCaptureSession *)session andButton:(UIButton *)button;

@end
