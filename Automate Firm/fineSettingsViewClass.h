//
//  fineSettingsViewClass.h
//  Automate Firm
//
//  Created by leonine on 1/19/16.
//  Copyright © 2016 leonine. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "fineTileClass.h"
#import "connectionclass.h"
@interface fineSettingsViewClass : UIView<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate,headerprotocol>
{
     fineTileClass *accordion;
}
@property(nonatomic,retain)connectionclass *myconnection;
-(IBAction)cancelAction:(id)sender;
-(IBAction)doneAction:(id)sender;
@property(nonatomic,retain)NSMutableArray * maximumwarningArray;
@property (weak, nonatomic) IBOutlet UITextField *fineNameTest;
@property (weak, nonatomic) IBOutlet UITextField *fineAmountText;
@property (weak, nonatomic) IBOutlet UITextField *maxWarningText;
@property (weak, nonatomic) IBOutlet UITextField *maxInstallmentText;
@property (weak, nonatomic) IBOutlet UITextField *descriptiontext;
@property (weak, nonatomic) IBOutlet UITableView *maxwarningTableView;
@property(nonatomic,retain)IBOutlet UIScrollView *scrollView;
@property(nonatomic,retain)IBOutlet UITextField *activeField;

@end
