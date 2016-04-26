//
//  PHPhotoLibrary+BBBlockObservers.m
//  BBPhotoBrowser
//
//  Created by Melvin on 2/16/16.
//  Copyright © 2016 TimeFace. All rights reserved.
//

#import "PHPhotoLibrary+BBBlockObservers.h"

NS_ASSUME_NONNULL_BEGIN

@interface BBBlockObserverToken () <PHPhotoLibraryChangeObserver>

@property (nonatomic, copy) BBPhotoLibraryChangeObserverBlock changeObserverBlock;
@property (nonatomic, strong, nullable) BBBlockObserverToken *strongSelf;

@end

@implementation BBBlockObserverToken

- (void)photoLibraryDidChange:(PHChange *)changeInstance {
    _changeObserverBlock(changeInstance);
}

@end

@implementation PHPhotoLibrary (BBBlockObservers)

- (BBBlockObserverToken *)BB_registerChangeObserverBlock:(BBPhotoLibraryChangeObserverBlock)observer {
    BBBlockObserverToken *token = [[BBBlockObserverToken alloc] init];
    token.changeObserverBlock = observer;
    token.strongSelf = token;
    
    [self registerChangeObserver:token];
    
    return token;
}

- (void)BB_unregisterChangeObserverBlock:(BBBlockObserverToken *)token {
    [self unregisterChangeObserver:token];
    token.strongSelf = nil;
}

@end

NS_ASSUME_NONNULL_END