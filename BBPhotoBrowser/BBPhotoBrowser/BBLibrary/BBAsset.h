//
//  BBAsset.h
//  BBPhotoBrowser
//
//  Created by Gary on 12/17/15.
//  Copyright © 2015 Gary. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Photos/Photos.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import <CoreLocation/CoreLocation.h>

typedef NS_ENUM(NSInteger, BBAssetType) {
    BBAssetTypeUnInitiliazed = -1,
    BBAssetTypeUnknown       =  0,
    BBAssetTypePhoto         =  1,
    BBAssetTypeVideo         =  2,
    BBAssetTypeAudio         =  3
};

typedef void (^DownloadImageFinined)();

@interface BBAsset : NSObject <NSCoding>

// Properties (Image)
@property (nonatomic, weak, readonly  ) UIImage        *thumbnail;
@property (nonatomic, weak, readonly  ) UIImage        *fullScreenImage;
@property (nonatomic, weak, readonly  ) UIImage        *fullResolutionImage;
@property (nonatomic, weak, readonly  ) NSData         *imageData;


// Properties (Date number)
@property (nonatomic, assign, readonly) NSTimeInterval timeInterval;// timeIntervalSince1970
@property (nonatomic, assign, readonly) NSInteger      dateTimeInteger;// yyyyMMddHH

// Properties (ALAsset or PHAsset property)
@property (nonatomic, strong, readonly) NSURL          *url;
@property (nonatomic, strong, readonly) NSString       *localIdentifier;
@property (nonatomic, assign, readonly) PHImageRequestID imageRequestID;
@property (nonatomic, strong, readonly) NSString       *md5;
@property (nonatomic, strong, readonly) CLLocation     *location;
@property (nonatomic, strong, readonly) NSDate         *date;
@property (nonatomic, strong, readonly) NSString       *fileExtension;// upper string JPG, PNG, ...
@property (nonatomic, assign, readonly) CGSize         size;
@property (nonatomic, assign, readonly) double         duration;// 0 if photo
@property (nonatomic, assign, readonly) BBAssetType    type;
@property (nonatomic, assign, readwrite) NSString      *objectKeyPath;

// Properties (Filter)
@property (nonatomic, assign, readonly) BOOL           isJPEG;
@property (nonatomic, assign, readonly) BOOL           isPHAsset;
@property (nonatomic, assign, readonly) BOOL           isPNG;
@property (nonatomic, assign, readonly) BOOL           isScreenshot;
@property (nonatomic, assign, readonly) BOOL           isPhoto;
@property (nonatomic, assign, readonly) BOOL           isVideo;
@property (nonatomic, assign) BOOL           isImageResultIsInCloud;




// APIs (Factories)
+ (BBAsset*)assetFromAL:(ALAsset*)asset;
+ (BBAsset*)assetFromPH:(PHAsset*)asset;


+ (BBAsset*)assetFromLocalIdentifier:(NSString *)localIdentifier;

// Exports
@property (nonatomic, strong, readonly) ALAsset* alAsset;
@property (nonatomic, strong, readonly) PHAsset* phAsset;


// Etc
- (NSComparisonResult)compare:(BBAsset*)asset;

- (void)downloadImageFromiCloud:(PHAssetImageProgressHandler)progressHandler
                        finined:(DownloadImageFinined)finined;

@end
