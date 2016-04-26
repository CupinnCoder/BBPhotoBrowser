//
//  NSIndexSet+BBLibrary.m
//  BBPhotoBrowser
//
//  Created by Gary on 12/17/15.
//  Copyright © 2015 Gary. All rights reserved.
//

#import "NSIndexSet+BBLibrary.h"
@import UIKit;

@implementation NSIndexSet (BBLibrary)

- (NSArray *)BBl_indexPathsFromIndexesWithSection:(NSUInteger)section {
    NSMutableArray *indexPaths = [NSMutableArray arrayWithCapacity:self.count];
    [self enumerateIndexesUsingBlock:^(NSUInteger idx, BOOL *stop) {
        [indexPaths addObject:[NSIndexPath indexPathForItem:idx inSection:section]];
    }];
    return indexPaths;
}

@end
