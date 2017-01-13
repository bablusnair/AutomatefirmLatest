//
//  performanceInnerViewClass.h
//  Automate Firm
//
//  Created by Ambu Vamadevan on 29/04/2016.
//  Copyright © 2016 leonine. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface performanceInnerViewClass : UIView<UITableViewDataSource,UITableViewDelegate,UITextViewDelegate>
@property(nonatomic,retain)IBOutlet UIScrollView *scrollView;
@property(nonatomic,retain)IBOutlet UITextField *activeField;


-(IBAction)saveButtonAction:(id)sender;
@property(nonatomic,retain)IBOutlet UITableView *inputTC;
@property(nonatomic,retain)NSMutableArray *inputQuestionArray;
@property(nonatomic,retain)NSMutableArray *mandatoryIconArray;
-(IBAction)mandatoryButtonAction:(id)sender;
@end
