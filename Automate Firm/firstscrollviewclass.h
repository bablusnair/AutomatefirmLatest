//
//  firstscrollviewclass.h
//  bablusdemokpproject
//
//  Created by leonine on 7/9/15.
//  Copyright (c) 2015 Emvigo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "newearningscellclass.h"
//#import "secondcellclass.h"
@interface firstscrollviewclass : UIView<UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic) IBOutlet UITableView *firstTableView;
@property(nonatomic,retain)NSMutableArray *firstArray;
@property (strong, nonatomic) IBOutlet UITableView *secondTableView;
@property(nonatomic,retain)NSMutableArray *secondArray;
@property(nonatomic,retain)NSMutableArray *categoryarray;
@property(nonatomic,assign)int x;




@property(nonatomic,retain)IBOutlet UILabel *salaryLabel;
@property(nonatomic,retain)IBOutlet UILabel *monthlyLabel;
@property(nonatomic,retain)IBOutlet UILabel *bankNameLabel;
@property(nonatomic,retain)IBOutlet UILabel *bankAccountNoLabel;
@property(nonatomic,retain)IBOutlet UILabel *pfNoLabel;
@property(nonatomic,retain)IBOutlet UILabel *incomeTaxLabel;
@property(nonatomic,retain)IBOutlet UILabel *nationalIDLabel;
@property(nonatomic,retain)IBOutlet UILabel *passportNoLabel;
@property(nonatomic,retain)IBOutlet UILabel *visaExpiryLabel;
@property(nonatomic,retain)IBOutlet UILabel *labourCardLabel;



@property(nonatomic,retain)NSMutableDictionary *detailsDict;
-(void)displayDetails;
@end
