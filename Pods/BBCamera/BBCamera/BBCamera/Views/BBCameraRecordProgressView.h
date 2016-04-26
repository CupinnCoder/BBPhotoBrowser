//
//  BBCameraRecordProgressView.h
//  BBCamera
//
//  Created by Gary on 7/22/15.
//  Copyright © 2015 Gary. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BBCameraRecordProgressView : UIView

@property (nonatomic) CGFloat minimumWidthLimit;
@property (nonatomic) CGFloat progress;
@property (nonatomic) CGFloat progressWidth;

- (void)startRecord;
- (void)stopRecord;

- (void)insertBlockView;
@end
