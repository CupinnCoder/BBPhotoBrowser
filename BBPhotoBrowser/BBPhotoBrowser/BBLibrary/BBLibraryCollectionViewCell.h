//
//  BBLibraryCollectionViewCell.h
//  BBPhotoBrowser
//
//  Created by Melvin on 12/17/15.
//  Copyright © 2015 TimeFace. All rights reserved.
//

#import <UIKit/UIKit.h>
@class PHAsset;
typedef NS_ENUM (NSInteger, BBCollectionViewType) {
    /**
     *  默认
     */
    BBCollectionViewTypeNone          = 0,
    /**
     *  打开相机
     */
    BBCollectionViewTypeCamera        = 1,
    /**
     *  打开相册
     */
    BBCollectionViewTypeLibrary       = 2,
};

@interface BBLibraryCollectionViewCell : UICollectionViewCell
@property (nonatomic, copy  ) NSString             *representedAssetIdentifier;
@property (nonatomic, assign) BBCollectionViewType viewType;
@property (nonatomic, assign) BOOL                 showsOverlayViewWhenSelected;
@property (nonatomic, assign) BOOL                 imageDownloadingFromCloud;

- (void)setThumbnailImage:(UIImage *)thumbnailImage imageResultIsInCloud:(BOOL)imageResultIsInCloud;
- (void)setLivePhotoBadgeImage:(UIImage *)livePhotoBadgeImage;

- (void)startDownloadImageFromiCloud;
- (void)updateDownLoadStateByProgress:(double)progress;

@end
