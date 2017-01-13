//
//  earningsview.h
//  Automate Firm
//
//  Created by Ambu Vamadevan on 05/04/2016.
//  Copyright © 2016 leonine. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "earningsAccordianview.h"
#import "AppDelegate.h"
#import "connectionclass.h"

@interface earningsview : UIView<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate,headerprotocol>
{
    earningsAccordianview *accordion;
    AppDelegate *app;

}

-(IBAction)cancel:(id)sender;
-(IBAction)done:(id)sender;
@property(nonatomic,retain)connectionclass *myconnection;
@property(nonatomic,retain)NSMutableArray *earningstypearray;
@property(nonatomic,retain)NSMutableArray *descriptionMessageArray;
@property(nonatomic,retain) IBOutlet UITableView *mytableview;
@property(nonatomic,retain) IBOutlet UITextField *earningstypetext;
@property(nonatomic,retain) IBOutlet UILabel *descriptionlabel;
@property (weak, nonatomic) IBOutlet UITextField *earningNameText;
@property (weak, nonatomic) IBOutlet UITextField *earningAbbrText;
@property (strong, nonatomic) IBOutlet UIButton *plusButton;
@property(nonatomic,retain)NSString *cancelflag;
- (IBAction)addNewTile:(id)sender;

-(void)disableDropDown;
-(void)enableDropDown;

@end
