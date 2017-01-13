//
//  ViewController.h
//  AutomateFirm
//
//  Created by leonine on 12/10/15.
//  Copyright (c) 2015 leonine. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "connectionclass.h"

@interface ViewController : UIViewController<headerprotocol,UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>
-(IBAction)back:(UIStoryboardSegue *)sender;
@property (weak, nonatomic) IBOutlet UITextField *userNameField;
@property (weak, nonatomic) IBOutlet UITextField *paswrdText;
@property(nonatomic,retain)connectionclass *myconnection;
@property (weak, nonatomic) IBOutlet UITextField *officeDropdwnText;
@property (weak, nonatomic) IBOutlet UITableView *officeDropDwnList;
@property(nonatomic,retain)NSMutableArray *officeListAray;
@property(nonatomic,retain)NSMutableDictionary *officeListDictionary;
@property(nonatomic,retain)NSString *officeidString;



- (IBAction)login:(id)sender;

@end

