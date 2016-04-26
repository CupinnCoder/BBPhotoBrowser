//
//  BBCollectionCell.h
//  BBPhotoBrowser
//
//  Created by Gary on 2/16/16.
//  Copyright © 2016 Gary. All rights reserved.
//

#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN
@interface BBCollectionCell : UITableViewCell

@property (nonatomic, readonly, strong) UILabel     *titleLabel;
@property (nonatomic, readonly, strong) UILabel     *subtitleLabel;
@property (nonatomic, readonly, strong) UIImageView *thumbnailView;

@end
NS_ASSUME_NONNULL_END