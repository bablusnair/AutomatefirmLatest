//
//  documentationFormCreationClass.h
//  Automate Firm
//
//  Created by leonine on 6/16/16.
//  Copyright © 2016 leonine. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface documentationFormCreationClass : UIView<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate>

@property(nonatomic,retain)IBOutlet UITableView *firstTableView;
@property(nonatomic,retain)IBOutlet UITableView *secondTableView;
@property(nonatomic,retain)NSMutableArray *firstArray;
-(IBAction)tileButtonClicked:(id)sender;
@property(nonatomic,assign)int x;
@property(nonatomic,retain)IBOutlet UIScrollView *myscrollView;
@property(nonatomic,retain)IBOutlet UIView *firstView;
@property(nonatomic,retain)IBOutlet UIView *contentview;
-(IBAction)forwardbuttonaction:(id)sender;
-(IBAction)prioritybutton1action:(id)sender;
-(IBAction)prioritybutton2action:(id)sender;
-(IBAction)prioritybutton3action:(id)sender;
@property(nonatomic,retain)IBOutlet UIButton *priorityButton1;
@property(nonatomic,retain)IBOutlet UIButton *priorityButton2;
@property(nonatomic,retain)IBOutlet UIButton *priorityButton3;
-(IBAction)signatureAction:(id)sender;
-(IBAction)stampButtonAction:(id)sender;





-(IBAction)closeButton:(id)sender;
@property(nonatomic,retain)IBOutlet UIView *toView;
@property(nonatomic,retain)IBOutlet UIView *fromView;
@property(nonatomic,retain)IBOutlet UIView *subjectView;
@property(nonatomic,retain)IBOutlet UIView *messageRemainingView;
@property(nonatomic,retain)IBOutlet UITableView *toTableView;
-(IBAction)dropDown1Action:(id)sender;
@property(nonatomic,retain)NSMutableArray *toArray;
@property(nonatomic,retain)NSMutableArray *fromArray;
@property(nonatomic,retain)IBOutlet UITextView *toTextView;
@property(nonatomic,retain)IBOutlet UITextView *fromTextView;
@property(nonatomic,retain)IBOutlet UILabel *toLabel;
@property(nonatomic,retain)IBOutlet UILabel *fromLabel;
@property(nonatomic,retain)IBOutlet UILabel *subjectLabel;
@property(nonatomic,retain)IBOutlet UIButton *subjectButton;
@property(nonatomic,retain)IBOutlet UIButton *combo1;
@property(nonatomic,retain)IBOutlet UITextField *dateText;

@property(nonatomic,retain)IBOutlet UIDatePicker *datePicker;
@property(nonatomic,retain)IBOutlet UIView *datePickerView;
-(IBAction)datePickerAction:(id)sender;
@property(nonatomic,assign)int x1;
@property(nonatomic,assign)int y;





@end
