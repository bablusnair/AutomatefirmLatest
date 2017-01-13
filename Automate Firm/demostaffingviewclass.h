//
//  demostaffingviewclass.h
//  bablusdemokpproject
//
//  Created by leonine on 24/03/15.
//  Copyright (c) 2015 Emvigo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface demostaffingviewclass : UIView
@property (weak, nonatomic) IBOutlet UIView *employeelistview;
-(IBAction)employeetimecardbuttonaction:(id)sender;
@property(nonatomic,assign)int x;
@property(nonatomic,assign)int k;
@property(nonatomic,assign)int y;
@property (weak, nonatomic) IBOutlet UIButton *timecardbutton;
@property (weak, nonatomic) IBOutlet UILabel *timecardlabel;
@property (weak, nonatomic) IBOutlet UIImageView *timecardimgview;

-(IBAction)filterbuttonaction:(id)sender;
@property(nonatomic,retain)IBOutlet UITextField *searchfield;

-(IBAction)presentViewpopup:(id)sender;

@property (weak, nonatomic) IBOutlet UIImageView *searchicon;

-(void)setimageandsearchvalue:(NSString *)searchedvalue and:(NSString *)imagestring;


-(void)forfilterviewdoneaction;
@end
