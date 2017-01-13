//
//  fineSettingsInnerViewClass.h
//  Automate Firm
//
//  Created by leonine on 1/19/16.
//  Copyright © 2016 leonine. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface fineSettingsInnerViewClass : UIView<UITextFieldDelegate>
//-(IBAction)saveAction:(id)sender;
//-(IBAction)switchAction:(id)sender;
@property(nonatomic,retain)IBOutlet UIButton *switchButton;
@property(nonatomic,retain)NSMutableArray *fineArray;
@property(nonatomic,retain)IBOutlet UIScrollView *scrollView;
@property(nonatomic,retain)IBOutlet UITextField *activeField;

@property(nonatomic,retain)IBOutlet UITextField *violationNameText;
@property(nonatomic,retain)IBOutlet UITextField *fineAmountText;
@property(nonatomic,retain)IBOutlet UITextField *maxWarningText;
@property(nonatomic,retain)IBOutlet UITextField *maxInstallmentText;
@property(nonatomic,retain)IBOutlet UITextField *descriptionText;
//-(IBAction)valueChangedAction:(id)sender;

@property(nonatomic,assign)int s1;
@end
