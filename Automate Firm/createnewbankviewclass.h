//
//  createnewbankviewclass.h
//  Automate Firm
//
//  Created by leonine on 20/11/15.
//  Copyright © 2015 leonine. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "connectionclass.h"
#import "AppDelegate.h"
@interface createnewbankviewclass : UIView<headerprotocol,UITextFieldDelegate>
@property(nonatomic,retain)connectionclass *myconnection; // Creating an object of connection class
@property(nonatomic,retain)AppDelegate *app; //Creating an appdelegate object

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic)  UITextField *activeField;

@property (strong, nonatomic) IBOutlet UITextField *bankNameText;
@property (strong, nonatomic) IBOutlet UITextField *AbbrvText;
@property (strong, nonatomic) IBOutlet UITextField *branchText;
@property (strong, nonatomic) IBOutlet UITextField *descriptionText;
@property (strong, nonatomic) IBOutlet UITextField *holderNameText;
@property (strong, nonatomic) IBOutlet UITextField *accountNumberText;
@property (strong, nonatomic) IBOutlet UITextField *ibanText;
@property (strong, nonatomic) IBOutlet UITextField *bicText;
@property (strong, nonatomic) IBOutlet UITextField *addressText;

@property(nonatomic,retain)NSString *createdDate;

-(IBAction)cancel:(id)sender;
-(IBAction)doneButtonAction:(id)sender;
@end
