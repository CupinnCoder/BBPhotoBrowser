//
//  ALAssetRepresentation+BBMD5.h
//  BBPhotoBrowser
//
//  Created by Gary on 1/4/16.
//  Copyright © 2016 Gary. All rights reserved.
//

#import <AssetsLibrary/AssetsLibrary.h>

@interface ALAssetRepresentation (BBMD5)
- (NSString *)hashString;
- (NSString *)getMD5String;
@end
