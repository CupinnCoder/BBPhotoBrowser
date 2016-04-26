//
//  BBAlbum.h
//  BBCamera
//
//  Created by Gary on 7/16/15.
//  Copyright © 2015 Gary. All rights reserved.
//

@import Foundation;
@import UIKit;

@interface BBAlbum : NSObject

+ (BOOL)isAvailable;

+ (UIImage *)imageWithMediaInfo:(NSDictionary *)info;
+ (UIImagePickerController *)imagePickerControllerWithDelegate:(id<UINavigationControllerDelegate, UIImagePickerControllerDelegate>)delegate;

@end
