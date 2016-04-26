//
//  BBCameraFlash.m
//  BBCamera
//
//  Created by Gary on 7/16/15.
//  Copyright © 2015 Gary. All rights reserved.
//

#import "BBCameraFlash.h"
#import "BBCameraColor.h"
#import "BBTintedButton.h"

@implementation BBCameraFlash

#pragma mark -
#pragma mark - Public methods

+ (void)changeModeWithCaptureSession:(AVCaptureSession *)session andButton:(UIButton *)button
{
    AVCaptureDevice *device = [session.inputs.lastObject device];
    AVCaptureFlashMode mode = [device flashMode];
    
    [device lockForConfiguration:nil];
    
    switch ([device flashMode]) {
        case AVCaptureFlashModeAuto:
            mode = AVCaptureFlashModeOn;
            break;
            
        case AVCaptureFlashModeOn:
            mode = AVCaptureFlashModeOff;
            break;
            
        case AVCaptureFlashModeOff:
            mode = AVCaptureFlashModeAuto;
            break;
    }
    
    if ([device isFlashModeSupported:mode]) {
        device.flashMode = mode;
    }
    
    [device unlockForConfiguration];
    
    [self flashModeWithCaptureSession:session andButton:button];
}

+ (void)flashModeWithCaptureSession:(AVCaptureSession *)session andButton:(UIButton *)button
{
    AVCaptureDevice *device = [session.inputs.lastObject device];
    AVCaptureFlashMode mode = [device flashMode];
    UIImage *image = UIImageFromAVCaptureFlashMode(mode);
    UIColor *tintColor = TintColorFromAVCaptureFlashMode(mode);
    button.enabled = [device isFlashModeSupported:mode];
    
    if ([button isKindOfClass:[BBTintedButton class]]) {
        [(BBTintedButton*)button setCustomTintColorOverride:tintColor];
    }
    
    [button setImage:image forState:UIControlStateNormal];
}

#pragma mark -
#pragma mark - Private methods

UIImage *UIImageFromAVCaptureFlashMode(AVCaptureFlashMode mode)
{
    NSArray *array = @[@"CameraFlashOff", @"CameraFlashOn", @"CameraFlashAuto"];
    NSString *imageName = [array objectAtIndex:mode];
    return [UIImage imageNamed:imageName];
}

UIColor *TintColorFromAVCaptureFlashMode(AVCaptureFlashMode mode)
{
    NSArray *array = @[[UIColor grayColor], [BBCameraColor tintColor], [BBCameraColor tintColor]];
    UIColor *color = [array objectAtIndex:mode];
    return color;
}

@end
