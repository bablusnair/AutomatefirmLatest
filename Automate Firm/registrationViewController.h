//
//  registrationViewController.h
//  Automate Firm
//
//  Created by leonine on 11/10/16.
//  Copyright © 2016 leonine. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "connectionclass.h"
#import "headerprotocol.h"

@interface registrationViewController : UIViewController<headerprotocol>
@property(nonatomic,retain)connectionclass *myconnection;
@property (weak, nonatomic) IBOutlet UITextField *cmpnyIdText;
@property (weak, nonatomic) IBOutlet UITextField *empIdText;
@property (weak, nonatomic) IBOutlet UITextField *authCodeText;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *empCodeLabel;
@property (weak, nonatomic) IBOutlet UILabel *firmLabel;
@property (weak, nonatomic) IBOutlet UILabel *workingPremiseLabel;
@property (weak, nonatomic) IBOutlet UILabel *departmntLabel;
@property (weak, nonatomic) IBOutlet UILabel *catgryLabel;
@property (weak, nonatomic) IBOutlet UILabel *designationLabel;
@property(nonatomic,assign)int x;
@property (weak, nonatomic) IBOutlet UIImageView *paswrdImage;
@property (weak, nonatomic) IBOutlet UIImageView *phnImage;
@property (weak, nonatomic) IBOutlet UITextField *phoneText;
@property (weak, nonatomic) IBOutlet UIButton *resendButn;
@property (weak, nonatomic) IBOutlet UIButton *okButon;
@property (strong, nonatomic) IBOutlet UIView *regstrationSubview;
- (IBAction)registerCmpleteAction:(id)sender;
@property (strong, nonatomic) IBOutlet UIScrollView *regScrollView;
@property (strong, nonatomic) IBOutlet UITextField *paswrdText;
@property (strong, nonatomic) IBOutlet UITextField *languageText;

@end
