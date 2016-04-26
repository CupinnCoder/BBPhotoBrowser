//
//  BBAssetCell.h
//  BBPhotoBrowser
//
//  Created by Gary on 2/16/16.
//  Copyright © 2016 Gary. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PHAsset;

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, BBAssetCellClickType){
    /**
     *  无操作
     */
    BBAssetCellClickTypeNone           =    0,
    /**
     *  点击选择
     */
    BBAssetCellClickTypeSelect         =    1,
};


@protocol BBAssetCellDelegate <NSObject>

- (void)assetCellViewClick:(BBAssetCellClickType)type indexPath:(NSIndexPath*)indexPath;

@end

@interface BBAssetCell : UICollectionViewCell

@property (nonatomic, weak) id<BBAssetCellDelegate> BBAssetCellDelegate;
@property (nonatomic, copy  ) NSString      *representedAssetIdentifier;
@property (nonatomic, strong, nullable) PHAsset *asset;
@property (nonatomic) BOOL assetSelected;
@property (nonatomic, strong, readonly) UIButton *selectedBadgeButton;
@property (nonatomic, strong) NSIndexPath  *indexPath;

@end

NS_ASSUME_NONNULL_END