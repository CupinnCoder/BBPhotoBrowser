//
//  BBCameraGridView.h
//  BBCamera
//
//  Created by Gary on 7/16/15.
//  Copyright © 2015 Gary. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BBCameraGridView : UIView

@property (nonatomic ,strong) UIColor    *lineColor;

@property (nonatomic ,assign) CGFloat    lineWidth;

@property (nonatomic ,assign) NSUInteger numberOfColumns;

@property (nonatomic ,assign) NSUInteger numberOfRows;

+ (void)disPlayGridView:(BBCameraGridView *)gridView;


@end
