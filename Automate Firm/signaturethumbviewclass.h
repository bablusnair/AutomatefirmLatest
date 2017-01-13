//
//  signaturethumbview.h
//  bablusdemokpproject
//
//  Created by leonine on 31/08/15.
//  Copyright (c) 2015 Emvigo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface signaturethumbviewclass : UIView<UICollectionViewDataSource,UICollectionViewDelegate>
@property (strong, nonatomic) IBOutlet UICollectionView *mysignaturecollctionview;
@property(nonatomic,retain)NSMutableArray *mysignaturearray;
@property(nonatomic,retain)NSMutableArray *selectedarray;
-(IBAction)donebuttonaction:(id)sender;
@property (nonatomic, assign) CGPoint lastContactPoint1, lastContactPoint2, currentPoint;
@property (nonatomic, assign) CGRect imageFrame;
@property (nonatomic, assign) BOOL fingerMoved;
@property (strong, nonatomic) IBOutlet UIImageView *mySignatureImage;

-(IBAction)clearsignature:(id)sender;
@property (strong, nonatomic) UIColor *myselectedcolor;
-(IBAction)selectedcolorbuttonaction:(id)sender;
@end
