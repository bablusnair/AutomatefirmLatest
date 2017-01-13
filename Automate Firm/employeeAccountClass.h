//
//  employeeAccountClass.h
//  bablusdemokpproject
//
//  Created by leonine on 8/22/15.
//  Copyright (c) 2015 Emvigo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "designationTableViewCell.h"
#import "AppDelegate.h"
#import "connectionclass.h"
@interface employeeAccountClass : UIView<UITableViewDelegate,UITableViewDataSource,UITextViewDelegate,headerprotocol>
@property(nonatomic,retain)connectionclass *myconnection;
@property(nonatomic,retain)AppDelegate *app;
@property(nonatomic,retain)IBOutlet UITableView *descriptionTC;
@property(nonatomic,retain)NSMutableArray *descriptionArray;
@property(nonatomic,assign)int flag;
@property(nonatomic,retain)NSString *empID;

-(IBAction)plusDescription:(id)sender;
-(IBAction)saveDescription:(id)sender;
@property(nonatomic,retain)IBOutlet UIButton *saveButton;

@end
