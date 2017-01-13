//
//  createnewdesignationviewclass.h
//  Automate Firm
//
//  Created by leonine on 18/11/15.
//  Copyright © 2015 leonine. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "connectionclass.h"
#import "MBProgressHUD.h"
@interface createnewdesignationviewclass : UIView<UITableViewDelegate,UITableViewDataSource,UITextViewDelegate,UITextFieldDelegate,headerprotocol,UIGestureRecognizerDelegate>
{
    MBProgressHUD *HUD; //Creating an object of progress hud
}

@property(nonatomic,retain) connectionclass *myconnection;

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic)  UITextField *activeField;

@property (weak, nonatomic) IBOutlet UITableView *jobdescriptiontableview;

@property (weak, nonatomic) IBOutlet UITextView *jobdescriptiontextfield;
@property (weak, nonatomic) IBOutlet UITextView *descriptiontextview;
@property(nonatomic,retain) IBOutlet UITextField *designationTitle;
@property(nonatomic,retain)IBOutlet UITextField *jobCodeText;

@property(nonatomic,retain)NSMutableArray *jobdescriptionarray;
@property(nonatomic,retain)NSMutableArray *responsilityIDArray;
@property(nonatomic,retain)NSMutableArray *jobtittlearray;

@property(nonatomic,retain)NSString *desigID;

@property(nonatomic,retain)IBOutlet UIButton *addNewDescriptionButton;

@property(weak, nonatomic) UIView *activeTextView;


@property(nonatomic,retain)NSIndexPath *inPath;

-(IBAction)doneButtonAction:(id)sender;
-(IBAction)cancel:(id)sender;
-(IBAction)addnewjobdescription:(id)sender;

-(IBAction)jobDescriptionEndEditing:(id)sender;

@property(nonatomic,retain)NSString *responsibilityText;
@property(nonatomic,retain)NSString *responsibilityID;

@end
