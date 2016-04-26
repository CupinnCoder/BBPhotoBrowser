//
//  BBAssetImageView.h
//  BBPhotoBrowser
//
//  Created by Gary on 2/16/16.
//  Copyright © 2016 Gary. All rights reserved.
//

#import <UIKit/UIKit.h>
@import Photos;
NS_ASSUME_NONNULL_BEGIN

@interface BBAssetImageView : UIImageView

@property (nonatomic, strong, nullable) UIImage *defaultImage;

@property (nonatomic, assign, readonly) PHImageRequestID imageRequestID;
@property (nonatomic, strong, nullable) PHAsset *asset;

- (void)setNeedsAssetReload;
- (void)loadAssetImage;
- (void)cancelAssetImageRequest;

@end

NS_ASSUME_NONNULL_END