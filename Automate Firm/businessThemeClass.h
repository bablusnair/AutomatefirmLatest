//
//  businessThemeClass.h
//  Automate Firm
//
//  Created by leonine on 7/27/16.
//  Copyright © 2016 leonine. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface businessThemeClass : UIView<UICollectionViewDelegate,UICollectionViewDataSource>
@property(nonatomic,retain)IBOutlet UICollectionView *themeCollectionView;

-(IBAction)colorChangeAction:(id)sender;
-(IBAction)done:(id)sender;
-(IBAction)cancel:(id)sender;

@property(nonatomic,retain)NSMutableArray *formArray;
@property(nonatomic,retain)NSMutableArray *idFrontArray;
@property(nonatomic,retain)NSMutableArray *idBackArray;

@property(nonatomic,retain)NSIndexPath *selectedIndex;

-(IBAction)checkBoxAction:(id)sender;

@end
