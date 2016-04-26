//
//  UIImage+BBPhotoBrowser.h
//  BBPhotoBrowser
//
//  Created by Melvin on 11/13/15.
//  Copyright © 2015 TimeFace. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (BBPhotoBrowser)
+ (UIImage *)imageForResourcePath:(NSString *)path ofType:(NSString *)type inBundle:(NSBundle *)bundle;
+ (UIImage *)clearImageWithSize:(CGSize)size;
@end
