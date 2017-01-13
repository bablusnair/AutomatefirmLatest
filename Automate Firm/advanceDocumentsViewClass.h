//
//  advanceDocumentsViewClass.h
//  Automate Firm
//
//  Created by Ambu Vamadevan on 28/04/2016.
//  Copyright © 2016 leonine. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "advanceDocumentTile.h"
@interface advanceDocumentsViewClass : UIView<UITextViewDelegate>
{
    advanceDocumentTile *accordion;
}
@property(nonatomic,retain)IBOutlet UILabel *leaveNameLabel;
@property(nonatomic,retain)IBOutlet UILabel *leaveTypeLabel;
@property(nonatomic,retain)IBOutlet UITextView *declarationText;
@property(nonatomic,retain)IBOutlet UIView *declarationView;
-(IBAction)doneButtonAction:(id)sender;
-(IBAction)cancelButtonAction:(id)sender;

@end
