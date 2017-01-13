//
//  deductionsViewClass.h
//  Automate Firm
//
//  Created by Ambu Vamadevan on 09/04/2016.
//  Copyright © 2016 leonine. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "deductionsTileClass.h"
#import "AppDelegate.h"
#import "connectionclass.h"

@interface deductionsViewClass : UIView<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate,headerprotocol>
{
     deductionsTileClass *accordion;
    AppDelegate *app;

}
-(IBAction)cancel:(id)sender;
-(IBAction)done:(id)sender;
@property(nonatomic,retain)connectionclass *myconnection;
@property(nonatomic,retain)NSMutableArray *deductionstypearray;
@property(nonatomic,retain)NSMutableArray *descriptionMessageArray;
@property(nonatomic,retain) IBOutlet UITableView *mytableview;
@property(nonatomic,retain) IBOutlet UITextField *deductionTypeText;
@property(nonatomic,retain) IBOutlet UILabel *descriptionlabel;
@property (weak, nonatomic) IBOutlet UITextField *deductionnameText;
@property (weak, nonatomic) IBOutlet UITextField *abbrvationText;
-(void)disableDropDown;
-(void)enableDropDown;
@property(nonatomic,retain)NSString *cancelflag;
@property (strong, nonatomic) IBOutlet UIButton *plusButton;
- (IBAction)addNewTile:(id)sender;
@end
