//
//  BBCameraViewController.h
//  BBCamera
//
//  Created by Gary on 7/17/15.
//  Copyright © 2015 Gary. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BBAlbum.h"
#import "BBAssetsLibrary.h"
#import "BBCamera.h"
#import "BBCameraNavigationController.h"

@interface BBCameraViewController : UIViewController

@property (weak) id<BBCameraDelegate> delegate;

@end
