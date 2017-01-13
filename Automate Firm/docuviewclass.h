//
//  docuviewclass.h
//  Automate Firm
//
//  Created by Ambu Vamadevan on 17/08/2016.
//  Copyright © 2016 leonine. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "connectionclass.h"
@interface docuviewclass : UIView<UICollectionViewDataSource, UICollectionViewDelegate,UITextFieldDelegate,headerprotocol>
- (void)setCollectionData:(NSArray *)data;
@property (weak, nonatomic) IBOutlet UICollectionView *mycollectionView;
@property (strong, nonatomic) NSArray *mycollectionData1;
@property (strong, nonatomic)NSMutableArray *imgarray;

@property (retain, nonatomic) NSMutableArray *selectedarray;

@property (retain, nonatomic) NSMutableArray *selectedarray2;

@property (retain, nonatomic) NSMutableDictionary *selecteddictionary;
@property(nonatomic,retain)NSMutableArray *strorearray;
@property(nonatomic,retain)connectionclass *myconnection;
@end
