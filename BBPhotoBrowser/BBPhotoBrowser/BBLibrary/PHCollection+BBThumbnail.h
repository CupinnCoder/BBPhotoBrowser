//
//  PHCollection+BBThumbnail.h
//  BBPhotoBrowser
//
//  Created by Gary on 2/16/16.
//  Copyright © 2016 Gary. All rights reserved.
//

#import <Photos/Photos.h>

NS_ASSUME_NONNULL_BEGIN

@interface PHCollection (BBThumbnail)

+ (void)bb_requestThumbnailForMomentsWithAssetsFetchOptions:(nullable PHFetchOptions *)assetFetchOptions completion:(void (^)(UIImage *__nullable result))resultHandler;
- (void)bb_requestThumbnailWithAssetsFetchOptions:(nullable PHFetchOptions *)assetFetchOptions completion:(void (^)(UIImage *__nullable result))resultHandler;
+ (void)bb_clearThumbnailCache;

@end

NS_ASSUME_NONNULL_END
