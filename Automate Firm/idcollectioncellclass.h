//
//  idcollectioncellclass.h
//  bablusdemokpproject
//
//  Created by leonine on 24/06/15.
//  Copyright (c) 2015 Emvigo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface idcollectioncellclass : UICollectionViewCell
@property(nonatomic,retain)IBOutlet UILabel *employeename;
@property(nonatomic,retain)IBOutlet UILabel *designationtittle;
@property(nonatomic,retain)IBOutlet UILabel *employeeid;

@property(nonatomic,retain)IBOutlet UILabel *dataofjoined;
@property(nonatomic,retain)IBOutlet UILabel *dateofbirth;
@property(nonatomic,retain)IBOutlet UILabel *bloodgroup;
@property(nonatomic,retain)IBOutlet UILabel *buildinglabel;
@property(nonatomic,retain)IBOutlet UILabel *countrylabel;
@property(nonatomic,retain)IBOutlet UILabel *phonenumberlabel;
@property(nonatomic,retain)IBOutlet UIImageView *myimg;
@end
