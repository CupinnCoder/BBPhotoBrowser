//
//  BBImagePickerController.h
//  BBPhotoBrowser
//
//  Created by Gary on 2/16/16.
//  Copyright © 2016 Gary. All rights reserved.
//

#import <UIKit/UIKit.h>
@import MobileCoreServices;
#import "PHImageManager+BBRequestImages.h"
#import "PHAsset+BBExpand.h"

@class BBAsset;
@class PHAssetCollection;
@class BBImagePickerController;
@class BBPhotoBrowser;

NS_ASSUME_NONNULL_BEGIN

@protocol BBImagePickerControllerDelegate <NSObject>

@optional
- (void)imagePickerController:(BBImagePickerController *)picker
       didFinishPickingAssets:(NSArray<PHAsset *> *)assets;

- (void)imagePickerControllerDidCancel:(BBImagePickerController *)picker;

- (nullable UIViewController *)imagePickerController:(BBImagePickerController *)picker
                     willDisplayDetailViewController:(BBPhotoBrowser *)viewController
                                            forAsset:(PHAsset *)asset;

- (nullable UIViewController *)imagePickerController:(BBImagePickerController *)picker
                     willDisplayCameraViewController:(UIImagePickerController *)viewController;


- (NSString *)imagePickerControllerTitleForDoneButton:(BBImagePickerController *)picker;

- (void)imagePickerControllerDidScan:(BBImagePickerController *)picker;

- (void)imagePickerController:(BBImagePickerController *)picker didSelectedPickingAssets:(NSArray<PHAsset *> *)assets;

@end


@interface BBImagePickerController : UICollectionViewController
- (instancetype)init NS_DESIGNATED_INITIALIZER;
- (instancetype)initWithCoder:(NSCoder *)aDecoder NS_DESIGNATED_INITIALIZER;
- (instancetype)initWithNibName:(nullable NSString *)nibNameOrNil bundle:(nullable NSBundle *)nibBundleOrNil NS_UNAVAILABLE;
- (instancetype)initWithCollectionViewLayout:(UICollectionViewLayout *)layout NS_UNAVAILABLE;

- (instancetype)initWithScanButton NS_DESIGNATED_INITIALIZER;

@property (nonatomic, weak, nullable) id<BBImagePickerControllerDelegate> delegate;

@property (nonatomic, readonly) UIBarButtonItem *cancelButton;
@property (nonatomic, readonly) UIBarButtonItem *doneButton;
@property (nonatomic, readonly) UIBarButtonItem *cameraButton;
@property (nonatomic, readonly) UIBarButtonItem *scanButton;
@property (nonatomic, readonly) UIBarButtonItem *pasteButton;
@property (nonatomic, readonly) UIBarButtonItem *selectAllButton;

@property (nonatomic, strong, null_resettable) UIImage *selectedAssetBadgeImage;

@property (nonatomic, copy) NSArray<NSString *> *mediaTypes;

@property (nonatomic, assign) BOOL      allowsMultipleSelection;
@property (nonatomic, assign) NSInteger maxSelectedCount;

@property (nonatomic, assign) BOOL      showAllSelectButton;

@property (nonatomic, assign, readonly) BOOL      showScanButton;

/** The asset collection the picker will display to the user.
 
 The user can change this, but you can set this as a default. nil (the default) will cause the picker to display the user's moments.
 */
@property (nonatomic, strong, nullable) PHAssetCollection *assetCollection;

/** The currently selected assets.
 
 Instances are `PHAsset` objects. You can set this to provide default assets to be selected, or read them to see what the user has selected. The order will be roughly the same as the order that the user selected them in.
 */
@property (nonatomic, copy) NSArray<PHAsset *> *selectedAssets;
- (void)selectAsset:(PHAsset *)asset;
- (void)deselectAsset:(PHAsset *)asset;
@end

NS_ASSUME_NONNULL_END