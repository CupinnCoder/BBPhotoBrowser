//
//  BBPhotoProtocol.h
//  BBPhotoBrowser
//
//  Created by Gary on 8/28/15.
//  Copyright © 2015 TimeFace. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "BBPhotoBrowserConstants.h"


// Notifications
#define BBPHOTO_LOADING_DID_END_NOTIFICATION @"BBPHOTO_LOADING_DID_END_NOTIFICATION"
#define BBPHOTO_PROGRESS_NOTIFICATION        @"BBPHOTO_PROGRESS_NOTIFICATION"


@protocol BBPhoto <NSObject>

@required
@property (nonatomic, strong) UIImage *underlyingImage;
- (void)loadUnderlyingImageAndNotify;
- (void)performLoadUnderlyingImageAndNotify;
- (void)unloadUnderlyingImage;

@optional

- (UIImage *)placeholderImage;

@property (nonatomic) BOOL emptyImage;

// Video
@property (nonatomic) BOOL isVideo;
- (void)getVideoURL:(void (^)(NSURL *url))completion;
- (NSString *)caption;
- (void)cancelAnyLoading;

@end