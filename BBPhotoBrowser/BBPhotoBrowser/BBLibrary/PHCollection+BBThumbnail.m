//
//  PHCollection+BBThumbnail.m
//  BBPhotoBrowser
//
//  Created by Melvin on 2/16/16.
//  Copyright © 2016 TimeFace. All rights reserved.
//

#import "PHCollection+BBThumbnail.h"
#import "UIImage+BBAspectDraw.h"
#import "PHPhotoLibrary+BBBlockObservers.h"
#import "PHImageManager+BBRequestImages.h"


#define BBMomentsIdentifier @"Moments"

#define BBPrimaryThumbnailWidth     68.0
#define BBTotalThumbnailWidth       76.0
#define BBListRows                  3.0

NS_ASSUME_NONNULL_BEGIN

@implementation PHCollection (BBThumbnail)

+ (NSCache *)_bb_thumbnailImageCache {
    static NSCache *imageCache = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        imageCache = [[NSCache alloc] init];
        imageCache.name = @"PHCollection/BBThumbnail";
        
        [[PHPhotoLibrary sharedPhotoLibrary] BB_registerChangeObserverBlock:^(PHChange *change) {
            [PHCollection bb_clearThumbnailCache];
        }];
    });
    
    return imageCache;
}

+ (NSString *)_bb_cacheKeyForOptions:(PHFetchOptions *)asseBBetchOptions
{
    NSMutableString *keyString = [NSMutableString new];
    
    [keyString appendString:asseBBetchOptions.predicate.predicateFormat];
    
    for (NSSortDescriptor *sortDescriptor in asseBBetchOptions.sortDescriptors) {
        [keyString appendString:sortDescriptor.key];
        [keyString appendFormat:@"%d", sortDescriptor.ascending];
    }
    
    [keyString appendFormat:@"%d", asseBBetchOptions.includeAllBurstAssets];
    [keyString appendFormat:@"%d", asseBBetchOptions.includeHiddenAssets];
    
    return [NSString stringWithFormat:@"%lu", (unsigned long)[keyString hash]];
}

+ (void)bb_requestThumbnailForMomentsWithAssetsFetchOptions:(nullable PHFetchOptions *)assetFetchOptions completion:(void (^)(UIImage *__nullable result))resultHandler
{
    NSString *cacheKey = nil;
    if (assetFetchOptions == nil) {
        cacheKey = BBMomentsIdentifier;
    } else {
        cacheKey = [NSString stringWithFormat:@"%@/%@", BBMomentsIdentifier, [PHCollection _bb_cacheKeyForOptions:assetFetchOptions]];
    }
    
    UIImage *thumbnail = [[PHCollection _bb_thumbnailImageCache] objectForKey:cacheKey];
    if (thumbnail == nil) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            [PHCollection _BB_requestThumbnailForMomentsWithAssetsFetchOptions:assetFetchOptions completion:^(UIImage *result) {
                if (result == nil) {
                    [[PHCollection _bb_thumbnailImageCache] setObject:[NSNull null] forKey:cacheKey];
                } else {
                    [[PHCollection _bb_thumbnailImageCache] setObject:result forKey:cacheKey];
                }
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    resultHandler(result);
                });
            }];
        });
    } else {
        if ([thumbnail isKindOfClass:[NSNull class]]) {
            resultHandler(nil);
        } else {
            resultHandler(thumbnail);
        }
    }
}

+ (void)_BB_requestThumbnailForMomentsWithAssetsFetchOptions:(nullable PHFetchOptions *)asseBBetchOptions completion:(void (^)(UIImage *__nullable result))resultHandler
{
    CGSize assetSize = CGSizeMake(BBPrimaryThumbnailWidth, BBPrimaryThumbnailWidth);
    assetSize.width *= [UIScreen mainScreen].scale;
    assetSize.height *= [UIScreen mainScreen].scale;
    
    PHImageRequestOptions *options = [[PHImageRequestOptions alloc] init];
    options.deliveryMode = PHImageRequestOptionsDeliveryModeHighQualityFormat;
    options.resizeMode = PHImageRequestOptionsResizeModeFast;
    
    NSMutableArray *assets = [NSMutableArray new];
    PHFetchResult *moments = [PHAssetCollection fetchMomentsWithOptions:nil];
    [moments enumerateObjectsWithOptions:NSEnumerationReverse usingBlock:^(PHAssetCollection *moment, NSUInteger idx, BOOL *stop) {
        PHFetchResult *keyResult = [PHAsset fetchAssetsInAssetCollection:moment options:asseBBetchOptions];
        
        [keyResult enumerateObjectsUsingBlock:^(PHAsset *asset, NSUInteger idx, BOOL *stop) {
            [assets addObject:asset];
            
            *stop = assets.count >= 3;
        }];
        
        *stop = assets.count >= 3;
    }];
    
    [[PHImageManager defaultManager] bb_requestImagesForAssets:assets targetSize:assetSize contentMode:PHImageContentModeAspectFill options:options resultHandler:^(NSDictionary *results, NSDictionary *infos) {
        UIGraphicsBeginImageContextWithOptions(CGSizeMake(BBTotalThumbnailWidth, BBTotalThumbnailWidth), NO, 0.0);
        
        for (NSInteger index = 2; index >= 0; index--) {
            CGRect asseBBrame;
            asseBBrame.origin.y = (2 - index) * 2.0;
            asseBBrame.origin.x = index * 2.0 + 4.0;
            asseBBrame.size.width = BBPrimaryThumbnailWidth - index * 4.0;
            asseBBrame.size.height = BBPrimaryThumbnailWidth - index * 4.0;
            
            UIImage *image = nil;
            if (assets.count > index) {
                PHAsset *asset = assets[index];
                image = results[asset.localIdentifier];
            }
            
            if (image != nil) {
                [image BB_drawInRectWithAspecBBill:asseBBrame];
            }
            
            CGFloat lineWidth = 1.0 / [UIScreen mainScreen].scale;
            CGRect borderRect = CGRectInset(asseBBrame, -lineWidth / 2.0, -lineWidth / 2.0);
            UIBezierPath *border = [UIBezierPath bezierPathWithRect:borderRect];
            border.lineWidth = lineWidth;
            [[UIColor whiteColor] setStroke];
            [border stroke];
        }
        
        UIImage *retImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        
        resultHandler(retImage);
    }];
}

- (void)bb_requestThumbnailWithAssetsFetchOptions:(nullable PHFetchOptions *)assetFetchOptions completion:(void (^)(UIImage *__nullable result))resultHandler
{
    NSString *cacheKey = nil;
    if (assetFetchOptions == nil) {
        cacheKey = self.localIdentifier;
    } else {
        cacheKey = [NSString stringWithFormat:@"%@/%@", self.localIdentifier, [PHCollection _bb_cacheKeyForOptions:assetFetchOptions]];
    }
    
    UIImage *thumbnail = [[PHCollection _bb_thumbnailImageCache] objectForKey:cacheKey];
    if (thumbnail == nil) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            [self _bb_requestThumbnailWithAssetsFetchOptions:assetFetchOptions completion:^(UIImage *result) {
                if (result == nil) {
                    [[PHCollection _bb_thumbnailImageCache] setObject:[NSNull null] forKey:cacheKey];
                } else {
                    [[PHCollection _bb_thumbnailImageCache] setObject:result forKey:cacheKey];
                }
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    resultHandler(result);
                });
            }];
        });
    } else {
        if ([thumbnail isKindOfClass:[NSNull class]]) {
            resultHandler(nil);
        } else {
            resultHandler(thumbnail);
        }
    }
}

- (void)_bb_requestThumbnailWithAssetsFetchOptions:(nullable PHFetchOptions *)assetFetchOptions completion:(void (^)(UIImage *__nullable result))resultHandler
{
    resultHandler(nil);
}

+ (void)bb_clearThumbnailCache
{
    [[PHCollection _bb_thumbnailImageCache] removeAllObjects];
}

@end


@implementation PHAssetCollection (BBThumbnail)

- (void)_tnk_requestThumbnailWithAssetsFetchOptions:(nullable PHFetchOptions *)asseBBetchOptions completion:(void (^)(UIImage *__nullable result))resultHandler {
    CGSize assetSize = CGSizeMake(BBPrimaryThumbnailWidth, BBPrimaryThumbnailWidth);
    assetSize.width *= [UIScreen mainScreen].scale;
    assetSize.height *= [UIScreen mainScreen].scale;
    
    PHImageRequestOptions *options = [[PHImageRequestOptions alloc] init];
    options.deliveryMode = PHImageRequestOptionsDeliveryModeHighQualityFormat;
    options.resizeMode = PHImageRequestOptionsResizeModeFast;
    
    PHFetchResult *keyResult = [PHAsset fetchKeyAssetsInAssetCollection:self options:nil];
    if (keyResult.count <= 0) {
        PHFetchOptions *fetchOptions = [asseBBetchOptions copy];
        fetchOptions.sortDescriptors = @[
                                         [NSSortDescriptor sortDescriptorWithKey:@"creationDate" ascending:NO],
                                         ];
        keyResult = [PHAsset fetchAssetsInAssetCollection:self options:fetchOptions];
    }
    
    if (keyResult.count == 0) {
        resultHandler(nil);
        return;
    }
    
    NSMutableArray *assets = [NSMutableArray new];
    for (NSUInteger i = 0; i < 3; i++) {
        if (keyResult.count > i) {
            [assets addObject:[keyResult objectAtIndex:i]];
        }
    }
    
    [[PHImageManager defaultManager] bb_requestImagesForAssets:assets targetSize:assetSize contentMode:PHImageContentModeAspectFill options:options resultHandler:^(NSDictionary *results, NSDictionary *infos) {
        UIGraphicsBeginImageContextWithOptions(CGSizeMake(BBTotalThumbnailWidth, BBTotalThumbnailWidth), NO, 0.0);
        
        for (NSInteger index = 2; index >= 0; index--) {
            CGRect asseBBrame;
            asseBBrame.origin.y = (2 - index) * 2.0;
            asseBBrame.origin.x = index * 2.0 + 4.0;
            asseBBrame.size.width = BBPrimaryThumbnailWidth - index * 4.0;
            asseBBrame.size.height = BBPrimaryThumbnailWidth - index * 4.0;
            
            UIImage *image = nil;
            if (assets.count > index) {
                PHAsset *asset = assets[index];
                image = results[asset.localIdentifier];
            }
            
            if (image != nil) {
                [image BB_drawInRectWithAspecBBill:asseBBrame];
            }
            
            CGFloat lineWidth = 1.0 / [UIScreen mainScreen].scale;
            CGRect borderRect = CGRectInset(asseBBrame, -lineWidth / 2.0, -lineWidth / 2.0);
            UIBezierPath *border = [UIBezierPath bezierPathWithRect:borderRect];
            border.lineWidth = lineWidth;
            [[UIColor whiteColor] setStroke];
            [border stroke];
        }
        
        UIImage *retImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        
        resultHandler(retImage);
    }];
}

@end


@implementation PHCollectionList (BBThumbnail)

- (NSArray<PHAsset *> *)_BB_keyAssets {
    PHFetchResult *collections = [PHCollection fetchCollectionsInCollectionList:self options:nil];
    NSMutableArray *assets = [NSMutableArray new];
    
    [collections enumerateObjectsUsingBlock:^(PHAssetCollection *collection, NSUInteger index, BOOL *stop) {
        if ([collection isKindOfClass:[PHAssetCollection class]]) {
            PHFetchResult *keyResult = [PHAsset fetchKeyAssetsInAssetCollection:collection options:nil];
            if (keyResult.count <= 0) {
                keyResult = [PHAsset fetchAssetsInAssetCollection:collection options:nil];
            }
            
            PHAsset *asset = keyResult.firstObject;
            [assets addObject:asset];
        }
        
        if (assets.count >= BBListRows * BBListRows) {
            *stop = YES;
        }
    }];
    
    return assets;
}

- (void)_tnk_requestThumbnailWithAssetsFetchOptions:(nullable PHFetchOptions *)asseBBetchOptions completion:(void (^)(UIImage *__nullable result))resultHandler {
    CGFloat individualWidth = (BBPrimaryThumbnailWidth - BBListRows + 1.0) / BBListRows;
    CGSize assetSize = CGSizeMake(individualWidth, individualWidth);
    assetSize.width *= [UIScreen mainScreen].scale;
    assetSize.height *= [UIScreen mainScreen].scale;
    
    PHImageRequestOptions *options = [[PHImageRequestOptions alloc] init];
    options.deliveryMode = PHImageRequestOptionsDeliveryModeHighQualityFormat;
    options.resizeMode = PHImageRequestOptionsResizeModeFast;
    
    NSArray *assets = [self _BB_keyAssets];
    
    [[PHImageManager defaultManager] bb_requestImagesForAssets:assets targetSize:assetSize contentMode:PHImageContentModeAspectFill options:options resultHandler:^(NSDictionary *results, NSDictionary *infos) {
        UIGraphicsBeginImageContextWithOptions(CGSizeMake(BBTotalThumbnailWidth, BBTotalThumbnailWidth), NO, 0.0);
        //        CGContextRef context = UIGraphicsGetCurrentContext();
        
        NSUInteger assetIndex = 0;
        
        for (NSUInteger row = 0; row < 3; row++) {
            for (NSUInteger column = 0; column < 3; column++) {
                CGRect asseBBrame;
                asseBBrame.size.width = (BBPrimaryThumbnailWidth - BBListRows + 1.0) / BBListRows;
                asseBBrame.size.height = asseBBrame.size.width;
                asseBBrame.origin.y = row * (asseBBrame.size.height + 1.0) + 4.0;
                asseBBrame.origin.x = column * (asseBBrame.size.width + 1.0) + 4.0;
                
                UIImage *image = nil;
                if (assets.count > assetIndex) {
                    PHAsset *asset = assets[assetIndex];
                    image = results[asset.localIdentifier];
                }
                
                if (image != nil) {
                    [image BB_drawInRectWithAspecBBill:asseBBrame];
                } else {
                    [[UIColor colorWithRed:0.921 green:0.921 blue:0.946 alpha:1.000] setFill];
                    [[UIBezierPath bezierPathWithRect:asseBBrame] fill];
                }
                
                assetIndex++;
            }
        }
        
        UIImage *retImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        
        resultHandler(retImage);
    }];
}

@end

NS_ASSUME_NONNULL_END
