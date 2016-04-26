//
//  BBAlbum.m
//  BBCamera
//
//  Created by Gary on 7/16/15.
//  Copyright © 2015 Gary. All rights reserved.
//

#import "BBAlbum.h"
@import MobileCoreServices;

@implementation BBAlbum

#pragma mark -
#pragma mark - Public methods

+ (UIImage *)imageWithMediaInfo:(NSDictionary *)info
{
    NSString *mediaType = info[UIImagePickerControllerMediaType];
    
    if ([mediaType isEqualToString:(NSString *) kUTTypeImage]) {
        return info[UIImagePickerControllerEditedImage];
    }
    
    return nil;
}

+ (BOOL)isAvailable
{
    return [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeSavedPhotosAlbum];
}

+ (UIImagePickerController *)imagePickerControllerWithDelegate:(id<UINavigationControllerDelegate, UIImagePickerControllerDelegate>)delegate
{
    UIImagePickerController *pickerController = [UIImagePickerController new];
    
    pickerController = [UIImagePickerController new];
    pickerController.delegate = delegate;
    pickerController.mediaTypes = @[(NSString *) kUTTypeImage];
    pickerController.allowsEditing = YES;
    
    return pickerController;
}


@end
