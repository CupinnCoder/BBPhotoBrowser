//
//  BBiCloudDownloadHelper.h
//  BBPhotoBrowser
//
//  Created by Melvin on 1/5/16.
//  Copyright © 2016 TimeFace. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Photos/Photos.h>

typedef void (^DownloadImageFinined)();

@interface BBiCloudDownloadHelper : NSObject

+ (instancetype)sharedHelper;

- (void)cancelImageRequest:(NSString *)localIdentifier;


- (PHAssetImageProgressHandler)imageDownloadingFromiCloud:(NSString *)localIdentifier;

- (void)startDownLoadWithAsset:(PHAsset *)asset
               progressHandler:(PHAssetImageProgressHandler)progressHandler
                       finined:(DownloadImageFinined)finined;

@end
