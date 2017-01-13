//
//  documentationIndividualSelectionViewClass.h
//  bablusdemokpproject
//
//  Created by leonine on 7/21/15.
//  Copyright (c) 2015 Emvigo. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "documentsRemarksTableCell.h"
@interface documentationIndividualSelectionViewClass : UIView<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate>

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
@end
