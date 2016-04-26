//
//  UIImage+BBPhotoBrowser.h
//  BBPhotoBrowser
//
//  Created by Gary on 11/13/15.
//  Copyright © 2015 Gary. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (BBPhotoBrowser)
+ (UIImage *)imageForResourcePath:(NSString *)path ofType:(NSString *)type inBundle:(NSBundle *)bundle;
+ (UIImage *)clearImageWithSize:(CGSize)size;
@end
