//
//  ViewController.m
//  taskManagerContainerView
//
//  Created by paul on 05/07/2018.
//  Copyright © 2018 paul. All rights reserved.
//

#import "ViewController.h"
#import "CollectionViewCell.h"

static NSString * const cellIdentifier = @"cellIdentifier";

@interface ViewController ()<UICollectionViewDataSource>
@property (weak, nonatomic) IBOutlet UICollectionView *CollectionView;
@property(nonatomic) NSMutableArray* dataSource;
@end

@implementation ViewController

- (NSMutableArray *)dataSource {
    if (!_dataSource) {
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.CollectionView.dataSource = self;
    
    [self.CollectionView registerClass:[CollectionViewCell class] forCellWithReuseIdentifier: cellIdentifier];
    
    UILongPressGestureRecognizer *longPressGesture = [[UILongPressGestureRecognizer alloc] init];
    [longPressGesture addTarget:self action:@selector(recognizeLongPressGesture:)];
    [self.CollectionView addGestureRecognizer:longPressGesture];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)recognizeLongPressGesture:(UILongPressGestureRecognizer *)gesture {
    
    CGPoint position = [gesture locationInView:self.CollectionView];
    NSIndexPath *selectedIndexPath = [self.CollectionView indexPathForItemAtPoint:position];
    
    switch (gesture.state) {
        case UIGestureRecognizerStateBegan:
            [self.CollectionView beginInteractiveMovementForItemAtIndexPath:selectedIndexPath];
            break;
        case UIGestureRecognizerStateChanged:
            [self.CollectionView updateInteractiveMovementTargetPosition:position];
            break;
        case UIGestureRecognizerStateEnded:
            [self.CollectionView endInteractiveMovement];
            break;
        default:
            [self.CollectionView cancelInteractiveMovement];
    }
}
- (IBAction)addTask:(id)sender {
    [self.dataSource addObject:[NSString stringWithFormat:@"Just do this %lu", self.dataSource.count + 1]];
    [self.CollectionView insertItemsAtIndexPaths:@[[NSIndexPath indexPathForItem:self.dataSource.count - 1 inSection:0]]];
}


- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    cell.collectionCell.text = self.dataSource[indexPath.row];
    return cell;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canMoveItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (void)collectionView:(UICollectionView *)collectionView moveItemAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath {
    NSString *item = self.dataSource[sourceIndexPath.row];
    [self.dataSource removeObjectAtIndex:sourceIndexPath.row];
    [self.dataSource insertObject:item atIndex:destinationIndexPath.row];
}



@end
