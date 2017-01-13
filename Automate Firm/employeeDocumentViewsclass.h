//
//  employeedocumentviewclass.h
//  bablusdemokpproject
//
//  Created by leonine on 7/11/15.
//  Copyright (c) 2015 Emvigo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ViewController.h"
@interface employeeDocumentViewsclass : UIView<UICollectionViewDataSource,UICollectionViewDelegate>
@property (strong, nonatomic) IBOutlet UICollectionView *mycollectionView;
@property(nonatomic,retain)NSMutableArray *documentNameArray;
@property(nonatomic,retain)NSMutableArray *documentIDArray;
@end
