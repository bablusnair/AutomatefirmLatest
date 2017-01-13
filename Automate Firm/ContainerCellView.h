//
//  ContainerCellView.h
//  sometesting
//
//  Created by Emvigo on 21/01/15.
//  Copyright (c) 2015 Emvigo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ContainerCellView : UIView<UICollectionViewDataSource, UICollectionViewDelegate>
- (void)setCollectionData:(NSArray *)data;
@property (weak, nonatomic) IBOutlet UICollectionView *mycollectionView;
  @property (strong, nonatomic) NSArray *mycollectionData1;
@property (strong, nonatomic)NSMutableArray *imgarray;

@end
