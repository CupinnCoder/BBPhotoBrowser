//
//  BBCollectionPickerController.h
//  BBPhotoBrowser
//
//  Created by Gary on 2/16/16.
//  Copyright © 2016 Gary. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BBCollectionPickerController;
@class PHAssetCollection;
@class PHCollectionList;
@class PHFetchOptions;

NS_ASSUME_NONNULL_BEGIN

@protocol BBCollectionPickerControllerDelegate <NSObject>

- (void)collectionPicker:(BBCollectionPickerController *)collectionPicker didSelectCollection:(nullable PHAssetCollection *)collection;
@end

@interface BBCollectionPickerController : UITableViewController

@property (nonatomic, weak, nullable) id<BBCollectionPickerControllerDelegate> delegate;

@property (nonatomic, copy, nullable) NSArray<PHAssetCollection *> *additionalAssetCollections;

@property (nonatomic, strong, nullable) PHCollectionList *collectionList;

@property (nonatomic, copy, nullable) PHFetchOptions *asseBBetchOptions;

@end

NS_ASSUME_NONNULL_END
