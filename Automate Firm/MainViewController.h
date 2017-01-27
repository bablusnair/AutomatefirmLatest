//
//  ViewController.h
//  Automate Firm
//
//  Created by leonine on 11/08/15.
//  Copyright (c) 2015 leonine. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ViewController.h"
#import "connectionclass.h"

@interface MainViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate,headerprotocol>

@property(nonatomic,retain)connectionclass *myconnection;

@property(nonatomic,assign)NSInteger currentbuttontag;
-(IBAction)staffing:(id)sender;

- (IBAction)documentation:(id)sender;


-(IBAction)notificationButtonaction:(id)sender;
@property(nonatomic,retain)IBOutlet UIScrollView *myscrollview;
@property(nonatomic,assign)int x;

@property(nonatomic,retain)IBOutlet UITableView *mytableview;

@property(nonatomic,retain) NSMutableArray *iconimagearray;

@property(nonatomic,retain) IBOutlet UIButton *reportbutton;
@property(nonatomic,retain) IBOutlet UIButton *paperworkbutton;
@property(nonatomic,retain) IBOutlet UIButton *projectbutton;
@property(nonatomic,retain) IBOutlet UIButton *staffingbutton;
@property(nonatomic,retain) IBOutlet UIButton *taskbutton;
@property(nonatomic,retain) IBOutlet UIButton *survillancebutton;
@property(nonatomic,retain) IBOutlet UIButton *marketingbutton;
@property(nonatomic,retain) IBOutlet UIButton *inventarybutton;

-(IBAction)Mainnotificationbuttonaction:(id)sender;

-(IBAction)logoutAction:(id)sender;

@property(nonatomic,retain) IBOutlet UILabel *headinglabel;



@property(nonatomic,retain)IBOutlet UITableView *colorTC;
@property(nonatomic,retain)IBOutlet UITextField *colorText;
@property(nonatomic,retain)NSMutableArray *colorArray;
@property (weak, nonatomic) IBOutlet UIButton *cartButon;
@end

