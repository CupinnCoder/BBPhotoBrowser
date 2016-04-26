//
//  BBLibraryCameraCollectionViewCell.h
//  BBPhotoBrowser
//
//  Created by Melvin on 1/5/16.
//  Copyright © 2016 TimeFace. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol BBLibraryCameraCollectionViewCellDelegate <NSObject>
@optional;
- (void)cameraViewDidAppear;
- (void)cameraViewDidDisappear;

@end

@interface BBLibraryCameraCollectionViewCell : UICollectionViewCell

@property (nonatomic ,weak) id<BBLibraryCameraCollectionViewCellDelegate> delegate;
- (void)startCamera;
- (void)removeCamera;

@end
