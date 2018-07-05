//
//  CollectionViewCell.m
//  taskManagerContainerView
//
//  Created by paul on 05/07/2018.
//  Copyright © 2018 paul. All rights reserved.
//

#import "CollectionViewCell.h"

@implementation CollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
        return [super initWithFrame:frame];
}

- (UILabel *)collectionCell {
    if (!_collectionCell) {
        _collectionCell = [[UILabel alloc] init];
        _collectionCell.translatesAutoresizingMaskIntoConstraints = NO;
        [_collectionCell setFont:[UIFont fontWithName:@"Georgia-BoldItalic" size:15]];
        [self addSubview:self.collectionCell];
        
        [NSLayoutConstraint activateConstraints:@[[self.collectionCell.centerXAnchor constraintEqualToAnchor:self.centerXAnchor],
                                                  [self.collectionCell.centerYAnchor constraintEqualToAnchor:self.centerYAnchor]]];
    }
    return _collectionCell;
}
@end
