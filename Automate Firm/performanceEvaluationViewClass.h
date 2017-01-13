//
//  performanceEvaluationViewClass.h
//  Automate Firm
//
//  Created by Ambu Vamadevan on 29/04/2016.
//  Copyright © 2016 leonine. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "performanceEvaluationTile.h"
@interface performanceEvaluationViewClass : UIView<UITextViewDelegate>
{
    performanceEvaluationTile *accordion;
}
@property(nonatomic,retain)IBOutlet UILabel *leaveNameLabel;
@property(nonatomic,retain)IBOutlet UILabel *leaveTypeLabel;
@property(nonatomic,retain)IBOutlet UILabel *descriptionLabel;
-(IBAction)doneButtonAction:(id)sender;
-(IBAction)cancelButtonAction:(id)sender;
-(IBAction)button1Action:(id)sender;
@property(nonatomic,retain)IBOutlet UIButton *button1;

-(IBAction)button2Action:(id)sender;
@property(nonatomic,retain)IBOutlet UIButton *button2;


@property(nonatomic,retain)IBOutlet UIView *popUpView;
@property(nonatomic,retain)IBOutlet UITableView *popupTableView;
@property(nonatomic,retain)NSMutableArray *popupArray;

@property(nonatomic,retain)IBOutlet UIImageView *arrowImage1;
@property(nonatomic,retain)IBOutlet UIImageView *arrowImage2;
@property(nonatomic,retain)IBOutlet UIImageView *arrowImage3;

@property(nonatomic,assign)int buttonFlag;
@property(nonatomic,assign)int x;
@property(nonatomic,assign)int y;

-(IBAction)checkButtonAction:(id)sender;
@property(nonatomic,retain)IBOutlet UIButton *checkButton1;
@property(nonatomic,retain)IBOutlet UIButton *checkButton2;
@property(nonatomic,assign)int checkFlag1;
@property(nonatomic,assign)int checkFlag2;
@end
