//
//  documentationfronttablecellviewclass.h
//  Automate Firm
//
//  Created by Ambu Vamadevan on 17/08/2016.
//  Copyright © 2016 leonine. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "docuviewclass.h"
@interface documentationfronttablecellviewclass : UITableViewCell
- (void)setCollectionData:(NSArray *)collectionData;
@property (strong, nonatomic) docuviewclass *collectionView;
@property(nonatomic,assign)NSInteger tagvalue;
@end
