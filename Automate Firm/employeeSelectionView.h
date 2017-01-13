//
//  employeeSelectionView.h
//  Automate Firm
//
//  Created by leonine on 6/22/16.
//  Copyright © 2016 leonine. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "connectionclass.h"


@interface employeeSelectionView : UIView<UITableViewDataSource,UITableViewDelegate,headerprotocol>
@property(nonatomic,retain)connectionclass *myconnection;

@property(nonatomic,retain)IBOutlet UITableView *myTableView;
@property(nonatomic,retain)IBOutlet UITextField *searchTextField;


@property(nonatomic,retain)NSMutableArray *nameArray;



@property (strong, nonatomic) NSMutableArray *filterarray;
@property(nonatomic,assign)int x;
@property(nonatomic,assign)int flag;

@property(nonatomic,retain)NSString *selectedString;

@property (strong, nonatomic)NSMutableDictionary *maindictionary;



-(IBAction)doneButtonAction:(id)sender;

@end
