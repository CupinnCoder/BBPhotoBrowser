//
//  PHImageManager+BBRequestImages.h
//  BBPhotoBrowser
//
//  Created by Melvin on 2/16/16.
//  Copyright © 2016 TimeFace. All rights reserved.
//

#import <Photos/Photos.h>

NS_ASSUME_NONNULL_BEGIN

@interface PHImageManager (BBRequestImages)

- (NSDictionary<NSString *, NSNumber *> *)bb_requestImagesForAssets:(NSArray<PHAsset *> *)assets
                                                         targetSize:(CGSize)targetSize
                                                        contentMode:(PHImageContentMode)contentMode
                                                            options:(nullable PHImageRequestOptions *)options
                                                      resultHandler:(void (^)(NSDictionary<NSString *, UIImage *> *__nullable results,
                                                                              NSDictionary<NSString *, NSDictionary *> *__nullable infos))resultHandler;

@end

NS_ASSUME_NONNULL_END
