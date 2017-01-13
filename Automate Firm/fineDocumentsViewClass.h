//
//  fineDocumentsViewClass.h
//  Automate Firm
//
//  Created by Ambu Vamadevan on 29/04/2016.
//  Copyright © 2016 leonine. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DocumentTile.h"
@interface fineDocumentsViewClass : UIView<UITextViewDelegate>
{
    DocumentTile *accordion;
}
@property(nonatomic,retain)IBOutlet UILabel *leaveNameLabel;
@property(nonatomic,retain)IBOutlet UILabel *leaveTypeLabel;
@property(nonatomic,retain)IBOutlet UILabel *descriptionLabel;
-(IBAction)doneButtonAction:(id)sender;
-(IBAction)cancelButtonAction:(id)sender;

@end
