//
//  PHPhotoLibrary+BBBlockObservers.h
//  BBPhotoBrowser
//
//  Created by Gary on 2/16/16.
//  Copyright © 2016 Gary. All rights reserved.
//

#import <Photos/Photos.h>

NS_ASSUME_NONNULL_BEGIN

@interface BBBlockObserverToken : NSObject

@end

typedef void (^BBPhotoLibraryChangeObserverBlock)(PHChange *change);


@interface PHPhotoLibrary (BBBlockObservers)

- (BBBlockObserverToken *)BB_registerChangeObserverBlock:(BBPhotoLibraryChangeObserverBlock)observer;
- (void)BB_unregisterChangeObserverBlock:(BBBlockObserverToken *)token;

@end

NS_ASSUME_NONNULL_END
