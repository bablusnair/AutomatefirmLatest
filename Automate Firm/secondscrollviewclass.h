//
//  secondscrollviewclass.h
//  bablusdemokpproject
//
//  Created by leonine on 7/9/15.
//  Copyright (c) 2015 Emvigo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "secondscrollfirstcellclass.h"
@interface secondscrollviewclass : UIView<UITableViewDataSource,UITableViewDelegate>
@property (strong, nonatomic) IBOutlet UITableView *firstTableView;
@property(nonatomic,retain)NSMutableArray *degreeArray;
@property(nonatomic,retain)NSMutableArray *institutionArray;
@property(nonatomic,retain)NSMutableArray *yearArray;
@property (strong, nonatomic) IBOutlet UITableView *secondtableview;
@property(nonatomic,retain)NSMutableArray *descriptionArray;
@property(nonatomic,retain)NSMutableArray *experienceArray;
@property(nonatomic,retain)NSMutableArray *levelArray;


@property (strong, nonatomic) IBOutlet UILabel *companyTelephone;
@property (strong, nonatomic) IBOutlet UILabel *companyExt;
@property (strong, nonatomic) IBOutlet UILabel *companyMobile;
@property (strong, nonatomic) IBOutlet UILabel *personalMobile;
@property (strong, nonatomic) IBOutlet UILabel *companyEmail;
@property (strong, nonatomic) IBOutlet UILabel *personalEmail;
@property (strong, nonatomic) IBOutlet UILabel *nomineeName;
@property (strong, nonatomic) IBOutlet UILabel *nomineeContact;
@property (strong, nonatomic) IBOutlet UILabel *localBlock;
@property (strong, nonatomic) IBOutlet UILabel *localStreet;
@property (strong, nonatomic) IBOutlet UILabel *localBuilding;
@property (strong, nonatomic) IBOutlet UILabel *localFlat;
@property (strong, nonatomic) IBOutlet UILabel *localCity;
@property (strong, nonatomic) IBOutlet UILabel *localPostCode;
@property (strong, nonatomic) IBOutlet UILabel *homeBlock;
@property (strong, nonatomic) IBOutlet UILabel *homeStreet;
@property (strong, nonatomic) IBOutlet UILabel *homeBuilding;
@property (strong, nonatomic) IBOutlet UILabel *homeFlat;
@property (strong, nonatomic) IBOutlet UILabel *homeCity;
@property (strong, nonatomic) IBOutlet UILabel *homePostCode;
@property (strong, nonatomic) IBOutlet UILabel *homeState;
@property (strong, nonatomic) IBOutlet UILabel *homeCountry;
@property(nonatomic,retain)NSMutableDictionary *detailsDict;
@property(nonatomic,retain)NSMutableArray*educationArray;
@property(nonatomic,retain)NSMutableArray *skillsArray;
-(void)displayDetails;



@end
