//
//  customPaperworkRuleClass.h
//  Automate Firm
//
//  Created by leonine on 16/09/16.
//  Copyright © 2016 leonine. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface customPaperworkRuleClass : UIView


@property(nonatomic,retain)IBOutlet UIView *popUpView;
@property(nonatomic,retain)IBOutlet UITableView *popupTableView;

-(IBAction)saveButton:(id)sender;
-(IBAction)cancelButton:(id)sender;

-(IBAction)flowActionButton:(id)sender;
@property(nonatomic,retain)IBOutlet UIButton *flow1Button;
@property(nonatomic,retain)IBOutlet UIButton *flow2Button;
@property(nonatomic,retain)IBOutlet UIButton *flow3Button;
@property(nonatomic,retain)IBOutlet UIButton *flow4Button;
@property(nonatomic,retain)IBOutlet UIButton *flow5Button;
@property(nonatomic,retain)IBOutlet UIImageView *flowImage1;
@property(nonatomic,retain)IBOutlet UIImageView *flowImage2;
@property(nonatomic,retain)IBOutlet UIImageView *flowImage3;
@property(nonatomic,retain)IBOutlet UIImageView *flowImage4;


@property(nonatomic,assign)int p;
@property(nonatomic,assign)int q;
@property(nonatomic,assign)int r;
@property(nonatomic,assign)int s;
@property(nonatomic,assign)int t;
@property(nonatomic,assign)int buttonFlag;

@property(nonatomic,retain)NSMutableArray *popupArray;


@end
