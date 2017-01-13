//
//  leaveDocumentsClass.h
//  Automate Firm
//
//  Created by leonine on 11/20/15.
//  Copyright © 2015 leonine. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DocumentTile.h"
#import "AppDelegate.h"
#import "connectionclass.h"
@interface leaveDocumentsClass : UIView<UITextViewDelegate,headerprotocol>
{
    DocumentTile *accordion;
    AppDelegate *app;
}

@property(nonatomic,retain)connectionclass *myconnection;



@property(nonatomic,retain)IBOutlet UILabel *leaveNameLabel;
@property(nonatomic,retain)NSString *leaveTypeLabel;
@property(nonatomic,retain)IBOutlet UITextView *declarationText;
@property(nonatomic,retain)IBOutlet UIView *declarationView;
@property(nonatomic,retain)IBOutlet UIButton *plusButton;
-(IBAction)plusButtonAction:(id)sender;
-(IBAction)doneButtonAction:(id)sender;
-(IBAction)cancelButtonAction:(id)sender;
@end
