//
//  BBMomentHeaderView.h
//  BBPhotoBrowser
//
//  Created by Gary on 2/16/16.
//  Copyright © 2016 Gary. All rights reserved.
//

#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN
@interface BBMomentHeaderView : UICollectionReusableView


@property (nonatomic, strong, readonly) UILabel *primaryLabel;
@property (nonatomic, strong, readonly) UILabel *secondaryLabel;
@property (nonatomic, strong, readonly) UILabel *detailLabel;
@property (nonatomic, strong, readonly) UIButton *selectedButton;
@property (nonatomic, strong) NSIndexPath  *indexPath;
@property (nonatomic, assign) BOOL  showAllSelectButton;

@end
NS_ASSUME_NONNULL_END