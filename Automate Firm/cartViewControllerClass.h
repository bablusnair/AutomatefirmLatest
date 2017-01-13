//
//  cartViewControllerClass.h
//  Automate Firm
//
//  Created by leonine on 25/10/16.
//  Copyright © 2016 leonine. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface cartViewControllerClass : UIViewController
@property (weak, nonatomic) IBOutlet UICollectionView *cartCollection;
@property (weak, nonatomic) IBOutlet UICollectionView *mainOfficeCollection;
@property (weak, nonatomic) IBOutlet UIButton *nextButn;
@property (weak, nonatomic) IBOutlet UIButton *previousBtn;
@property (nonatomic,retain)NSMutableArray *mainOfficeAray;
@property (nonatomic,retain)NSMutableArray *outletAray;
@property (nonatomic,assign)int cellFlag;
@property (weak, nonatomic) IBOutlet UITableView *productTable;
@property(nonatomic,retain)NSMutableArray *productImageAray;
@property(nonatomic,retain)NSMutableArray *productLabelAray;

@end
