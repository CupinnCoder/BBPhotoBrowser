//
//  UIButton+BBCameraButton.h
//  BBCamera
//
//  Created by Gary on 7/20/15.
//  Copyright © 2015 Gary. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (BBCameraButton)

+ (UIButton*) BBcCreateButtonWithFrame:(CGRect)frame
                                target:(id)target
                              selector:(SEL)selector
                                 image:(NSString *)image
                          imagePressed:(NSString *)imagePressed;

+ (UIButton *) BBcCreateButtonWithImage:(NSString *)image
                           imagePressed:(NSString *)imagePressed
                                 target:(id)target
                               selector:(SEL)selector;

+ (UIButton *) BBcCreateButtonWithFrame:(CGRect)frame
                                  title:(NSString *)title
                                 target:(id)target
                               selector:(SEL)selector;

+ (UIButton *) BBcCreateButtonWithTitle:(NSString *)title
                                 target:(id)target
                               selector:(SEL)selector;

- (void)BBcUpdateButtonImage:(NSString *)image
                imagePressed:(NSString *)imagePressed;

@end
