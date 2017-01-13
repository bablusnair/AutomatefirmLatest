//
//  portalSettingsViewClass.h
//  Automate Firm
//
//  Created by Ambu Vamadevan on 25/04/2016.
//  Copyright © 2016 leonine. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "connectionclass.h"
#import "headerprotocol.h"
@interface portalSettingsViewClass : UIView<UITextFieldDelegate,UITableViewDataSource,UITableViewDelegate,headerprotocol>
@property(nonatomic,retain)connectionclass *myconnection;

-(IBAction)doneButton:(id)sender;
-(IBAction)cancelButton:(id)sender;

-(IBAction)editPictureAction:(id)sender;
@property(nonatomic,retain)IBOutlet UIButton *profileButton;
-(IBAction)editCheckoutAction:(id)sender;
@property(nonatomic,retain)IBOutlet UIButton *checkoutButton;

@property(nonatomic,assign)int x;
@property(nonatomic,assign)int y;

@property(nonatomic,retain)IBOutlet UILabel *canEditLabel;
@property(nonatomic,retain)IBOutlet UILabel *allowLabel;

-(IBAction)checkBoxAction:(id)sender;
@property(nonatomic,retain)IBOutlet UIButton *checkButton1;
@property(nonatomic,retain)IBOutlet UIButton *checkButton2;
@property(nonatomic,retain)IBOutlet UIButton *checkButton3;
@property(nonatomic,retain)IBOutlet UIButton *checkButton4;
@property(nonatomic,retain)IBOutlet UIButton *checkButton5;
@property(nonatomic,retain)IBOutlet UIButton *checkButton6;
@property(nonatomic,retain)IBOutlet UIButton *checkButton7;
@property(nonatomic,retain)IBOutlet UIButton *checkButton8;
@property(nonatomic,retain)IBOutlet UIButton *checkButton9;
@property(nonatomic,retain)IBOutlet UIButton *checkButton10;
@property(nonatomic,retain)IBOutlet UIButton *checkButton11;
@property(nonatomic,retain)IBOutlet UIButton *checkButton12;
@property(nonatomic,assign)int check1;
@property(nonatomic,assign)int check2;
@property(nonatomic,assign)int check3;
@property(nonatomic,assign)int check4;
@property(nonatomic,assign)int check5;
@property(nonatomic,assign)int check6;
@property(nonatomic,assign)int check7;
@property(nonatomic,assign)int check8;
@property(nonatomic,assign)int check9;
@property(nonatomic,assign)int check10;
@property(nonatomic,assign)int check11;
@property(nonatomic,assign)int check12;

@property(nonatomic,retain)IBOutlet UITableView *workStatusTC;
@property(nonatomic,retain)IBOutlet UITextField *workStatusText;
@property(nonatomic,retain)NSMutableArray *workStatusDropArray;

@property(nonatomic,retain)IBOutlet UITableView *leadershipTC;
@property(nonatomic,retain)IBOutlet UITextField *leadershipText;
@property(nonatomic,retain)NSMutableArray *leadershipArray1;
@property(nonatomic,retain)NSMutableArray *leadershipArray2;



@property(nonatomic,assign)int pictureValue;
@property(nonatomic,assign)int personalValue;
@property(nonatomic,assign)int nomineeValue;
@property(nonatomic,assign)int homeAddressValue;
@property(nonatomic,assign)int educationValue;
@property(nonatomic,assign)int contactValue;
@property(nonatomic,assign)int localAddressValue;
@property(nonatomic,assign)int skillsValue;
@property(nonatomic,assign)int checkoutValue;
@property(nonatomic,assign)int workStatusValue;
@property(nonatomic,assign)int leadershipValue;
@property(nonatomic,assign)int payValue;
@property(nonatomic,assign)int overtimeValue;
@property(nonatomic,assign)int shiftValue;
@property(nonatomic,assign)int weekValue;
@property(nonatomic,assign)int leavesValues;


@end
