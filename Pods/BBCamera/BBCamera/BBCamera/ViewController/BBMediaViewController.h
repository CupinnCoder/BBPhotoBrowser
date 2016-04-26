//
//  BBMediaViewController.h
//  BBCamera
//
//  Created by Gary on 7/28/15.
//  Copyright © 2015 Gary. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BBCamera.h"
#import "BBMediaFileModel.h"

@interface BBMediaViewController : UIViewController

+ (instancetype)newWithDelegate:(id<BBCameraDelegate>)delegate mediaFile:(BBMediaFileModel *)mediaFile;

@end
