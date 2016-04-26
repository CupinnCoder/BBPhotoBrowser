//
//  BBCameraProtocol.h
//  BBCamera
//
//  Created by Gary on 7/30/15.
//  Copyright © 2015 Gary. All rights reserved.
//

@import UIKit;

@class BBMediaFileModel;
@protocol BBCameraDelegate <NSObject>

- (void)cameraDidCancel;
- (void)cameraDidSelectAlbumPhoto:(UIImage *)image;
- (void)cameraDidTakePhoto:(UIImage *)image;
- (void)cameraDidTakeMedia:(BBMediaFileModel *)mediaFile;

@optional

- (void)cameraDidSavePhotoWithError:(NSError *)error;
- (void)cameraDidSavePhotoAtPath:(NSURL *)assetURL;
- (void)cameraWillTakePhoto;

@end