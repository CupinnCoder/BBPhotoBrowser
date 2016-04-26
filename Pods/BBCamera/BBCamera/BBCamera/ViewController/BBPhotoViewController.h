//
//  BBPhotoViewController.h
//  BBCamera
//
//  Created by Gary on 7/17/15.
//  Copyright © 2015 Gary. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BBCamera.h"

@interface BBPhotoViewController : UIViewController

+ (instancetype)new __attribute__
((unavailable("[+new] is not allowed, use [+newWithDelegate:photo:]")));

- (instancetype) init __attribute__
((unavailable("[-init] is not allowed, use [+newWithDelegate:photo:]")));

+ (instancetype)newWithDelegate:(id<BBCameraDelegate>)delegate photo:(UIImage *)photo;

- (void)setAlbumPhoto:(BOOL)isAlbumPhoto;

@end
