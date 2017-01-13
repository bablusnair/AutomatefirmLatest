//
//  addnewdesignations.h
//  Automate Firm
//
//  Created by leonine on 17/11/15.
//  Copyright © 2015 leonine. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface addnewdesignations : UIView<UICollectionViewDataSource,UICollectionViewDelegate>
@property(nonatomic,retain)IBOutlet UICollectionView *designationcollectionview;
-(IBAction)donebuttonaction:(id)sender;
@property(nonatomic,retain)NSMutableArray *selectedarray;


@property(nonatomic,retain)NSMutableArray *designationnamearray;

@end
