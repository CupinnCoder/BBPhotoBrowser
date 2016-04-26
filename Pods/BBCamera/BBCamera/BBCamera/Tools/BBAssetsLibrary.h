//
//  BBAssetsLibrary.h
//  BBCamera
//
//  Created by Gary on 7/16/15.
//  Copyright © 2015 Gary. All rights reserved.
//

#import <AssetsLibrary/AssetsLibrary.h>
#import <UIKit/UIKit.h>
#import <Photos/Photos.h>
#import "BBAssetImageFile.h"

typedef void(^BBAssetsResultCompletion)(NSURL *assetURL);
typedef void(^BBAssetsFailureCompletion)(NSError* error);
typedef void(^BBAssetsLoadImagesCompletion)(NSArray *items, NSError *error);



@interface BBAssetsLibrary : ALAssetsLibrary

+ (instancetype) new __attribute__
((unavailable("[+new] is not allowed, use [+defaultAssetsLibrary]")));

- (instancetype) init __attribute__
((unavailable("[-init] is not allowed, use [+defaultAssetsLibrary]")));

+ (BBAssetsLibrary *)defaultAssetsLibrary;

- (void)deleteFile:(BBAssetImageFile *)file;

- (NSArray *)loadImagesFromDocumentDirectory;
- (void)loadImagesFromAlbum:(NSString *)albumName withCallback:(BBAssetsLoadImagesCompletion)callback;

- (void)saveImage:(UIImage *)image resultBlock:(BBAssetsResultCompletion)resultBlock failureBlock:(BBAssetsFailureCompletion)failureBlock;
- (void)saveImage:(UIImage *)image withAlbumName:(NSString *)albumName resultBlock:(BBAssetsResultCompletion)resultBlock failureBlock:(BBAssetsFailureCompletion)failureBlock;
- (void)saveJPGImageAtDocumentDirectory:(UIImage *)image resultBlock:(BBAssetsResultCompletion)resultBlock failureBlock:(BBAssetsFailureCompletion)failureBlock;

- (void)latestPhotoWithCompletion:(void (^)(UIImage *photo))completion;


@end
